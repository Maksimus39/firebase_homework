import SwiftUI


struct OnboardingView: View {
    @AppStorage(Constants.userDefaults) private var isLogin = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image(.images2)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 280)
                .padding(.bottom, 48)
            
            VStack(spacing: 32) {
                VStack(spacing: 12) {
                    Text(Constants.welcomeTitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                        .lineLimit(2)
                    
                    Text(Constants.welcomeSubtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 24) {
                    VStack(spacing: 6) {
                        Text(Constants.syncTitle)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        
                        Text(Constants.syncDescription)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Text(Constants.securityNote)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            UniversalButton(image: Constants.buttonOnboardingImage) {
                isLogin = true
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [.appWhite, .appDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

#Preview {
    OnboardingView()
}
