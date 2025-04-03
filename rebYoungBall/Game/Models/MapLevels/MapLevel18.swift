




extension LevelManager {
    func levelMap18() -> LevelData {
        
        let rows = 9
        let cols = 10
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (1, 6),
            (2, 6), (2, 7),
            (3, 2), (3, 4), (3, 5),
            (4, 2), (4, 4),
            (5, 2), (5, 7),
            (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7),
            (7, 3),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        tiles[3][3] = .moverLeft
        tiles[3][6] = .moverLeft
        tiles[3][7] = .moverLeft
        tiles[4][5] = .moverLeft
        tiles[4][7] = .moverRight
        tiles[5][1] = .moverRight
        tiles[6][6] = .moverRight
        
        tiles[2][2] = .spinnerHor
        tiles[2][3] = .spinnerHor
        tiles[2][4] = .spinnerVer
        tiles[2][5] = .spinnerVer
        
        
        tiles[1][cols-3] = .start 
        
        
        tiles[4][cols-2] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

