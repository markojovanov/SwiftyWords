import SwiftUI

public struct PrimaryButton: View {
    public let title: String
    public let action: () -> Void
    public var isEnabled: Bool

    public init(_ title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.body())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: AppMetrics.buttonHeight)
                .background((isEnabled ? AppColor.teal : AppColor.teal.opacity(0.4)))
                .clipShape(Capsule())
        }
        .disabled(!isEnabled)
    }
}
