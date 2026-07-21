import Foundation
import Combine
import FirebaseAuth

final class SessionManager: ObservableObject {
    @Published var currentUser: UserCredentials?
    @Published var isAuthenticated: Bool = false
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        setupAuthListener()
    }
    
    private func setupAuthListener() {
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?.currentUser = UserCredentials(id: user.uid, email: user.email ?? "")
                self?.isAuthenticated = true
            } else {
                self?.currentUser = nil
                self?.isAuthenticated = false
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Logout error: \(error.localizedDescription)")
        }
    }
    
    deinit {
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}
