



extension LevelManager {
    
    func levelMap8() -> LevelData {

        let rows = 7
        let cols = 4
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        
        
        for t in 0...tiles[0].count {
            tiles[t+1][0] = .trap
            tiles[t+1][2] = .trap
        }
        
        tiles[2][1] = .regular
        tiles[2][3] = .regular
        
        
        tiles[3][1] = .regular
        tiles[3][3] = .regular
        
        
        
        tiles[4][1] = .regular
        
        
        tiles[5][1] = .regular
        tiles[5][2] = .regular
        tiles[5][3] = .regular
        
        
        tiles[1][1] = .start 
        tiles[5][3] = .finish 
        
        
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
    
    
}
