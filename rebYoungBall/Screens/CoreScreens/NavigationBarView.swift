



import SwiftUI

struct NavigationBarView: View {
    var title: String?
    var leftButtonImage: Image?
    var rightButtonImage: Image?
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
    
    var body: some View {
        HStack {
            
            if let leftButtonImage = leftButtonImage, let leftButtonAction = leftButtonAction {
                BarButtonView(buttonImage: leftButtonImage) {
                    leftButtonAction()
                }
            } else {
                Spacer()
                    .frame(width: 60)
            }
            
            Spacer()
            
            
            if let title = title {
                Text(title)
                    .font(.custom(.jaro, size: 32))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            
            if let rightButtonImage = rightButtonImage, let rightButtonAction = rightButtonAction {
                BarButtonView(buttonImage: rightButtonImage) {
                    rightButtonAction()
                }
            } else {
                Spacer()
                    .frame(width: 60)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 68)
    }
}

struct BarButtonView: View {
    var buttonImage: Image
    var buttonAction: (() -> Void)
    
    var body: some View {
        Button(action: buttonAction) {
            buttonImage
                .padding(14)
                .background(Color.white)
                .cornerRadius(16)
        }
    }
}
