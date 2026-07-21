import Foundation


protocol RegistrationManagerProtocol: AnyObject {
    func createUserFromEmailPassword(email: String, password: String, userName: String) async throws -> UserCredentials
}
