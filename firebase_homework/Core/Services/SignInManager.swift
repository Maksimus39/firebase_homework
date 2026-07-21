import Foundation
import FirebaseAuth


final class SignInManager: SignInManagerProtocol {
    func signInWithEmailandPassword(email: String, password: String) async throws -> UserCredentials {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return UserCredentials(
            id: result.user.uid,
            email: result.user.email ?? email
        )
    }
}
