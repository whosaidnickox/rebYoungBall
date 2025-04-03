import SwiftUI

struct ControlsView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            
            Button(action: {
                viewModel.movePlayer(direction: .up)
            }) {
                Image("Type=Slide Up")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 50) {
                
                Button(action: {
                    viewModel.movePlayer(direction: .left)
                }) {
                    Image("Type=Slide Left")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                }
                
                
                Button(action: {
                    viewModel.movePlayer(direction: .right)
                }) {
                    Image("Type=Slide Right")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                }
            }
            
            
            Button(action: {
                viewModel.movePlayer(direction: .down)
            }) {
                Image("Type=Slide Down")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(15)
    }
}
