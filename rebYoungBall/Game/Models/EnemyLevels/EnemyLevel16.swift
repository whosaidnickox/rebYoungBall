



extension LevelManager {
    
    

    func level16Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.down, .down, .down, .up, .up, .up]
        
        return [
            EnemyData(
                startPosition: GridPosition(row: 4, col: 2),
                movePattern: generalMovePattern
            ),
            
        ]
    }
    
}
