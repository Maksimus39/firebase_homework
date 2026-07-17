import SwiftUI
import FirebaseCore


enum AppState {
    case onboarding
    case authenticated
    case mainApp
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
    
    private var appState: AppState {
        if viewModel.currentUser != nil {
            return .mainApp
        } else if isLogin {
            return .authenticated
        } else {
            return .authenticated
        }
    }
      
    
    var body: some Scene {
        WindowGroup {
            switch appState {
            case .onboarding: OnboardingView()
            case .authenticated: ContentView().environmentObject(viewModel)
            case .mainApp: EmailAuthPageView().environmentObject(viewModel)
            }
        }
    }
}
