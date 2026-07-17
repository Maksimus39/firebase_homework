import SwiftUI




struct EmailAuthPage: View {
    @EnvironmentObject var viewModel: DataViewModel
    @AppStorage(Constants.userDefaults) private var isLogin = false
    @State private var isRegisterMode = true
    
    var body: some View {
        VStack(spacing: 16) {
            Text(isRegisterMode ? Constants.createAccount : Constants.signIn )
                .font(.title2)
                .fontWeight(.bold)

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Пароль", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            UniversalButton(textButton: isRegisterMode ? Constants.signUpButton : Constants.LogIn, image: Constants.buttonOnboardingImage) {
                Task {
                    if isRegisterMode {
                        await viewModel.registerUser()
                    } else {
                        await viewModel.loginUser()
                    }
                    
                    if viewModel.isRegistrationSuccessful {
                        isLogin = true
                    }
                }
            }
            .disabled(viewModel.isLoading)
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 8)
            }
            
            Button(isRegisterMode ? Constants.signInPrompt : Constants.signUpPrompt) {
                isRegisterMode.toggle()
                viewModel.clearError()
            }
            .font(.caption)
            .foregroundStyle(.blue)
        }
        .padding(24)
        .applyGradientBackground()
        .navigationTitle(isRegisterMode ? Constants.signUpTitle : Constants.signInTitle)
    }
}
