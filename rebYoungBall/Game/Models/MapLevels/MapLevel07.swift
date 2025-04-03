




extension LevelManager {
    func levelMap7() -> LevelData {
        
        let rows = 11
        let cols = 6
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (2, 3),
            (3, 1), (3, 3),
            (4, 1), (4, 3), (4, 4),
            (5, 1), (5, 3), (5, 4),
            (6, 1), (6, 3), (6, 4),
            (7, 1), (7, 2), (7, 3),
            (8, 1),
            (9, 1),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        tiles[5][3] = .trap
        tiles[8][1] = .trap
        
        tiles[1][3] = .start 
        
        
        tiles[2][1] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}


