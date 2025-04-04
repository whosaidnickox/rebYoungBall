




extension LevelManager {
    func levelMap3() -> LevelData {
        
        let rows = 11
        let cols = 6
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (1, 2), (1, 3),
            (2, 2), (2, 3),
            (3, 2), (3, 3),
            (4, 1), (4, 2), (4, 3), (4, 4),
            (5, 1), (5, 2), (5, 3), (5, 4),
            (6, 1), (6, 2), (6, 3), (6, 4),
            (7, 2), (7, 3),
            (8, 2), (8, 3),
            (9, 2), (9, 3),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        tiles[1][2] = .start 
        
        
        tiles[9][3] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

