import SwiftUI

public struct OnboardingFlowView: View {
    @State private var step: Int = 1
    @State private var homeName: String = "My Home"
    @State private var roomSelections: [String: Bool] = [
        "Bedroom": false,
        "Kitchen": false,
        "Closet": false,
        "Living Room": false,
        "Bathroom": false,
        "Office": false
    ]
    @State private var itemAdded: Bool = false

    public init() {}

    public var body: some View {
        ZStack {
            content
                .padding(.horizontal, AppMetrics.spacing)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch step {
        case 1: WelcomeView(onContinue: { step = 2 })
        case 2: CreateSpaceView(homeName: $homeName, roomSelections: $roomSelections, onContinue: { step = 3 })
        case 3: AddFirstItemView(onAdd: { itemAdded = true }, onContinue: { step = 4 })
        case 4: QuickTourView(onDone: { step = 5 })
        default: DashboardIntroView(onEnter: {})
        }
    }
}

struct WelcomeView: View {
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppMetrics.spacing) {
            Spacer()
            Image(systemName: "house.fill")
                .font(.system(size: 64))
                .foregroundColor(AppColor.teal)
            Text("Welcome to HomeKeeper — your second brain for home organization.")
                .font(AppTypography.titleLarge())
                .foregroundColor(AppColor.ink)
                .multilineTextAlignment(.center)
            Spacer()
            PrimaryButton("Let’s Begin") { onContinue() }
            LinkButton("Skip onboarding") { onContinue() }
        }
    }
}

struct CreateSpaceView: View {
    @Binding var homeName: String
    @Binding var roomSelections: [String: Bool]
    var onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppMetrics.spacing) {
            Text("Start by creating your first apartment or room.")
                .font(AppTypography.titleMedium())
                .foregroundColor(AppColor.ink)

            TextField("My Home", text: $homeName)
                .textFieldStyle(.roundedBorder)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: AppMetrics.spacingMinor), count: 3), spacing: AppMetrics.spacingMinor) {
                ForEach(roomSelections.keys.sorted(), id: \.[self]) { key in
                    RoomCard(title: key, isSelected: Binding(
                        get: { roomSelections[key] ?? false },
                        set: { roomSelections[key] = $0 }
                    ))
                }
            }

            Text("Don’t worry — you can add more later!")
                .font(AppTypography.caption())
                .foregroundColor(AppColor.ink.opacity(0.6))

            Spacer()
            PrimaryButton("Continue", isEnabled: !homeName.trimmingCharacters(in: .whitespaces).isEmpty) { onContinue() }
        }
    }
}

struct AddFirstItemView: View {
    var onAdd: () -> Void
    var onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppMetrics.spacing) {
            Text("Add your first item")
                .font(AppTypography.titleMedium())
                .foregroundColor(AppColor.ink)

            PhotoCard { onAdd() }

            VStack(spacing: 12) {
                Button(action: { /* mic action */ }) {
                    HStack(spacing: 8) {
                        Image(systemName: "mic.fill")
                        Text("Or say it!")
                    }
                }
                .buttonStyle(.bordered)

                Text("Try saying: ‘Add passport in safe’")
                    .font(AppTypography.caption())
                    .foregroundColor(AppColor.ink.opacity(0.8))
            }

            Spacer()
            PrimaryButton("Continue") { onContinue() }
        }
    }
}

struct QuickTourView: View {
    var onDone: () -> Void

    var body: some View {
        VStack {
            Spacer()
            TooltipCoachmark("Tap here anytime to add new items.")
            TooltipCoachmark("You can talk to HomeKeeper — just say what you’re storing.")
            TooltipCoachmark("Looking for something? Just ask.")
            Spacer()
            PrimaryButton("Got it!") { onDone() }
        }
    }
}

struct DashboardIntroView: View {
    var onEnter: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppMetrics.spacing) {
            Text("Your Home is ready. Add more when you have time — we’ll remember everything for you.")
                .font(AppTypography.titleMedium())
                .foregroundColor(AppColor.ink)

            RoundedRectangle(cornerRadius: AppMetrics.cardRadius)
                .fill(AppColor.softGray)
                .frame(height: 120)
                .overlay(Text("Dashboard placeholder").foregroundColor(AppColor.ink.opacity(0.6)))

            Spacer()
            PrimaryButton("Go to My Home") { onEnter() }
        }
    }
}
