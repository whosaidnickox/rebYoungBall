import SpriteKit

enum SpinnerOrientation {
    case horizontal
    case vertical
    
    var tileType: TileType {
        switch self {
        case .horizontal:
            return .spinnerVer
        case .vertical:
            return .spinnerHor
        }
    }
    
    var imageName: String {
        return tileType.imageName
    }
    
    
    mutating func toggle() {
        self = self == .horizontal ? .vertical : .horizontal
    }
    
    
    func getAffectedPositions(center: GridPosition) -> [GridPosition] {
        switch self {
        case .horizontal:
            return [
                center,  
                GridPosition(row: center.row, col: center.col - 1),  
                GridPosition(row: center.row, col: center.col + 1)   
            ]
        case .vertical:
            return [
                center,  
                GridPosition(row: center.row - 1, col: center.col),  
                GridPosition(row: center.row + 1, col: center.col)   
            ]
        }
    }
}

class Spinner {
    let centerNode: SKSpriteNode
    
    var orientation: SpinnerOrientation
    let centerPosition: GridPosition
    private let gridSize: (rows: Int, cols: Int)
    private let tileSize: CGFloat
    
    
    private let rotationDuration: TimeInterval = 0.3
    
    
    private let debugMode = false
    
    init(centerPosition: GridPosition, initialOrientation: SpinnerOrientation, 
         gridSize: (rows: Int, cols: Int), tileSize: CGFloat) {
        self.centerPosition = centerPosition
        self.orientation = initialOrientation
        self.gridSize = gridSize
        self.tileSize = tileSize
        
        
        self.centerNode = SKSpriteNode(imageNamed: initialOrientation.imageName)
        centerNode.zPosition = 10 
        
        
        
        
        if initialOrientation == .vertical {
            centerNode.zRotation = .pi/2
        }
        
        
    }
    
    func addToScene(_ scene: SKScene) {
        
        scene.addChild(centerNode)
        
        
        if let gameScene = scene as? GameScene {
            let position = gameScene.mapViewModel.calculatePosition(for: centerPosition, in: scene)
            centerNode.position = position
        } else {
            
            let x = CGFloat(centerPosition.col) * tileSize + tileSize/2
            let y = CGFloat(gridSize.rows - centerPosition.row - 1) * tileSize + tileSize/2
            centerNode.position = CGPoint(x: x, y: y)
        }
    }
    
    func removeFromScene() {
        centerNode.removeFromParent()
    }
    
    
    func rotate() {
        
        orientation.toggle()
        
        
        let targetAngle: CGFloat = orientation == .vertical ? .pi/2 : 0
        
        
        let rotateAction = SKAction.rotate(toAngle: targetAngle, duration: rotationDuration)
        
        
        let scaleDown = SKAction.scale(to: 0.9, duration: rotationDuration/2)
        let scaleUp = SKAction.scale(to: 1.0, duration: rotationDuration/2)
        let pulse = SKAction.sequence([scaleDown, scaleUp])
        
        
        let combinedAction = SKAction.group([rotateAction, pulse])
        
        
        centerNode.run(combinedAction)
    }
    
    
    func isAffecting(position: GridPosition) -> Bool {
        return orientation.getAffectedPositions(center: centerPosition).contains { 
            $0.row == position.row && $0.col == position.col
        }
    }
    
    
    private func addDebugVisualization() {
        let positions = orientation.getAffectedPositions(center: centerPosition)
        for position in positions {
            let debugNode = SKSpriteNode(color: .red, size: CGSize(width: tileSize * 0.5, height: tileSize * 0.5))
            debugNode.alpha = 0.5
            debugNode.name = "debug_\(position.row)_\(position.col)"
            
            let mapWidth = CGFloat(gridSize.cols) * tileSize
            let mapHeight = CGFloat(gridSize.rows) * tileSize
            let originX = (UIScreen.main.bounds.width - mapWidth) / 2
            let originY = (UIScreen.main.bounds.height - mapHeight) / 2
            
            let x = originX + CGFloat(position.col) * tileSize + tileSize/2
            let y = originY + CGFloat(gridSize.rows - position.row - 1) * tileSize + tileSize/2
            
            debugNode.position = CGPoint(x: x, y: y)
            debugNode.zPosition = 20
            centerNode.parent?.addChild(debugNode)
        }
    }
    
    private func updateDebugVisualization() {
        
        centerNode.parent?.children.forEach { node in
            if node.name?.starts(with: "debug_") == true {
                node.removeFromParent()
            }
        }
        
        
        if centerNode.parent != nil {
            addDebugVisualization()
        }
    }
}
