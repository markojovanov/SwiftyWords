import SwiftUI

public struct RoomCard: View {
    public let title: String
    @Binding public var isSelected: Bool

    public init(title: String, isSelected: Binding<Bool>) {
        self.title = title
        self._isSelected = isSelected
    }

    public var body: some View {
        VStack(spacing: 8) {
            Image(systemName: isSelected ? "house.fill" : "house")
                .font(.system(size: 28))
                .foregroundColor(isSelected ? AppColor.teal : AppColor.ink.opacity(0.6))
            Text(title)
                .font(AppTypography.body())
                .foregroundColor(AppColor.ink)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 112)
        .background(
            RoundedRectangle(cornerRadius: AppMetrics.cardRadius)
                .fill(AppColor.teal.opacity(isSelected ? 0.1 : 0.0))
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppMetrics.cardRadius)
                .stroke(isSelected ? AppColor.teal : Color.gray.opacity(0.2), lineWidth: 1)
        )
        .onTapGesture { isSelected.toggle() }
    }
}
