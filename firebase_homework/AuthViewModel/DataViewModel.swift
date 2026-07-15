import Foundation
import Combine


protocol DataViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var currentUser: UserCredentials? { get }
    
    func registerUser() async
}


class DataViewModel: ObservableObject, DataViewModelProtocol {
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var currentUser: UserCredentials?
    @Published var email: String
    @Published var password: String
    
    
    private let registrationManager: RegistrationManagerProtocol
    
    
    init(registrationManager: RegistrationManagerProtocol = RegistrationManager(),
         email: String = "",
         password: String = "") {
        self.registrationManager = registrationManager
        self.email = email
        self.password = password
    }
    
    
    func registerUser() async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        guard !trimmedEmail.isEmpty, !password.isEmpty else {
            errorMessage = Constants.errorMessage
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let credentials = try await registrationManager.createUserFromEmailPassword(
                email: trimmedEmail,
                password: password
            )
            self.currentUser = credentials
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
