



extension LevelManager {
    
    
    func level5Enemies() -> [EnemyData] {
        

        let generalMovePattern: [Direction] = [.left, .left, .left, .right, .right, .right]
        return [
            EnemyData(
                startPosition: GridPosition(row: 3, col: 4),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 5, col: 5),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 6, col: 7),
                movePattern: generalMovePattern
            ),
        ]
    }
    
}
