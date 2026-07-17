import SwiftUI



struct UniversalButton: View {
    var textButton: String
    var image: String
    var buttonAction: () -> Void
    
    init(textButton: String, image: String, buttonAction: @escaping () -> Void) {
        self.textButton = textButton
        self.image = image
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack(spacing: 36) {
                Text(textButton)
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
