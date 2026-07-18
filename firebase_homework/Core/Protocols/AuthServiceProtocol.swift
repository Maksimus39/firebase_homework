import Foundation


protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws -> UserCredentials
    func register(email: String, password: String) async throws -> UserCredentials
}
