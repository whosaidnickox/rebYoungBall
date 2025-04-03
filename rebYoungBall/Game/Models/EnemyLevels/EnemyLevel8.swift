



extension LevelManager {
    
    
    func level8Enemies() -> [EnemyData] {
        
        return [
            EnemyData(
                startPosition: GridPosition(row: 2, col: 3),
                movePattern: [.left, .left, .right, .right]
            ),
            EnemyData(
                startPosition: GridPosition(row: 3, col: 3),
                movePattern: [.left, .left, .right, .right]
            )
        ]
    }
    
}
