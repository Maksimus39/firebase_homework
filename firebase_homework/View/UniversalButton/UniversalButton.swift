import SwiftUI



struct UniversalButton: View {
    var image: String
    var buttonAction: () -> Void
    
    init(image: String, buttonAction: @escaping () -> Void) {
        self.image = image
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack(spacing: 36) {
                Text(Constants.getStarted)
                    .appTitleFont(size: 18)
                
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(.brown)
            .clipShape(.capsule)
        }
        .buttonStyle(.plain)
    }
}
