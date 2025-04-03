




extension LevelManager {
    func levelMap20() -> LevelData {
        
        let rows = 13
        let cols = 8
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        let regularTiles = [
            (2, 3),
            (3, 3),
            (4, 2), (4, 3), (4, 5), (4, 6),
            (5, 2), (5, 3), (5, 6),
            (6, 3), (6, 5), (6, 6),
            (7, 3), (7, 6),
            (8, 3), (8, 4), (8, 5), (8, 6),
            (10, 3), (10, 4),
            (11, 3), (11, 4),
        ]
        
        for (row, col) in regularTiles {
            tiles[row][col] = .regular
        }
        
        tiles[9][3] = .trap
        tiles[9][4] = .trap
        
        tiles[4][1] = .moverDown
        tiles[5][1] = .moverRight
        tiles[4][4] = .moverRight
        
        tiles[2][4] = .spinnerVer
        tiles[6][2] = .spinnerVer
        
        tiles[3][1] = .start 
        
        tiles[1][3] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}


