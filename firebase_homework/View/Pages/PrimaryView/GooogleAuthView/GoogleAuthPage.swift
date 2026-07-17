import SwiftUI


struct GoogleAuthPage: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: Constants.gCircleFill)
                .font(.system(size: 60))
            Text(Constants.googleTitle)
                .font(.title2)
            UniversalButton(textButton: Constants.continueButton, image: Constants.buttonOnboardingImage) {
                print("Activate")
            }
            .padding()
        }
        .applyGradientBackground()
        .navigationTitle(Constants.navigationTitle)
    }
}
