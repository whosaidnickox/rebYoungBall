




extension LevelManager {
    func levelMap19() -> LevelData {
        
        let rows = 11
        let cols = 7
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (1, 2),
            (3, 1),
            (4, 1), (4, 2), (4, 3), (4, 4), (4, 5),
            (5, 1), (5, 2), (5, 3), (5, 4), (5, 5),
            (6, 1), (6, 2), (6, 3), (6, 4), 
            (7, 2), (7, 3),
            (8, 3),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        for r in 0..<4 {
            tiles[2][r+1] = .trap
        }
        tiles[3][5] = .trap
        
        tiles[3][2] = .moverDown
        tiles[3][3] = .moverDown
        tiles[3][4] = .moverDown
        tiles[4][1] = .moverUp
        tiles[6][1] = .moverUp
        tiles[6][5] = .moverUp
        
        tiles[5][4] = .spinnerVer
        tiles[5][2] = .spinnerVer
        tiles[7][4] = .spinnerVer
        tiles[7][2] = .spinnerVer
        
        
        
        
        tiles[6][3] = .start 
        
        
        tiles[9][3] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

