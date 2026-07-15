import SwiftUI


struct GoogleAuthPage: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "g.circle.fill")
                .font(.system(size: 60))
            Text("Вход через Google")
                .font(.title2)
            Button("Продолжить") { /* TODO */ }
                .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Google")
    }
}
