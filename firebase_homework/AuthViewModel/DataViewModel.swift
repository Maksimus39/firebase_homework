import Foundation
import Combine
import FirebaseAuth


protocol DataViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var currentUser: UserCredentials? { get }
    var isRegistrationSuccessful: Bool { get }
    
    func registerUser() async
    func resetState()
    func clearError()
}

class DataViewModel: ObservableObject, DataViewModelProtocol {
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var currentUser: UserCredentials?
    @Published private(set) var isRegistrationSuccessful: Bool = false
    @Published var email: String
    @Published var password: String
    @Published var appState: AppState = .onboarding
    
    private let registrationManager: RegistrationManagerProtocol
    private let signInManager: SignInManagerProtocol
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    
    init(registrationManager: RegistrationManagerProtocol = RegistrationManager(),
         signInManager: SignInManagerProtocol = SignInManager(),
            email: String = "",
            password: String = "") {
           self.registrationManager = registrationManager
           self.signInManager = signInManager
           self.email = email
           self.password = password
           
           setupAuthListener()
       }
    
    func loginUser() async {
            let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
            guard !trimmedEmail.isEmpty, !password.isEmpty else {
                errorMessage = Constants.errorMessage
                return
            }
            
            isLoading = true
            errorMessage = nil
            
            do {
                let credentials = try await signInManager.signInWithEmailandPassword(
                    email: trimmedEmail,
                    password: password
                )
                self.currentUser = credentials
                self.isRegistrationSuccessful = true
                
            } catch {
                self.errorMessage = error.localizedDescription
                self.isRegistrationSuccessful = false
            }
            
            isLoading = false
        }
    
    private func setupAuthListener() {
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?.currentUser = UserCredentials(id: user.uid, email: user.email ?? "")
                self?.appState = .mainApp
            } else {
                self?.currentUser = nil
                self?.appState = .onboarding
            }
        }
    }
    
    func registerUser() async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        guard !trimmedEmail.isEmpty, !password.isEmpty else {
            errorMessage = Constants.errorMessage
            return
        }
        
        isLoading = true
        errorMessage = nil
        isRegistrationSuccessful = false
        
        do {
            let credentials = try await registrationManager.createUserFromEmailPassword(
                email: trimmedEmail,
                password: password
            )
            self.currentUser = credentials
            self.isRegistrationSuccessful = true
            
        } catch {
            self.errorMessage = error.localizedDescription
            self.isRegistrationSuccessful = false
        }
        
        isLoading = false
    }
    
    func logout() {
        do {
            try Auth.auth().signOut() 
        } catch {
            print("Ошибка при выходе: \(error.localizedDescription)")
        }
        
        currentUser = nil
        isRegistrationSuccessful = false
        email = ""
        password = ""
        errorMessage = nil
    }
    
    func resetState() {
        errorMessage = nil
        isRegistrationSuccessful = false
        email = ""
        password = ""
    }
    
    func clearError() {
        self.errorMessage = nil
    }
    
    deinit {
        
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}
