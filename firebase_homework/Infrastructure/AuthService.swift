import Foundation
import FirebaseAuth



protocol RegistrationManagerProtocol: AnyObject {
    func createUserFromEmailPassword(email: String, password: String) async throws -> UserCredentials
}

protocol SignInManagerProtocol: AnyObject {
    func signInWithEmailandPassword(email: String, password: String) async throws -> UserCredentials
}

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws -> UserCredentials
    func register(email: String, password: String) async throws -> UserCredentials
}



class RegistrationManager: RegistrationManagerProtocol {
    func createUserFromEmailPassword(email: String, password: String) async throws -> UserCredentials {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        
        try await result.user.sendEmailVerification()
        
        return UserCredentials(
            id: result.user.uid,
            email: result.user.email ?? email
        )
    }
}

class SignInManager: SignInManagerProtocol {
    func signInWithEmailandPassword(email: String, password: String) async throws -> UserCredentials {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return UserCredentials(
            id: result.user.uid,
            email: result.user.email ?? email
        )
    }
}



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
