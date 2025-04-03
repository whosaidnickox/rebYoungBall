import SpriteKit
import Foundation

class SpinnerViewModel {
    private(set) var spinners: [Spinner] = []
    private let tileSize: CGFloat
    private var gridSize: (rows: Int, cols: Int)
    
    init(tileSize: CGFloat, gridSize: (rows: Int, cols: Int)) {
        self.tileSize = tileSize
        self.gridSize = gridSize
    }
    
    func updateGridSize(_ newSize: (rows: Int, cols: Int)) {
        gridSize = newSize
    }
    
    func createSpinners(for level: Int, in scene: SKScene) {
        
        spinners.forEach { $0.removeFromScene() }
        spinners = []
        
        let levelData = LevelManager.shared.getLevel(level)
        
        
        if let gameScene = scene as? GameScene {
            for row in 0..<levelData.tiles.count {
                for col in 0..<levelData.tiles[row].count {
                    let tileType = levelData.tiles[row][col]
                    let position = GridPosition(row: row, col: col)
                    
                    if tileType == .spinnerHor || tileType == .spinnerVer {
                        let orientation: SpinnerOrientation = tileType == .spinnerHor ? .horizontal : .vertical
                        
                        let spinner = Spinner(
                            centerPosition: position,
                            initialOrientation: orientation,
                            gridSize: gridSize,
                            tileSize: tileSize
                        )
                        
                        spinner.addToScene(scene)
                        spinners.append(spinner)
                    }
                }
            }
        }
    }
    
    func rotateAllSpinners() {
        for spinner in spinners {
            spinner.rotate()
        }
    }
    
    func checkCollision(at position: GridPosition) -> Bool {
        for spinner in spinners {
            if spinner.isAffecting(position: position) {
                return true
            }
        }
        return false
    }
}
