import Foundation

enum TileType {
    case empty
    case regular 
    case start
    case finish
    case trap
    case trapOffed
    case spinnerHor
    case spinnerVer
    case moverUp
    case moverDown
    case moverLeft
    case moverRight
    
    var imageName: String {
        switch self {
        case .empty: return ""
        case .regular: return "Type=Regular"
        case .start: return "Type=Start"
        case .finish: return "Type=Finish"
        case .trap: return "Type=Trap"
        case .trapOffed: return "Type=Trap Off"
        case .spinnerHor: return "Type=Barrier Hor"
        case .spinnerVer: return "Type=Barrier Hor"
        case .moverUp: return "Type=Slide Up"
        case .moverDown: return "Type=Slide Down"
        case .moverLeft: return "Type=Slide Left"
        case .moverRight: return "Type=Slide Right"
            
        
        }
    }
}

struct LevelData {
    let rows: Int
    let cols: Int
    let tiles: [[TileType]]

}

struct EnemyData {
    let startPosition: GridPosition
    let movePattern: [Direction]
}

class LevelManager {
    static let shared = LevelManager()
    
    private init() {}
    
    func getLevel(_ level: Int) -> LevelData {
        
        switch level {
        case 1:
            return levelMap1() 
        case 2:
            return levelMap2()
        case 3:
            return levelMap3()
        case 4:
            return levelMap4()
        case 5:
            return levelMap5()
        case 6:
            return levelMap6()
        case 7:
            return levelMap7()
        case 8:
            return levelMap8()
        case 9:
            return levelMap9()
        case 10:
            return levelMap10()
        case 11:
            return levelMap11()
        case 12:
            return levelMap12()
        case 13:
            return levelMap13()
        case 14:
            return levelMap14()
        case 15:
            return levelMap15()
        case 16:
            return levelMap16()
        case 17:
            return levelMap17()
        case 18:
            return levelMap18()
        case 19:
            return levelMap19()
        case 20:
            return levelMap20()
        default:
            return levelMap1()
        }
    }
    
    func getEnemies(for level: Int) -> [EnemyData] {
        switch level {
        case 1:
            return []
        case 4:
            return level4Enemies()
        case 5:
            return level5Enemies()
        case 6:
            return level6Enemies()
        case 7:
            return level7Enemies()
        case 8:
            return level8Enemies() 
        case 9:
            return level9Enemies()
        case 10:
            return level10Enemies()
        case 11:
            return level11Enemies()
        case 12:
            return level12Enemies()
        case 16:
            return level16Enemies()
        case 18:
            return level18Enemies()
        case 19:
            return level19Enemies()
        case 20:
            return level20Enemies()
        default:
            return []
        }
    }
    
    func getTileType(at position: GridPosition, level: Int) -> TileType {
        let levelData = getLevel(level)
        
        guard position.row >= 0 && position.row < levelData.rows &&
              position.col >= 0 && position.col < levelData.cols else {
            return .regular 
        }
        
        return levelData.tiles[position.row][position.col]
    }
    
}
