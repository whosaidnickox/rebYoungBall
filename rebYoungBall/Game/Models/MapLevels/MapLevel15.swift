




extension LevelManager {
    func levelMap15() -> LevelData {
        
        let rows = 12
        let cols = 8
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (2, 6),
            (3, 4), (3, 5), (3, 6),
            (4, 2), (4, 4), (4, 6),
            (5, 2), (5, 4), (5, 6),
            (6, 2), (6, 4), (6, 6),
            (7, 2), (7, 4), (7, 6),
            (8, 2), (8, 3), (8, 4), (8, 6),
            
            (9, 2), (9, 6),
            (10, 2), (10, 3),
        ]
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        let downMovers = [ (1, 6), (2, 4), (8, 6), (9, 3), (9, 4) ]
        for (row, col) in downMovers {
            tiles[row][col] = .moverDown
        }
        
        tiles[4][1] = .spinnerHor
        tiles[5][5] = .spinnerHor
        tiles[6][1] = .spinnerHor
        tiles[7][5] = .spinnerHor
        
        tiles[5][1] = .spinnerVer
        tiles[4][5] = .spinnerVer
        tiles[7][1] = .spinnerVer
        tiles[6][5] = .spinnerVer
        
        
        
        tiles[3][2] = .start 
        
        
        tiles[10][6] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}


