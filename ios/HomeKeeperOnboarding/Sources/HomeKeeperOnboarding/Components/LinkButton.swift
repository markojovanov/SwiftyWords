import SwiftUI

public struct LinkButton: View {
    public let title: String
    public let action: () -> Void

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.body())
                .foregroundColor(AppColor.ink.opacity(0.6))
        }
        .buttonStyle(.plain)
    }
}
