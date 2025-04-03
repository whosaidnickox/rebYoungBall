



extension LevelManager {
    
    
    func level6Enemies() -> [EnemyData] {
        

        let generalMovePattern: [Direction] = [.up, .up, .up, .down, .down, .down]
        return [
            EnemyData(
                startPosition: GridPosition(row: 5, col: 1),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 6, col: 2),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 6, col: 3),
                movePattern: generalMovePattern
            ),
        ]
    }
    
}
