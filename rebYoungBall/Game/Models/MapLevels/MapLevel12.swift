




extension LevelManager {
    func levelMap12() -> LevelData {
        
        let rows = 10
        let cols = 8
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (1, 5),
            (2, 5), (2, 6),
            (3, 4), (3, 5),
            (4, 3), (4, 4), (4, 6),
            (5, 3), (5, 4), (5, 5), (5, 6),
            (6, 2), (6, 3), (6, 5), (6, 6),
            (7, 3), (7, 4), (7, 5), (7, 6),
            (8, 4), (8, 5),

        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        let trapsTiles: [(Int, Int)] = [
            (2, 3), (2, 4),
            (4, 1), (4, 2), (4, 5),
            (6, 4)
                
        ]
        for (row, col) in trapsTiles {
            tiles[row][col] = .trap
        }
        
        
        
        tiles[1][4] = .start 
        
        
        tiles[5][5] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

