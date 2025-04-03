import SpriteKit

enum MoverDirection {
    case up
    case down
    case left
    case right
    
    var tileType: TileType {
        switch self {
        case .up:
            return .moverUp
        case .down:
            return .moverDown
        case .left:
            return .moverLeft
        case .right:
            return .moverRight
        }
    }
    
    var toDirection: Direction {
        switch self {
        case .up:
            return .up
        case .down:
            return .down
        case .left:
            return .left
        case .right:
            return .right
        }
    }
    
    static func fromTileType(_ type: TileType) -> MoverDirection? {
        switch type {
        case .moverUp:
            return .up
        case .moverDown:
            return .down
        case .moverLeft:
            return .left
        case .moverRight:
            return .right
        default:
            return nil
        }
    }
}

class Mover {
    let direction: MoverDirection
    let position: GridPosition
    
    init(position: GridPosition, direction: MoverDirection) {
        self.position = position
        self.direction = direction
    }
    
    func getDestinationPosition() -> GridPosition {
        var newPosition = position
        
        switch direction {
        case .up:
            newPosition.row -= 1
        case .down:
            newPosition.row += 1
        case .left:
            newPosition.col -= 1
        case .right:
            newPosition.col += 1
        }
        
        return newPosition
    }
}
