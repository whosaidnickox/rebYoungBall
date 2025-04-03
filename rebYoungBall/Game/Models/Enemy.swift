import SpriteKit

class Enemy {
    let node: SKSpriteNode
    var gridPosition: GridPosition
    var previousGridPosition: GridPosition
    private(set) var movePattern: [Direction]
    var patternIndex = 0 
    private let gridSize: (rows: Int, cols: Int)
    private let tileSize: CGFloat
    
    
    private let moveDuration: TimeInterval = 0.3
    
    init(position: GridPosition, movePattern: [Direction], gridSize: (rows: Int, cols: Int), tileSize: CGFloat) {
        self.gridPosition = position
        self.previousGridPosition = position 
        self.movePattern = movePattern
        self.gridSize = gridSize
        self.tileSize = tileSize
        
        self.node = SKSpriteNode(imageNamed: "enemy")
        self.node.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
        
        
        let mapWidth = CGFloat(gridSize.cols) * tileSize
        let mapHeight = CGFloat(gridSize.rows) * tileSize
        let originX = (UIScreen.main.bounds.width - mapWidth) / 2
        let originY = (UIScreen.main.bounds.height - mapHeight) / 2
        
        let x = originX + CGFloat(gridPosition.col) * tileSize + tileSize/2
        let y = originY + CGFloat(gridSize.rows - gridPosition.row - 1) * tileSize + tileSize/2
        
        self.node.position = CGPoint(x: x, y: y)
    }
    
    
    func move(level: Int) {
        guard !movePattern.isEmpty else { return }
        
        
        let direction = movePattern[patternIndex]
        
        
        var newPosition = gridPosition
        
        switch direction {
        case .up:
            newPosition.row -= 1
        case .down:
            newPosition.row += 1
        case .left:
            newPosition.col -= 1
        case .right:
            newPosition.col += 1
        }
        
        
        if isValidMove(to: newPosition, level: level) {
            gridPosition = newPosition
            updateNodePosition()
        }
        
        
        patternIndex = (patternIndex + 1) % movePattern.count
    }
    
    
    func getNextDirection() -> Direction {
        guard !movePattern.isEmpty else { return .right } 
        return movePattern[patternIndex]
    }
    
    
    
    func isValidMove(to position: GridPosition, level: Int) -> Bool {
        
        guard position.row >= 0 && position.row < gridSize.rows &&
            position.col >= 0 && position.col < gridSize.cols else {
            return false
        }
        
        
        let tileType = LevelManager.shared.getTileType(at: position, level: level)
        return tileType != .empty
    }
    
    
    func updateNodePosition() {
        if let scene = node.scene as? GameScene {
            let newPosition = scene.mapViewModel.calculatePosition(for: gridPosition, in: scene)
            
            
            let moveAction = SKAction.move(to: newPosition, duration: moveDuration)
            
            
            let scaleDown = SKAction.scale(to: 0.85, duration: moveDuration * 0.4)
            let scaleUp = SKAction.scale(to: 1.0, duration: moveDuration * 0.6)
            let scaleSequence = SKAction.sequence([scaleDown, scaleUp])
            
            
            let actionGroup = SKAction.group([moveAction, scaleSequence])
            
            
            node.run(actionGroup)
        } else {
            
            let sceneSize = node.scene?.size ?? CGSize(width: 1080, height: 1920)
            let originX = -CGFloat(gridSize.cols) * tileSize / 2 + sceneSize.width / 2
            let originY = -CGFloat(gridSize.rows) * tileSize / 2 + sceneSize.height / 2
            
            let x = originX + CGFloat(gridPosition.col) * tileSize + tileSize/2
            let y = originY + CGFloat(gridSize.rows - gridPosition.row - 1) * tileSize + tileSize/2
            
            node.position = CGPoint(x: x, y: y)
        }
    }
}
