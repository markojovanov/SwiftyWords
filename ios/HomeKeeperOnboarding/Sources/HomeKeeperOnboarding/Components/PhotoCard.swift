import SwiftUI

public struct PhotoCard: View {
    public var onTap: () -> Void

    public init(onTap: @escaping () -> Void) {
        self.onTap = onTap
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppMetrics.cardRadius)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(Color.gray.opacity(0.4))
            VStack(spacing: 12) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 28))
                    .foregroundColor(AppColor.ink.opacity(0.7))
                Text("📸 Add your first item")
                    .font(AppTypography.body())
                    .foregroundColor(AppColor.ink)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .contentShape(RoundedRectangle(cornerRadius: AppMetrics.cardRadius))
        .onTapGesture { onTap() }
    }
}
