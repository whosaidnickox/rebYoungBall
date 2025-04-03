



extension LevelManager {
    
    

    func level12Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.left, .left, .left, .right, .right, .right]
        return [
            EnemyData(
                startPosition: GridPosition(row: 2, col: 6),
                movePattern: generalMovePattern
            ),
            
            EnemyData(
                startPosition: GridPosition(row: 4, col: 4),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 4, col: 6),
                movePattern: generalMovePattern
            ),
            
            EnemyData(
                startPosition: GridPosition(row: 5, col: 6),
                movePattern: generalMovePattern
            ),
            
            EnemyData(
                startPosition: GridPosition(row: 7, col: 6),
                movePattern: generalMovePattern
            ),
            
        ]
    }
    
}
