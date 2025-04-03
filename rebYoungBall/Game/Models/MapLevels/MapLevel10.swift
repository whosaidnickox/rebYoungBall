




extension LevelManager {
    func levelMap10() -> LevelData {
        
        let rows = 10
        let cols = 8
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        for row in 0..<rows-2 {
            for col in 1..<cols-1 {
                tiles[row+1][col] = .regular
            }
        }
        
        for row in 0..<rows-2 {
            tiles[row+1][1] = .trap
        }
        for col in 1..<cols-1 {
            tiles[rows-2][col] = .trap
            tiles[1][col] = .trap
        }
        tiles[5][2] = .trap
        tiles[3][4] = .trap
        
        



        



    
        
        tiles[6][2] = .start 
        
        
        tiles[3][cols-3] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}


