




extension LevelManager {
    func levelMap11() -> LevelData {
        
        let rows = 8
        let cols = 9
        
        
        var tiles: [[TileType]] = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        
        for row in 0..<rows-2 {
            for col in 1..<cols-1 {
                tiles[row+1][col] = .regular
            }
        }
        
        let emptyTiles: [(Int, Int)] = [
            (1, cols-2),(1, cols-3),
            (3, cols-2),
            (5, cols-2),
            (6, cols-2),(6, cols-3),
        ]
        for (row, col) in emptyTiles {
            tiles[row][col] = .empty
        }
        
        let trapTiles = [
            (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
            (2, 1),
            (3, 1), (3, 2), (3, 5),
            (4, 2), (4, 3), (4, 4),
            (5, 2), (5, 3),
        ]
        
        for (row, col) in trapTiles {
            tiles[row][col] = .trap
        }
        
        






        
        
        tiles[2][2] = .start 
        
        
        tiles[4][1] = .finish 
        
        return LevelData(rows: rows, cols: cols, tiles: tiles)
    }
}


