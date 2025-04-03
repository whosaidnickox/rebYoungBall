



import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) private var dismiss
    
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
                
                ZStack {
                        VStack(alignment: .leading, spacing: 32) {
                            Text("HOW TO PLAY")
                                .font(.custom(.jaro, size: 32))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                
                            
                            Text(AssetsHelperFiller.texts.howToPlayFull)
                                .font(.custom(.arialBold, size: 18)) 
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 34)
                            
                        }
                        .padding(.vertical, 32)
                    }
                .background(AssetsHelperFiller.colors.redBackground)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .padding(24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HowToPlayView()
}
