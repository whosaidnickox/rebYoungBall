




extension LevelManager {
    func levelMap16() -> LevelData {
        
        let rows = 11
        let cols = 5
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        for col in 0..<3 {
            for row in 1..<rows-1 {
                tiles[row][col+1] = .regular
            }
        }
        
        let downMovers = [
            (0, 3),
            (1, 1),
            (6, 3),
            (7, 3),
        ]
        for (row, col) in downMovers {
            tiles[row][col] = .moverDown
        }
        
        let upMovers = [
            (3, 3),
            (4, 3),
            (9, 1),
            (10, 3),
        ]
        for (row, col) in upMovers {
            tiles[row][col] = .moverUp
        }
        
        tiles[5][2] = .trap
        
        tiles[8][2] = .spinnerVer
        tiles[2][2] = .spinnerHor
        
        
        tiles[5][3] = .start 
        
        
        tiles[7][2] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}

