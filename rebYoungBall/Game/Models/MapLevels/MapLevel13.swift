



extension LevelManager {
    
    func levelMap13() -> LevelData {
        let rows = 10
        let cols = 7
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        tiles[2][2] = .regular
        tiles[2][3] = .regular
        tiles[2][4] = .regular
        
        tiles[3][4] = .regular
        tiles[4][4] = .regular
        tiles[5][4] = .regular
        tiles[6][4] = .regular
        tiles[8][4] = .regular
        
        tiles[6][3] = .regular
        tiles[7][3] = .regular
        tiles[8][3] = .regular
        
        tiles[6][5] = .regular
        tiles[7][5] = .regular
        tiles[8][5] = .regular
        
        tiles[1][4] = .spinnerVer
        tiles[3][5] = .spinnerVer
        tiles[5][5] = .spinnerVer
        
        tiles[7][4] = .start
        tiles[2][1] = .finish
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
    
}
