import Foundation
import Combine
import SpriteKit
import SwiftUI

import AVFoundation





enum MoveDirection {
    case none, up, down, left, right
}

class GameViewModel: ObservableObject {
    @Published var gameState: GameState = .playing
    @Published var currentLevel: Int = 1
    @Published var score: Int = 0
    @Published var moveDirection: MoveDirection = .none
    
    
    @Published var scene: GameScene?
    
    
    @Published var gameViewId = UUID()
    
    @Published var playerPosition: GridPosition = GridPosition(row: 0, col: 0)
    @Published var previousPlayerPosition: GridPosition = GridPosition(row: 0, col: 0)
    


    
    
    private var isResetting: Bool = false
    
    
    private var isBeingMoved: Bool = false
    
    
    init(level: Int = 1) {
        self.currentLevel = level
    }
    
    func movePlayer(direction: Direction) {
        
        if isResetting || isBeingMoved || gameState != .playing { return }
        
        
        previousPlayerPosition = playerPosition
        
        
        switch direction {
        case .up:
            moveDirection = .up
        case .down:
            moveDirection = .down
        case .left:
            moveDirection = .left
        case .right:
            moveDirection = .right
        }
        
        
        AudioManager.shared.playJumpSound()
        
        NotificationCenter.default.post(
            name: .playerMoveCommand,
            object: direction
        )
    }
    
    func advanceToNextLevel() {
        currentLevel += 1
        gameState = .playing
        
    }
    
    func restartCurrentLevel() {
        gameState = .playing
        
    }
    
    func playerWon() {
        gameState = .won

    }
    
    func playerLost() {
        gameState = .lost
    }
    
    func pauseGame() {
        scene?.isPaused = true
        gameState = .paused
    }
    
    func beginReset() {
        isResetting = true
    }
    
    func endReset() {
        isResetting = false
    }
    
    func beginMoverMovement() {
        isBeingMoved = true
    }
    
    func endMoverMovement() {
        isBeingMoved = false
    }
}


enum GameState {
    case playing
    case paused
    case won
    case lost
}

struct GridPosition: Equatable {
    var row: Int
    var col: Int
}

enum Direction {
    case up, down, left, right
}

extension Notification.Name {
    static let playerMoveCommand = Notification.Name("playerMoveCommand")
}
