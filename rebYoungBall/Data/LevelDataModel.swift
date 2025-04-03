import RealmSwift
import Foundation

final class LevelDataModel: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var number: Int
    @Persisted var isCompleted: Bool
    @Persisted var isLocked: Bool
    
    convenience init(number: Int, isCompleted: Bool = false, isLocked: Bool = true) {
        self.init()
        self.id = UUID()
        self.number = number
        self.isCompleted = isCompleted
        self.isLocked = isLocked
    }
}


extension LevelDataModel {
    static func createInitialLevels() -> [LevelDataModel] {
        var levels: [LevelDataModel] = []
        
        for i in 1...20 {
            let isLocked = i > 1
            levels.append(LevelDataModel(number: i, isLocked: isLocked))
        }
        
        return levels
    }
}
