import SwiftUI
import SpriteKit

struct GameView: UIViewRepresentable {
    @ObservedObject var viewModel: GameViewModel
    
    
    class Coordinator: NSObject {
        var parent: GameView
        
        init(parent: GameView) {
            self.parent = parent
        }
        
        
        @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            guard parent.viewModel.gameState == .playing else { return }
            
            switch gesture.direction {
            case .up:
                parent.viewModel.movePlayer(direction: .up)
            case .down:
                parent.viewModel.movePlayer(direction: .down)
            case .left:
                parent.viewModel.movePlayer(direction: .left)
            case .right:
                parent.viewModel.movePlayer(direction: .right)
            default:
                break
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.preferredFramesPerSecond = 60
        view.showsFPS = false
        view.showsNodeCount = false
        view.allowsTransparency = true
        view.backgroundColor = .clear
        view.isOpaque = false
        
        
        setupGestureRecognizers(view, coordinator: context.coordinator)
        
        setupScene(view)
        
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        
        if uiView.scene == nil {
            setupScene(uiView)
        }
    }
    
    private func setupGestureRecognizers(_ view: SKView, coordinator: Coordinator) {
        
        let upSwipe = UISwipeGestureRecognizer(target: coordinator, action: #selector(Coordinator.handleSwipe(_:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        
        let downSwipe = UISwipeGestureRecognizer(target: coordinator, action: #selector(Coordinator.handleSwipe(_:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: coordinator, action: #selector(Coordinator.handleSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: coordinator, action: #selector(Coordinator.handleSwipe(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    private func setupScene(_ view: SKView) {
        
        let scene = GameScene(size: CGSize(width: 800, height: 1200))
        
        
        scene.scaleMode = .resizeFill
        
        
        scene.backgroundColor = .clear
        view.backgroundColor = .clear
        view.isOpaque = false
        
        
        view.ignoresSiblingOrder = true
        
        
        #if DEBUG
        view.showsFPS = false
        view.showsNodeCount = false
        #endif
        
        
        scene.viewModel = viewModel
        
        
        scene.gameStateCallback = { state in
            DispatchQueue.main.async {
                self.viewModel.gameState = state
            }
        }
        
        
        viewModel.scene = scene
        
        
        let transition = SKTransition.fade(withDuration: 0.3)
        view.presentScene(scene, transition: transition)
    }
    
    func resetLevel() {
        if let view = viewModel.scene?.view {
            
            viewModel.scene?.resetLevel()
        }
    }
    
    func prepareForNextLevel() {
        
    }
}
