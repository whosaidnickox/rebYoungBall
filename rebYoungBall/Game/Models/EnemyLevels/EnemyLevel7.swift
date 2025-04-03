



extension LevelManager {
    
    
    func level7Enemies() -> [EnemyData] {
        

        let generalMovePattern: [Direction] = [.up, .up, .up, .down, .down, .down]
        return [
            EnemyData(
                startPosition: GridPosition(row: 9, col: 1),
                movePattern: generalMovePattern
            ),
        ]
    }
    
}
