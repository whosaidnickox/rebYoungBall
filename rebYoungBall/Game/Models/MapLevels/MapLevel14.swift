



extension LevelManager {
    
    func levelMap14() -> LevelData {
        let rows = 12
        let cols = 8
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        tiles[2][5] = .regular
        tiles[3][5] = .regular
        tiles[4][5] = .regular
        tiles[5][5] = .regular
        tiles[6][5] = .regular
        tiles[9][6] = .regular
        tiles[7][5] = .regular
        
        tiles[9][4] = .regular
        tiles[10][4] = .regular
        tiles[10][5] = .regular
        tiles[10][6] = .regular

        
        tiles[4][2] = .regular
        tiles[4][3] = .regular
        tiles[4][4] = .regular
        tiles[5][2] = .regular
        tiles[5][4] = .regular
        
        tiles[5][3] = .moverUp
        
        tiles[9][5] = .moverUp
        tiles[8][5] = .moverUp
        tiles[8][4] = .moverUp
        tiles[8][6] = .moverUp
        
        tiles[6][2] = .regular
        tiles[6][3] = .regular
        tiles[6][4] = .regular
        
        tiles[7][2] = .trap
        tiles[7][3] = .trap
        tiles[7][4] = .trap
        
        tiles[3][4] = .spinnerVer
        tiles[11][6] = .spinnerVer
        
        
        tiles[9][6] = .start
        tiles[1][5] = .finish
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
    
}
