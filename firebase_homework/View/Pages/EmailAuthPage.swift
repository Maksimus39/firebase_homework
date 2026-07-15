import SwiftUI


struct EmailAuthPage: View {
    @EnvironmentObject var viewModel: DataViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Пароль", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            
            Button("Зарегистрироваться") {
                Task { await viewModel.registerUser() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .navigationTitle("Email")
    }
}
