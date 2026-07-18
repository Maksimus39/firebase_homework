import SwiftUI

enum AuthRoute: Hashable {
    case email
    case google
    case apple
}

struct AuthMethod: Identifiable {
    let id: AuthRoute
    let title: String
    let icon: String
    
    static let all: [AuthMethod] = [
        AuthMethod(id: .email, title: Constants.emailAndPassword, icon: Constants.envelopeFill),
        AuthMethod(id: .google, title: Constants.google, icon: Constants.gCircleFill),
        AuthMethod(id: .apple, title: Constants.appleID, icon: Constants.appleLogo)
    ]
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(AuthMethod.all) { method in
                        NavigationLink(value: method.id) {
                            HStack(spacing: 16) {
                                Image(systemName: method.icon)
                                    .font(.title2)
                                    .frame(width: 32)
                                
                                Text(method.title)
                                    .font(.body)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                Image(systemName: Constants.chevronRight)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(.white.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                    }
                }
                .padding(.top, 8)
            }
            .applyGradientBackground()
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .email:
                    EmailAuthPage()
                case .google:
                    GoogleAuthPage()
                case .apple:
                    AppleAuthPage()
                }
            }
            .navigationTitle(Constants.login)
        }
    }
}
