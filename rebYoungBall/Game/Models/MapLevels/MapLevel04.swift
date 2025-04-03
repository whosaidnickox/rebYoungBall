




extension LevelManager {
    func levelMap4() -> LevelData {
        
        let rows = 8
        let cols = 9
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        
        let regularTiles = [
            (2, 1), (2, 5),
            (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6),
            (4, 6),
            (5, 3), (5, 6),
            (6, 2), (6, 3), (6, 4), (6, 5), (6, 6),
            (6, 7),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        tiles[1][1] = .start 
        
        
        tiles[6][1] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

