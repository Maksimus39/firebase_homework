import SwiftUI



enum AppFont: String {
    case blackOps = "BlackOpsOne-Regular"
}

extension Text {
    func appTitleFont(size: CGFloat) -> some View {
        self.font(.custom(AppFont.blackOps.rawValue, size: size, relativeTo: .title))
    }
}
