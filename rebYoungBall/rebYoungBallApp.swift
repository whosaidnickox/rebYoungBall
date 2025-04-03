import SwiftUI
import RealmSwift

@main
struct rebYoungBallApp: SwiftUI.App {
    @StateObject private var gameViewModel = GameViewModel()
    
    init() {
        AudioManager.shared.startBackgroundMusic()
        _ = RealmManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(gameViewModel)
        }
    }
}
