



extension LevelManager {
    
    
    

    func level11Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.left, .left, .left, .right, .right, .right]
        return [
            EnemyData(
                startPosition: GridPosition(row: 2, col: 5),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 2, col: 7),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 4, col: 7),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 5, col: 4),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 5, col: 6),
                movePattern: generalMovePattern
            )
            
        ]
    }
    
}
