import SwiftUI

struct EmailAuthPage: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    
    @AppStorage(Constants.userDefaults) private var isLogin = false
    @State private var isRegisterMode = true
    
    var body: some View {
        VStack(spacing: 16) {
            Text(isRegisterMode ? Constants.createAccount : Constants.signIn )
                .font(.title2)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 4) {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                if let error = viewModel.emailError {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                SecureField("Пароль", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                if let error = viewModel.passwordError {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            
            UniversalButton(textButton: isRegisterMode ? Constants.signUpButton : Constants.LogIn, image: Constants.buttonOnboardingImage) {
                Task {
                    if isRegisterMode {
                        await viewModel.register()
                    } else {
                        await viewModel.login()
                    }
                    
                   
                    if sessionManager.isAuthenticated {
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
                viewModel.clearErrors()
            }
            .font(.caption)
            .foregroundStyle(.blue)
        }
        .padding(24)
        .applyGradientBackground()
        .navigationTitle(isRegisterMode ? Constants.signUpTitle : Constants.signInTitle)
    }
}


