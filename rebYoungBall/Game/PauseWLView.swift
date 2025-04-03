



import SwiftUI

enum PauseWLType: String, CaseIterable{
    case pause = "Pause"
    case win = "You Win!"
    case lose = "You Lose"
    
    var subtitle: String? {
        switch self {
        case .win:
            return "Next Level Unlocked!"
        case .lose:
            return "Try Again"
        default:
            return nil
        }
    }
    
    var mainButtonTitle: String {
        switch self {
        case .win:
            return "Next Level"
        case .lose:
            return "Play Again"
        default:
            return "Continue"
        }
    }
    
    var subButtonTitle: String? {
        switch self {
        case .pause:
            return "Restart"
        case .win:
            return "Play Again"
        default:
            return nil
        }
    }
}

struct PauseWLView: View {
    @Binding var isShowing: Bool
    @Binding var pWLType: PauseWLType
    
    var onContinue: () -> Void = {}
    var onRestart: () -> Void = {}
    var onNextLevel: () -> Void = {}
    var onBackToMain: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    
                    if pWLType == .pause {
                        withAnimation {
                            isShowing = false
                            onContinue()
                        }
                    }
                }
            
            VStack(alignment: .leading, spacing: 32) {
                VStack {
                    Text(pWLType.rawValue)
                        .font(.custom(.jaro, size: 32))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    if pWLType != .pause {
                        Text(pWLType.subtitle ?? "")
                            .font(.custom(.jaro, size: 22))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                VStack(spacing: 8) {
                    
                    switch pWLType {
                    case .pause:
                        SettingsButtonView(text: self.pWLType.mainButtonTitle) {
                            withAnimation {
                                isShowing = false
                                onContinue()
                            }
                        }
                        SettingsButtonView(text: self.pWLType.subButtonTitle ?? "") {
                            withAnimation {
                                isShowing = false
                                onRestart()
                            }
                        }
                    case .win:
                        SettingsButtonView(text: self.pWLType.mainButtonTitle) {
                            withAnimation {
                                isShowing = false
                                onNextLevel()
                            }
                        }
                        SettingsButtonView(text: self.pWLType.subButtonTitle ?? "") {
                            withAnimation {
                                isShowing = false
                                onRestart()
                            }
                        }
                    case .lose:
                        SettingsButtonView(text: self.pWLType.mainButtonTitle) {
                            withAnimation {
                                isShowing = false
                                onRestart()
                            }
                        }
                    }
                    
                    
                    SettingsButtonView(text: "Back to Main") {
                        withAnimation {
                            isShowing = false
                            onBackToMain()
                        }
                    }
                }
                .padding(.horizontal, 32)
            }
            .padding(.vertical, 32)
            .background(AssetsHelperFiller.colors.redBackground)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 4)
            )
            .padding(24)
            .transition(.scale)
            .padding(.top, 100)
        }

    }
}


private struct Preview_GameContentView: View {
    @State private var showPauseWL = true
    @State private var pauseWLType: PauseWLType = .pause
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            AssetsHelperFiller.images.mainBackground
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationBarView(
                    leftButtonImage: AssetsHelperFiller.icons.pauseGame,
                    rightButtonImage: AssetsHelperFiller.icons.restartGame,
                    leftButtonAction: {
                        pauseWLType = .pause
                        withAnimation {
                            showPauseWL = true
                        }
                    },
                    rightButtonAction: {
                        pauseWLType = .pause
                        withAnimation {
                            showPauseWL = true
                        }
                    }
                )
                .padding(.top, DeviceSize.isSuperSmallDevice ? 20 : 0)

                
                Spacer()
                
                
                Text("Game Content")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            
            if showPauseWL {
                PauseWLView(
                    isShowing: $showPauseWL,
                    pWLType: $pauseWLType,
                    onContinue: {
                        
                        print("Continuing game")
                    },
                    onRestart: {
                        
                        print("Restarting level")
                    },
                    onNextLevel: {
                        
                        print("Going to next level")
                    },
                    onBackToMain: {
                        
                        print("Going back to main menu")
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
}

private struct SettingsButtonView: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .font(.custom(.jaro, size: 18))
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .foregroundColor(AssetsHelperFiller.colors.redBackground)
                .cornerRadius(16)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    Preview_GameContentView()
}
