import SpriteKit
import Foundation

class PlayerViewModel {
    private(set) var player: SKSpriteNode?
    private let tileSize: CGFloat
    private let playerCategory: UInt32 = 0x1 << 0
    
    weak var gameViewModel: GameViewModel?
    weak var mapViewModel: MapViewModel?
    
    init(tileSize: CGFloat, gameViewModel: GameViewModel?, mapViewModel: MapViewModel?) {
        self.tileSize = tileSize
        self.gameViewModel = gameViewModel
        self.mapViewModel = mapViewModel
    }
    
    func createPlayer(in scene: SKScene, skipAnimation: Bool = false) {
        
        player = SKSpriteNode(imageNamed: "player")
        player?.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
        
        
        player?.zPosition = 20
        
        
        scene.addChild(player!)
        
        
        player?.physicsBody = SKPhysicsBody(circleOfRadius: tileSize * 0.4)
        player?.physicsBody?.isDynamic = false
        player?.physicsBody?.affectedByGravity = false
        player?.physicsBody?.allowsRotation = false
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.contactTestBitMask = mapViewModel?.trapCategory ?? 0 | (mapViewModel?.finishCategory ?? 0)
        player?.physicsBody?.collisionBitMask = 0 
        
        
        updatePlayerPosition(in: scene, withDuration: skipAnimation ? 0 : 0.2)
    }
    
    func updatePlayerPosition(in scene: SKScene, withDuration duration: TimeInterval = 0.2) {
        guard let player = player,
              let position = gameViewModel?.playerPosition,
              let mapViewModel = mapViewModel else { return }
        
        
        let targetPoint = mapViewModel.calculatePosition(for: position, in: scene)
        
        if duration <= 0.01 {
            
            player.position = targetPoint
        } else {
            
            let moveAction = SKAction.move(to: targetPoint, duration: duration)
            player.run(moveAction)
        }
    }
    
    func isValidMove(to position: GridPosition, level: Int) -> Bool {
        guard let mapViewModel = mapViewModel else { return false }
        
        
        guard position.row >= 0 && position.row < mapViewModel.gridSize.rows &&
              position.col >= 0 && position.col < mapViewModel.gridSize.cols else {
            return false
        }
        
        let tileType = LevelManager.shared.getTileType(at: position, level: level)
        
        
        return tileType != .empty
    }
}
