import Foundation
import Combine



final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var emailError: String?
    @Published var passwordError: String?
    
    private let authService: AuthServiceProtocol
    private let validationService: ValidationServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService(),
         validationService: ValidationServiceProtocol = ValidationService.shared) {
        self.authService = authService
        self.validationService = validationService
    }
    
    func validateForm() -> Bool {
        var isValid = true
        
        switch validationService.validate(email: email) {
        case .success(let validEmail):
            emailError = nil
            email = validEmail
        case .failure(let error):
            emailError = error.errorDescription
            isValid = false
        }
        
        switch validationService.validate(password: password) {
        case .success:
            passwordError = nil
        case .failure(let error):
            passwordError = error.errorDescription
            isValid = false
        }
        
        return isValid
    }
    
    func login() async {
        guard validateForm() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await authService.signIn(email: email, password: password)
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func register() async {
        guard validateForm() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await authService.register(email: email, password: password)
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func clearErrors() {
        errorMessage = nil
        emailError = nil
        passwordError = nil
    }
}
