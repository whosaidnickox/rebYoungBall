import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {
        setupRealm()
    }
    
    var realm: Realm {
        do {
            return try Realm()
        } catch {
            print("Failed to open Realm: \(error.localizedDescription)")
            fatalError("Could not initialize Realm")
        }
    }
    
    private func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, _ in

            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
    
    func getLevels() -> Results<LevelDataModel> {
        return realm.objects(LevelDataModel.self).sorted(byKeyPath: "number")
    }
    
    func initializeLevelsIfNeeded() {
        let levels = realm.objects(LevelDataModel.self)
        if levels.isEmpty {
            let initialLevels = LevelDataModel.createInitialLevels()
            do {
                try realm.write {
                    for level in initialLevels {
                        realm.add(level)
                    }
                }
            } catch {
                print("Error initializing levels: \(error.localizedDescription)")
            }
        }
    }
    
    func updateLevel(_ level: LevelDataModel) {
        do {
            try realm.write {
                realm.add(level, update: .modified)
            }
        } catch {
            print("Error updating level: \(error.localizedDescription)")
        }
    }
}
