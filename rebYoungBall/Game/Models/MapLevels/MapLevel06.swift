




extension LevelManager {
    func levelMap6() -> LevelData {
        
        let rows = 8
        let cols = 7
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let emptyTiles = [
            (1, 3), (1, 3), (1,4), (1, 5),
            (2, 2), (2, 3), (2, 4), (2, 5),
            (3, 4), (3, 5),
        ]
        for row in 0..<rows-2 {
            for col in 1..<cols-1 {
                tiles[row+1][col] = .regular
            }
        }
        
        for (row, col) in emptyTiles {
            tiles[row][col] = .empty
        }
        
        
        tiles[4][cols-2] = .start 
        
        
        tiles[1][3] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

