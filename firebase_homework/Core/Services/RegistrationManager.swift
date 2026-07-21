import Foundation
import FirebaseAuth
import FirebaseFirestore


final class RegistrationManager: RegistrationManagerProtocol {
    func createUserFromEmailPassword(email: String, password: String, userName: String) async throws -> UserCredentials {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        
        try await result.user.sendEmailVerification()
        
        return UserCredentials(
            id: result.user.uid,
            email: result.user.email ?? email
        )
    }
    
    // data user
    private func setUserData(userID: String, userName: String, userEmail: String) async throws {
        let usersDocument = Firestore.firestore().collection("users").document(userID)
        
        try await usersDocument.setData([
            :
        ])
    }
}
