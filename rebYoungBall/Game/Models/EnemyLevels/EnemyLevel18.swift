



extension LevelManager {
    
    

    func level18Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.left, .left, .left, .right, .right, .right]
        return [
            EnemyData(
                startPosition: GridPosition(row: 6, col: 5),
                movePattern: generalMovePattern
            ),
            
        ]
    }
    
}
