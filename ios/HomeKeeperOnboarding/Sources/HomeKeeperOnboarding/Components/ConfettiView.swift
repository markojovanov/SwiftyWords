import SwiftUI

public struct ConfettiView: View {
    @Binding var isPresented: Bool

    public init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    public var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.01)
                    .ignoresSafeArea()
                    .onTapGesture { isPresented = false }
                // Placeholder confetti: replace with real Lottie container
                VStack(spacing: 12) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 56))
                        .foregroundColor(.yellow)
                    Text("🎉 Nice! You just remembered your first thing.")
                        .font(AppTypography.body())
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Capsule())
                }
            }
        }
        .animation(.easeOut(duration: 0.25), value: isPresented)
    }
}
