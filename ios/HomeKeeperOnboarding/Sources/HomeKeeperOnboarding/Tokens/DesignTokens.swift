import SwiftUI

public enum AppColor {
    public static let teal = Color(red: 0/255, green: 165/255, blue: 165/255)
    public static let coral = Color(red: 255/255, green: 118/255, blue: 96/255)
    public static let softGray = Color(red: 244/255, green: 245/255, blue: 246/255)
    public static let ink = Color(white: 0.11)
}

public enum AppTypography {
    public static func titleLarge() -> Font { .system(size: 28, weight: .bold, design: .default) }
    public static func titleMedium() -> Font { .system(size: 22, weight: .bold, design: .default) }
    public static func body() -> Font { .system(size: 17, weight: .regular, design: .default) }
    public static func caption() -> Font { .system(size: 13, weight: .regular, design: .default) }
}

public enum AppMetrics {
    public static let spacing: CGFloat = 24
    public static let spacingMinor: CGFloat = 12
    public static let cardRadius: CGFloat = 20
    public static let buttonHeight: CGFloat = 52
}
