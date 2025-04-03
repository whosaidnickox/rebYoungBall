




extension LevelManager {
    func levelMap9() -> LevelData {
        
        let rows = 11
        let cols = 6
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (1, 4),
            (2, 2), (2, 3), (2, 4),
            (3, 3), (3, 4),
            (4, 4),
            (5, 2), (5, 3), (5, 4),
            (6, 1), (6, 2),
            (7, 1), (7, 3), (7, 4),
            (8, 1), (8, 2), (8, 3),
            (9, 2),
        ]
        
        let traps = [
            (4, 2), (4, 3),
            (6, 3), (6, 4),
            (7, 2),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        for (row, col) in traps {
            tiles[row][col] = .trap
        }
        
        
        tiles[7][3] = .start 
        
        
        tiles[2][1] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

