import SpriteKit
import Foundation

class MoverViewModel {
    private(set) var movers: [Mover] = []
    private var gridSize: (rows: Int, cols: Int)
    
    init(gridSize: (rows: Int, cols: Int)) {
        self.gridSize = gridSize
    }
    
    func updateGridSize(_ newSize: (rows: Int, cols: Int)) {
        gridSize = newSize
    }
    
    func createMovers(for level: Int) {
        movers = []
        
        let levelData = LevelManager.shared.getLevel(level)
        
        
        for row in 0..<gridSize.rows {
            for col in 0..<gridSize.cols {
                let tileType = levelData.tiles[row][col]
                if let moverDirection = MoverDirection.fromTileType(tileType) {
                    let position = GridPosition(row: row, col: col)
                    let mover = Mover(position: position, direction: moverDirection)
                    movers.append(mover)
                }
            }
        }
    }
    
    func getMoverAt(position: GridPosition) -> Mover? {
        return movers.first { $0.position.row == position.row && $0.position.col == position.col }
    }
}
