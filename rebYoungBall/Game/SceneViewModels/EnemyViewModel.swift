import SpriteKit
import Foundation

class EnemyViewModel {
    private(set) var enemies: [Enemy] = []
    private let enemyCategory: UInt32 = 0x1 << 1
    private let tileSize: CGFloat
    private var gridSize: (rows: Int, cols: Int)
    
    init(tileSize: CGFloat, gridSize: (rows: Int, cols: Int)) {
        self.tileSize = tileSize
        self.gridSize = gridSize
    }
    
    func updateGridSize(_ newSize: (rows: Int, cols: Int)) {
        gridSize = newSize
    }
    
    func createEnemies(for level: Int, in scene: SKScene) {
        
        enemies.removeAll()
        
        let enemyData = LevelManager.shared.getEnemies(for: level)
        
        for data in enemyData {
            let enemy = Enemy(
                position: data.startPosition,
                movePattern: data.movePattern,
                gridSize: gridSize,
                tileSize: tileSize
            )
            
            
            enemy.node.name = "enemy_\(UUID().uuidString)"
            
            
            enemy.node.zPosition = 20
            
            
            enemy.node.physicsBody = SKPhysicsBody(circleOfRadius: tileSize * 0.4)
            enemy.node.physicsBody?.isDynamic = false
            enemy.node.physicsBody?.affectedByGravity = false
            enemy.node.physicsBody?.allowsRotation = false
            enemy.node.physicsBody?.categoryBitMask = enemyCategory
            enemy.node.physicsBody?.contactTestBitMask = 0 
            enemy.node.physicsBody?.collisionBitMask = 0
            
            
            scene.addChild(enemy.node)
            enemies.append(enemy)
            
            
            if let gameScene = scene as? GameScene {
                let position = gameScene.mapViewModel.calculatePosition(for: data.startPosition, in: scene)
                enemy.node.position = position
            }
        }
    }
    
    func getEnemyNextPosition(_ enemy: Enemy) -> GridPosition {
        if enemy.movePattern.isEmpty {
            return enemy.gridPosition
        }
        
        
        let direction = enemy.getNextDirection()
        
        
        var newPosition = enemy.gridPosition
        
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
        
        

        return newPosition




    }
    
    func moveEnemies(with newPositions: [GridPosition]) {
        for (index, enemy) in enemies.enumerated() {
            if index < newPositions.count {
                let newPos = newPositions[index]
                enemy.previousGridPosition = enemy.gridPosition 
                enemy.gridPosition = newPos
                enemy.updateNodePosition()
                
                
                if !enemy.movePattern.isEmpty {
                    enemy.patternIndex = (enemy.patternIndex + 1) % enemy.movePattern.count
                }
            }
        }
    }
    
    func checkPlayerCollision(at playerPosition: GridPosition) -> Bool {
        for enemy in enemies {
            if enemy.gridPosition.row == playerPosition.row && enemy.gridPosition.col == playerPosition.col {
                return true
            }
        }
        return false
    }
}
