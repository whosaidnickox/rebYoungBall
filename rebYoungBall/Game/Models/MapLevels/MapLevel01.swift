



extension LevelManager { 
    
    func levelMap1() -> LevelData {
        
        let rows = 14
        let cols = 3
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        
        for row in 0..<rows {
            tiles[row][1] = .regular 
        }
        tiles[0][1] = .empty
        tiles[rows-1][1] = .empty
        
        tiles[1][1] = .start 
        
        
        tiles[rows-2][1] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
    
}
