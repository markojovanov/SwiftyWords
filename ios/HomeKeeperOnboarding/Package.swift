// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HomeKeeperOnboarding",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "HomeKeeperOnboarding",
            targets: ["HomeKeeperOnboarding"]
        )
    ],
    targets: [
        .target(
            name: "HomeKeeperOnboarding",
            resources: [
                .process("Resources")
            ]
        )
    ]
)