import SwiftUI



struct EmailAuthPageView: View {
    @EnvironmentObject var viewModel: DataViewModel
    @AppStorage(Constants.userDefaults) private var isLogin = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Constants.successTitle)
                .font(.title)
            
            Text("Тут будет продолжение по домашним заданиям 4го модуля")
                .font(.title)
            
            Spacer()
            
            Button(role: .destructive) {
                isLogin = false
                viewModel.logout()
                
            } label: {
                Text(Constants.logoutButton)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .applyGradientBackground()
        .navigationTitle(Constants.navigationTitleEmail)
    }
}
