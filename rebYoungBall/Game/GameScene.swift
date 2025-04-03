import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewModel: GameViewModel?
    
    
    var mapViewModel: MapViewModel!
    private var playerViewModel: PlayerViewModel!
    private var enemyViewModel: EnemyViewModel!
    private var spinnerViewModel: SpinnerViewModel!
    private var moverViewModel: MoverViewModel!
    
    
    private var tileSize: CGFloat = 36 
    
    var gameStateCallback: ((GameState) -> Void)?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        
        backgroundColor = .clear
        view.allowsTransparency = true
        view.backgroundColor = .clear
        
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        let camera = SKCameraNode()
        self.camera = camera
        addChild(camera)
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
        initializeViewModels()
        
        setupGame()
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePlayerMove(_:)),
            name: .playerMoveCommand,
            object: nil
        )
        
        
        resetEnemies()
        resetSpinners()
        
        
        centerCameraAndZoom()
    }
    
    private func initializeViewModels() {
        
        mapViewModel = MapViewModel(tileSize: tileSize)
        playerViewModel = PlayerViewModel(tileSize: tileSize, gameViewModel: viewModel, mapViewModel: mapViewModel)
        enemyViewModel = EnemyViewModel(tileSize: tileSize, gridSize: mapViewModel.gridSize)
        spinnerViewModel = SpinnerViewModel(tileSize: tileSize, gridSize: mapViewModel.gridSize)
        moverViewModel = MoverViewModel(gridSize: mapViewModel.gridSize)
    }
    
    private func setupGame() {
        let level = viewModel?.currentLevel ?? 1
        
        
        if let startPosition = mapViewModel.createMap(for: level, in: self) {
            viewModel?.playerPosition = startPosition
        }
        
        
        let gridSize = mapViewModel.gridSize
        enemyViewModel.updateGridSize(gridSize)
        spinnerViewModel.updateGridSize(gridSize)
        moverViewModel.updateGridSize(gridSize)
        
        
        playerViewModel.createPlayer(in: self)
        enemyViewModel.createEnemies(for: level, in: self)
        spinnerViewModel.createSpinners(for: level, in: self)
        moverViewModel.createMovers(for: level)
        
        
        viewModel?.gameState = .playing
        
        
        checkGameState()
    }
    
    private func createEnemies() {
        
        enemyViewModel.createEnemies(for: viewModel?.currentLevel ?? 1, in: self)
    }
    
    private func createSpinners() {
        
        spinnerViewModel.createSpinners(for: viewModel?.currentLevel ?? 1, in: self)
    }
    
    private func resetEnemies() {
        
        self.enumerateChildNodes(withName: "enemy*") { node, _ in
            node.removeFromParent()
        }
        createEnemies()
    }
    
    private func resetSpinners() {
        
        self.enumerateChildNodes(withName: "spinner*") { node, _ in
            node.removeFromParent()
        }
        createSpinners()
    }
    
    @objc private func handlePlayerMove(_ notification: Notification) {
        guard let direction = notification.object as? Direction,
              let playerPosition = viewModel?.playerPosition,
              let level = viewModel?.currentLevel else { return }
        
        
        let initialPlayerPos = playerPosition
        viewModel?.previousPlayerPosition = initialPlayerPos
        
        
        for enemy in enemyViewModel.enemies {
            enemy.previousGridPosition = enemy.gridPosition
        }
        
        
        var newPlayerPos = initialPlayerPos
        
        switch direction {
        case .up:
            newPlayerPos.row -= 1
        case .down:
            newPlayerPos.row += 1
        case .left:
            newPlayerPos.col -= 1
        case .right:
            newPlayerPos.col += 1
        }
        
        
        let tileType = LevelManager.shared.getTileType(at: newPlayerPos, level: level)
        
        if tileType == .empty {
            viewModel?.playerLost()
            resetLevel()
            return
        }
        
        if !playerViewModel.isValidMove(to: newPlayerPos, level: level) {
            return 
        }
        
        
        var newEnemyPositions: [GridPosition] = []
        for enemy in enemyViewModel.enemies {
            newEnemyPositions.append(enemyViewModel.getEnemyNextPosition(enemy))
        }
        
        
        for (index, enemy) in enemyViewModel.enemies.enumerated() {
            let newEnemyPos = newEnemyPositions[index]
            
            
            if newPlayerPos.row == enemy.gridPosition.row && newPlayerPos.col == enemy.gridPosition.col &&
               newEnemyPos.row == initialPlayerPos.row && newEnemyPos.col == initialPlayerPos.col {
                viewModel?.playerLost()
                resetLevel()
                return
            }
        }
        
        
        viewModel?.playerPosition = newPlayerPos
        playerViewModel.updatePlayerPosition(in: self)
        
        
        let landedOnMover = moverViewModel.getMoverAt(position: newPlayerPos) != nil
        
        
        spinnerViewModel.rotateAllSpinners()
        
        
        enemyViewModel.moveEnemies(with: newEnemyPositions)
        
        
        if spinnerViewModel.checkCollision(at: newPlayerPos) {
            viewModel?.playerLost()
            resetLevel()
            return
        }
        
        
        if enemyViewModel.checkPlayerCollision(at: newPlayerPos) {
            viewModel?.playerLost()
            resetLevel()
            return
        }
        
        
        checkGameState()
        
        
        if landedOnMover, let mover = moverViewModel.getMoverAt(position: newPlayerPos) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.handleMoverInteraction(mover)
            }
        }
    }
    
    private func handleMoverInteraction(_ mover: Mover) {
        
        viewModel?.beginMoverMovement()
        
        
        let destination = mover.getDestinationPosition()
        
        
        let moveAction = SKAction.run { [weak self] in
            guard let self = self, let level = self.viewModel?.currentLevel else { return }
            
            
            let tileType = LevelManager.shared.getTileType(at: destination, level: level)
            
            
            self.viewModel?.playerPosition = destination
            self.playerViewModel.updatePlayerPosition(in: self, withDuration: 0.3)
            
            
            if tileType == .empty {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.viewModel?.playerLost()
                    self.resetLevel()
                }
                return
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                guard let self = self else { return }
                
                
                self.viewModel?.endMoverMovement()
                self.checkGameState() 
                
                
                if let newPosition = self.viewModel?.playerPosition,
                   let nextMover = self.moverViewModel.getMoverAt(position: newPosition) {
                    self.handleMoverInteraction(nextMover)
                }
            }
        }
        
        
        run(moveAction)
    }
    
    private func checkGameState() {
        guard let playerPosition = viewModel?.playerPosition,
              let level = viewModel?.currentLevel else { return }
        
        let tileType = LevelManager.shared.getTileType(at: playerPosition, level: level)
        
        switch tileType {
        case .finish:
            
            viewModel?.playerWon()
        case .trap:
            
            viewModel?.playerLost()
            resetLevel()
        case .empty:
            
            viewModel?.playerLost()
            resetLevel()
        default:
            
            break
        }
        
        
        if enemyViewModel.checkPlayerCollision(at: playerPosition) {
            viewModel?.playerLost()
            resetLevel()
        }
        
        
        if spinnerViewModel.checkCollision(at: playerPosition) {
            viewModel?.playerLost()
            resetLevel()
        }
    }
    
    func resetLevel() {
        
        self.isPaused = true
        removeAllActions()
        
        
        viewModel?.endMoverMovement()
        
        
        viewModel?.beginReset()
        
        
        let level = viewModel?.currentLevel ?? 1
        
        
        let camera = self.camera
        
        
        self.children.forEach { node in
            if node != camera {
                node.removeFromParent()
            }
        }
        
        
        if let camera = camera, camera.parent == nil {
            addChild(camera)
        }
        
        
        initializeViewModels()
        
        
        if let startPosition = mapViewModel.createMap(for: level, in: self) {
            
            viewModel?.playerPosition = startPosition
        }
        
        
        let gridSize = mapViewModel.gridSize
        enemyViewModel.updateGridSize(gridSize)
        spinnerViewModel.updateGridSize(gridSize)
        moverViewModel.updateGridSize(gridSize)
        
        
        playerViewModel.createPlayer(in: self, skipAnimation: true)
        enemyViewModel.createEnemies(for: level, in: self)
        spinnerViewModel.createSpinners(for: level, in: self)
        moverViewModel.createMovers(for: level)
        
        
        centerCameraAndZoom()
        
        
        viewModel?.endReset()
        
        
        self.isPaused = false
    }
    
    func prepareForNextLevel() {
        
        removeAllChildren()
        removeAllActions()
        
        
        viewModel?.beginReset()
        
        
        initializeViewModels()
        setupGame()
        
        
        viewModel?.endReset()
        
        
        centerCameraAndZoom()
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let playerCategory = self.playerViewModel.player?.physicsBody?.categoryBitMask ?? 0
        let trapCategory = self.mapViewModel.trapCategory
        let finishCategory = self.mapViewModel.finishCategory
        
        if collision == playerCategory | trapCategory {
            viewModel?.playerLost()
            resetLevel()
        } else if collision == playerCategory | finishCategory {
            viewModel?.playerWon()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if !isPaused {
            
        }
    }
    
    
    override var isPaused: Bool {
        didSet {
            if isPaused {
                
                let currentCameraPosition = camera?.position
                
                
                enumerateChildNodes(withName: "enemy*") { node, _ in
                    node.isPaused = true
                }
                enumerateChildNodes(withName: "spinner*") { node, _ in
                    node.isPaused = true
                }
                
                
                if let position = currentCameraPosition {
                    camera?.position = position
                }
            } else {
                
                enumerateChildNodes(withName: "enemy*") { node, _ in
                    node.isPaused = false
                }
                enumerateChildNodes(withName: "spinner*") { node, _ in
                    node.isPaused = false
                }
                
                
                DispatchQueue.main.async { [weak self] in
                    self?.centerCameraAndZoom()
                }
            }
        }
    }
    
    
    private func centerCameraAndZoom() {
        guard let camera = self.camera else { return }
        
        
        let level = viewModel?.currentLevel ?? 1
        let levelData = LevelManager.shared.getLevel(level)
        let rows = levelData.tiles.count
        let cols = levelData.tiles.first?.count ?? 1
        
        
        let mapWidth = CGFloat(cols) * tileSize
        let mapHeight = CGFloat(rows) * tileSize
        
        
        let centerX = mapWidth / 2
        let centerY = mapHeight / 2
        
        
        camera.position = CGPoint(x: centerX, y: centerY)
        
        
        let zoomFactor: CGFloat = 0.9 
        camera.setScale(zoomFactor)
        
        
    }
    
    
    private func _legacyCenterCamera() {
        if let camera = self.camera {
            
            let level = viewModel?.currentLevel ?? 1
            let levelData = LevelManager.shared.getLevel(level)
            let rows = levelData.tiles.count
            let cols = levelData.tiles.first?.count ?? 1
            
            
            let centerRow = rows / 2
            let centerCol = cols / 2
            
            
            let x = CGFloat(centerCol) * tileSize
            let y = CGFloat(rows - centerRow) * tileSize
            
            
            camera.position = CGPoint(x: x, y: y)
        }
    }
    
    
    private func calculateTileSize() -> CGFloat {
        return 36 
    }
}
