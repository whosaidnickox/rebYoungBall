import SwiftUI
import RealmSwift

struct LevelPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var gameViewModel: GameViewModel
    
    @State private var levels: [LevelDataModel] = []
    @State private var selectedLevel: Int?
    @State private var isGamePresented = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
        
    var body: some View {
        ZStack {
            
            AssetsHelperFiller.images.mainBackground
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationBarView(
                    leftButtonImage: AssetsHelperFiller.icons.backArrow,
                    leftButtonAction: {
                        dismiss()
                    }
                )
                .padding(.top, DeviceSize.isSuperSmallDevice ? 20 : 0)
                
                
                ZStack {
                    VStack(alignment: .leading, spacing: 32) {
                        Text("Levels")
                            .font(.custom(.jaro, size: 32))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 30)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(levels, id: \.id) { level in
                                    CellLevelView(
                                        level: level,
                                        selectedLevel: $selectedLevel,
                                        startGameAction: { levelNumber in
                                            startGame(level: levelNumber)
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.bottom, 32)
                        }
                    }
                }
                .background(AssetsHelperFiller.colors.redBackground)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 4)
                )
                .padding(24)
                .padding(.bottom, DeviceSize.isSuperSmallDevice ? 120 : 0)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $isGamePresented) {
            GameContentView()
                .environmentObject(gameViewModel)
        }
        .onAppear {
            RealmManager.shared.initializeLevelsIfNeeded()
            
            let realmLevels = RealmManager.shared.getLevels()
            self.levels = Array(realmLevels)
        }
    }
    
    private func startGame(level: Int) {
        
        gameViewModel.currentLevel = level
        gameViewModel.gameState = .playing
        gameViewModel.score = 0
        gameViewModel.gameViewId = UUID() 
        isGamePresented = true
    }
}

struct CellLevelView: View {
    let level: LevelDataModel
    @Binding var selectedLevel: Int?
    var startGameAction: ((Int) -> Void)
    
    let cellWidth: CGFloat = (UIScreen.main.bounds.width - 24 - 32 - 4) / 4 - 18
    let cellHeight: CGFloat = ((UIScreen.main.bounds.width - 24 - 32 - 4) / 4 - 18) / 1.14

    var body: some View {
        Button(action: {
            if !level.isLocked {
                selectedLevel = level.number
                startGameAction(level.number)
            }
        }) {
            ZStack {
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(width: cellWidth, height: cellHeight)
                
                
                if level.isCompleted {
                    AssetsHelperFiller.icons.checkBox
                } else {
                    VStack(spacing: 0) {
                        Text("\(level.number)")
                            .font(.custom(.jaro, size: 24))
                            .foregroundColor(AssetsHelperFiller.colors.redBackground.opacity(level.isLocked ? 0.32 : 1))
                            .bold()
                        
                    }
                }
            }
            .shadow(radius: level.isLocked ? 0 : 2)
        }
        .disabled(level.isLocked)
    }
}

#Preview {
    LevelPickerView()
        .environmentObject(GameViewModel())
}
extension View {
    func pulivra() -> some View {
        self.modifier(Ohriswk())
    }
}
