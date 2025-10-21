# HomeKeeper Onboarding (SwiftUI + SPM)

This is a lightweight Swift Package containing the onboarding flow screens and components for HomeKeeper.

## Open in Xcode
1. Open the existing Xcode project (`SwiftyWords.xcodeproj`).
2. In the Project Navigator, right-click the project root > "Add Packages…".
3. Click the "+" to add a local package, then choose `ios/HomeKeeperOnboarding`.
4. Add the product `HomeKeeperOnboarding` to your app target.

## Use the flow
```swift
import SwiftUI
import HomeKeeperOnboarding

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingFlowView()
        }
    }
}
```

Alternatively, push `OnboardingFlowView()` anywhere in your app.

## Notes
- iOS 16+
- Resources include a placeholder Lottie file and images folder.
- Voice and camera integrations are stubs; replace with real implementations later.
