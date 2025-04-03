



extension LevelManager {
    func levelMap2() -> LevelData {
        
        let rows = 14
        let cols = 9
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (1, 5), (1, 6), (1, 7),
            (2, 5), (2, 7), (2, 3), (2, 2), (2, 1),
            (3, 5), (3, 6), (3, 7), (3, 3), (3, 1),
            (4, 6), (4, 3), (4, 1),
            (5, 6), (5, 5), (5, 4), (5, 3), (5, 1),
            (6, 1),
            (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7),
            (8, 7),
            (9, 7),
            (10, 7), (10, 5), (10, 4), (10, 3),
            (11, 7), (11, 6), (11, 5), (11, 3),
            (12, 5), (12, 4), (12, 3)
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        tiles[2][6] = .start 
        
        
        tiles[11][4] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}
