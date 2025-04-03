



extension LevelManager {
    
    

    func level20Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.up, .up, .up, .down, .down, .down]
        
        return [
            EnemyData(
                startPosition: GridPosition(row: 11, col: 3),
                movePattern: generalMovePattern
            ),
            EnemyData(
                startPosition: GridPosition(row: 11, col: 4),
                movePattern: generalMovePattern
            ),
            
        ]
    }
    
}
