import SwiftUI


enum AppState {
    case onboarding
    case authenticated
    case mainApp
}


@main
struct firebase_homeworkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var sessionManager = SessionManager()
    @AppStorage(Constants.userDefaults) private var isLogin = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if sessionManager.isAuthenticated {
                    EmailAuthPageView()
                } else if isLogin {
                    ContentView()
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(sessionManager) 
        }
    }
}
