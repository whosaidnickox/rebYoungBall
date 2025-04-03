import SwiftUI
import SpriteKit
import RealmSwift

struct GameContentView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var showPauseWL = false
    @State private var pauseWLType: PauseWLType = .pause
    
    
    @State private var gameView: GameView? = nil
    
    var body: some View {
        ZStack {
            
            Image("mainBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationBarView(
                    leftButtonImage: AssetsHelperFiller.icons.pauseGame,
                    rightButtonImage: AssetsHelperFiller.icons.restartGame,
                    leftButtonAction: {
                        viewModel.pauseGame()
                    },
                    rightButtonAction: {
                        
                        performGameRestart()
                    }
                )
                .padding(.top, DeviceSize.isSuperSmallDevice ? 20 : 0)
                
                
                GameView(viewModel: viewModel)
                    .id(viewModel.gameViewId) 
                    .background(GeometryReader { _ in
                        Color.clear.preference(key: ViewRefKey.self, value: ViewRef(view: nil))
                            .onPreferenceChange(ViewRefKey.self) { ref in
                                DispatchQueue.main.async {
                                    if let view = ref.view as? GameView {
                                        self.gameView = view
                                    }
                                }
                            }
                    })
                
                
                
                 .padding(.bottom, DeviceSize.isSuperSmallDevice ? 120 : 20)

            }
            
            
            if showPauseWL {
                PauseWLView(
                    isShowing: $showPauseWL,
                    pWLType: $pauseWLType,
                    onContinue: {
                        
                        viewModel.gameState = .playing
                        viewModel.scene?.isPaused = false
                    },
                    onRestart: {
                        
                        performGameRestart()
                    },
                    onNextLevel: {
                        
                        advanceToNextLevel()
                    },
                    onBackToMain: {
                        
                        dismiss()
                    }
                )
            }
        }
        .ignoresSafeArea()
        .onReceive(viewModel.$gameState) { state in
            switch state {
            case .playing:
                showPauseWL = false
                
            case .paused:
                pauseWLType = .pause
                showPauseWL = true
                
            case .won:
                updateLevelCompletion()
                pauseWLType = .win
                showPauseWL = true
                
            case .lost:
                pauseWLType = .lose
                showPauseWL = true
            }
        }
    }
    
    private func performGameRestart() {
        viewModel.restartCurrentLevel()
        
        
        
        if let gameScene = viewModel.scene {
            
            gameScene.resetLevel()
        } else {
            
            viewModel.gameViewId = UUID()
        }
    }
    
    private func advanceToNextLevel() {
        
        viewModel.advanceToNextLevel()
        
        
        viewModel.gameViewId = UUID()
    }
    
    private func updateLevelCompletion() {
        let realm = RealmManager.shared.realm
        let levels = realm.objects(LevelDataModel.self).filter("number == \(viewModel.currentLevel)")
        
        if let level = levels.first {
            try? realm.write {
                level.isCompleted = true
                

                if let nextLevel = realm.objects(LevelDataModel.self).filter("number == \(viewModel.currentLevel + 1)").first {
                    nextLevel.isLocked = false
                }
            }
        }
    }
}


struct ViewRef: Equatable {
    weak var view: AnyObject?
    
    static func == (lhs: ViewRef, rhs: ViewRef) -> Bool {
        
        guard let lhsView = lhs.view, let rhsView = rhs.view else {
            return lhs.view == nil && rhs.view == nil
        }
        
        
        return ObjectIdentifier(lhsView) == ObjectIdentifier(rhsView)
    }
}

struct ViewRefKey: PreferenceKey {
    static var defaultValue = ViewRef(view: nil)
    
    static func reduce(value: inout ViewRef, nextValue: () -> ViewRef) {
        value = nextValue()
    }
}

#Preview {
    GameContentView()
        .environmentObject(GameViewModel(level: 16))
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var asiuqzoptqxbt = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: asiuqzoptqxbt))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if asiuqzoptqxbt == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.asiuqzoptqxbt
    }
}
