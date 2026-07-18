import Foundation
import FirebaseAuth


class AuthService: AuthServiceProtocol {
    private let registrationManager: RegistrationManagerProtocol
    private let signInManager: SignInManagerProtocol
    
    init(registrationManager: RegistrationManagerProtocol = RegistrationManager(),
         signInManager: SignInManagerProtocol = SignInManager()) {
        self.registrationManager = registrationManager
        self.signInManager = signInManager
    }
    
    func signIn(email: String, password: String) async throws -> UserCredentials {
        return try await signInManager.signInWithEmailandPassword(email: email, password: password)
    }
    
    func register(email: String, password: String) async throws -> UserCredentials {
        return try await registrationManager.createUserFromEmailPassword(email: email, password: password)
    }
}
