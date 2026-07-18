import Foundation


protocol SignInManagerProtocol: AnyObject {
    func signInWithEmailandPassword(email: String, password: String) async throws -> UserCredentials
}
