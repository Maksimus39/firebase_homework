import SwiftUI


struct AppleAuthPage: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "apple.logo")
                .font(.system(size: 60))
            Text("Вход через Apple ID")
                .font(.title2)
            Button("Продолжить") { /* TODO */ }
                .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Apple ID")
    }
}
