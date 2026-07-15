import Foundation
import FirebaseAuth




protocol RegistrationManagerProtocol: AnyObject {
    func createUserFromEmailPassword(email: String, password: String) async throws -> UserCredentials
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
