




extension LevelManager {
    func levelMap17() -> LevelData {
        
        let rows = 7
        let cols = 9
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (2, 2),
            (3, 1), (3, 3),
            (4, 1), (4, 2),
            (5, 1),
        ]
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        let leftMovers = [
            (3, 4), (3, 5), (3, 6),
            (4, 3), (4, 4),
            (5, 2),
        ]
        
        for (row, col) in leftMovers {
            tiles[row][col] = .moverLeft
        }
        
        tiles[2][1] = .moverRight
        
        
        tiles[3][2] = .spinnerHor
        tiles[3][cols-2] = .start 
        
        
        tiles[1][2] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}


