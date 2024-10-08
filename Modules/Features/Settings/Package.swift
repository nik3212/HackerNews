// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Settings", targets: ["Settings"]),
        .library(name: "SettingsInterfaces", targets: ["SettingsInterfaces"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
        .package(path: "../../Common/HackerNewsLocalization"),
        .package(path: "../../Common/DesignKit"),
        .package(path: "../../Common/UIExtensions"),
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
                "SettingsInterfaces",
                .product(name: "UIExtensions", package: "UIExtensions"),
                .product(name: "DesignKit", package: "DesignKit"),
                .product(name: "HackerNewsLocalization", package: "HackerNewsLocalization"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(name: "SettingsInterfaces"),
        .testTarget(name: "SettingsTests", dependencies: ["Settings"]),
    ]
)
