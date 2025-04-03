



extension LevelManager {
    
    
    

    func level10Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.down, .down, .down, .up, .up, .up]
        return [
            EnemyData(
                startPosition: GridPosition(row: 2, col: 3),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 2, col: 5),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 3, col: 6),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 4, col: 3),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 4, col: 5),
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
