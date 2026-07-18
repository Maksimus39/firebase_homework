import SwiftUI


struct EmailAuthPageView: View {
    @EnvironmentObject var sessionManager: SessionManager 
    @AppStorage(Constants.userDefaults) private var isLogin = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Привет, \(sessionManager.currentUser?.email ?? "User")!")
            
            Button(role: .destructive) {
                sessionManager.logout()
                isLogin = false
            } label: {
                Text(Constants.logoutButton)
            }
        }
        .applyGradientBackground()
    }
}
