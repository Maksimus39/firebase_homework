import Foundation


protocol RegistrationManagerProtocol: AnyObject {
    func createUserFromEmailPassword(email: String, password: String) async throws -> UserCredentials
}
