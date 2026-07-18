import SwiftUI


struct AppleAuthPage: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: Constants.appleLogo)
                .font(.system(size: 60))
            Text(Constants.signInWithAppleID)
                .font(.title2)
            Text("Работаем над реализацией")
                .font(.title)
                .foregroundColor(.red)
            UniversalButton(textButton: Constants.continuee, image: Constants.buttonOnboardingImage) {
                print("Activate")
            }
            .padding()
        }
        .applyGradientBackground()
        .navigationTitle(Constants.appleID)
    }
}
