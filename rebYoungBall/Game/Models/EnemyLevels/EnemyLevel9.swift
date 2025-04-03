



extension LevelManager {
    
    
    
    func level9Enemies() -> [EnemyData] {
        
        return [
            EnemyData(
                startPosition: GridPosition(row: 4, col: 4),
                movePattern: [.up, .up, .up, .down, .down, .down]
            ),
            EnemyData(
                startPosition: GridPosition(row: 7, col: 4),
                movePattern: [.up, .up, .up, .down, .down, .down]
            ),
            EnemyData(
                startPosition: GridPosition(row: 8, col: 3),
                movePattern: [.up, .up, .up, .down, .down, .down]
            ),
            EnemyData(
                startPosition: GridPosition(row: 9, col: 2),
                movePattern: [.up, .up, .up, .down, .down, .down]
            )
        ]
    }
    
}
