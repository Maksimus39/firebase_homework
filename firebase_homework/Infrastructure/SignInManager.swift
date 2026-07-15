import Foundation
import FirebaseAuth




protocol SignInManagerProtocol: AnyObject {
    func signInWithEmailandPassword(email: String, password: String) async throws -> UserCredentials
}


class SignInManager {
    func signInWithEmailandPassword(email: String, password: String) async throws -> UserCredentials {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return UserCredentials(
            id: result.user.uid,
            email: result.user.email ?? email
        )
    }
}
