




extension LevelManager {
    func levelMap5() -> LevelData {
        
        let rows = 10
        let cols = 9
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (2, 2),
            (3, 1), (3, 2), (3, 3), (3, 4),
            (4, 2), (4, 3),
            (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7),
            (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7),
            (7, 7),
        ]
        
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        tiles[1][2] = .start 
        
        
        tiles[8][7] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

