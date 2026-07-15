import SwiftUI
import FirebaseCore


enum AppState {
    case onboarding
    case authenticated
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct firebase_homeworkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = DataViewModel()
    @AppStorage(Constants.userDefaults) private var isLogin = false
    
    private var appState: AppState { isLogin ? .authenticated : .onboarding }
      
    
    var body: some Scene {
        WindowGroup {
            switch appState {
            case .onboarding: OnboardingView()
            case .authenticated: ContentView().environmentObject(viewModel)
            }
        }
    }
}
