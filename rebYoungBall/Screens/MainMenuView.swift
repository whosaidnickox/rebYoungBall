



import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @State private var showHowToPlay = false
    @State private var showSettings = false
    @State private var showLevelPicker = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AssetsHelperFiller.images.mainBackground
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    NavigationBarView(
                        leftButtonImage: AssetsHelperFiller.icons.howToPlay,
                        rightButtonImage: AssetsHelperFiller.icons.gearSettings,
                        leftButtonAction: {
                            showHowToPlay = true
                        },
                        rightButtonAction: {
                            showSettings = true
                        }
                    )
                    .padding(.top, DeviceSize.isSuperSmallDevice ? 20 : 0)
                    
                    Spacer()
                    
                    
                    AssetsHelperFiller.images.menuLogo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 342, height: 342)
                    
                    Spacer()
                    
                    
                    Button(action: {
                        print(UIScreen.main.bounds.height)
                        showLevelPicker = true
                    }) {
                        Text("START")
                            .font(.custom(.jaro, size: 40))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .foregroundColor(AssetsHelperFiller.colors.redBackground)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, DeviceSize.isSuperSmallDevice ? 116 : 36)
                    .padding(.horizontal, 24)

                }
            }
            .fullScreenCover(isPresented: $showHowToPlay) {
                HowToPlayView()
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $showLevelPicker) {
                LevelPickerView()
                    .environmentObject(gameViewModel)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .pulivra()
        .onAppear() {
            print("sw")
        }
    }
}

#Preview {
    MainMenuView()
        .environmentObject(GameViewModel())
}
