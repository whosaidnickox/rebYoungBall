import SpriteKit
import Foundation

class MapViewModel {
    private(set) var tileNodes: [[SKSpriteNode]] = []
    private(set) var gridSize: (rows: Int, cols: Int) = (10, 20)
    private let tileSize: CGFloat
    
    
    let finishCategory: UInt32 = 0x1 << 3
    let wallCategory: UInt32 = 0x1 << 4
    let trapCategory: UInt32 = 0x1 << 2
    
    init(tileSize: CGFloat) {
        self.tileSize = tileSize
    }
    
    func createMap(for level: Int, in scene: SKScene) -> GridPosition? {
        
        tileNodes.forEach { row in
            row.forEach { $0.removeFromParent() }
        }
        tileNodes = []
        
        let levelData = LevelManager.shared.getLevel(level)
        gridSize = (levelData.rows, levelData.cols)
        
        
        let mapNode = SKNode()
        mapNode.name = "mapContainer"
        scene.addChild(mapNode)
        
        
        var startPosition: GridPosition? = nil
        
        
        for row in 0..<gridSize.rows {
            var tileRow: [SKSpriteNode] = []
            
            for col in 0..<gridSize.cols {
                let tileType = levelData.tiles[row][col]
                let tile = createTile(type: tileType)
                
                
                let x = CGFloat(col) * tileSize + tileSize/2
                let y = CGFloat(gridSize.rows - row - 1) * tileSize + tileSize/2
                
                tile.position = CGPoint(x: x, y: y)
                mapNode.addChild(tile)
                tileRow.append(tile)
                
                
                if tileType == .start {
                    startPosition = GridPosition(row: row, col: col)
                }
            }
            
            tileNodes.append(tileRow)
        }
        
        return startPosition ?? GridPosition(row: 1, col: 1)
    }
    
    private func createTile(type: TileType) -> SKSpriteNode {
        let tile = SKSpriteNode(imageNamed: type.imageName)
        tile.size = CGSize(width: tileSize, height: tileSize)
        
        
        tile.zPosition = 5
        
        
        switch type {
        case .regular:
            
            break
        case .trap:
            tile.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
            tile.physicsBody?.isDynamic = false
            tile.physicsBody?.categoryBitMask = trapCategory
        case .empty:
            
            tile.alpha = 0.0
            break
        case .finish:
            tile.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
            tile.physicsBody?.isDynamic = false
            tile.physicsBody?.categoryBitMask = finishCategory
        default:
            
            break
        }
        
        return tile
    }
    
    
    func calculatePosition(for gridPosition: GridPosition, in scene: SKScene) -> CGPoint {
        
        let x = CGFloat(gridPosition.col) * tileSize + tileSize/2
        let y = CGFloat(gridSize.rows - gridPosition.row - 1) * tileSize + tileSize/2
        return CGPoint(x: x, y: y)
    }
}
