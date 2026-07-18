import SwiftUI


extension View {
    func applyGradientBackground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [.appWhite, .appDark],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}
