

extension LevelManager {
    
    

    func level19Enemies() -> [EnemyData] {
        
        let generalMovePattern: [Direction] = [.down, .down, .down, .up, .up, .up]
        
        return [
            EnemyData(
                startPosition: GridPosition(row: 1, col: 2),
                movePattern: generalMovePattern
            ),
            
        ]
    }
    
}
