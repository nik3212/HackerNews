// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Home", targets: ["Home"]),
        .library(name: "HomeInterfaces", targets: ["HomeInterfaces"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
        .package(url: "https://github.com/space-code/network-layer.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.10.1")),
        .package(path: "../../../../../space-code/skeleton-ui"),
        .package(path: "../../../../..//space-code/blade"),
        .package(path: "../../Common/AppUtils"),
        .package(path: "../../Common/UIExtensions"),
        .package(path: "../../Common/HackerNewsLocalization"),
        .package(path: "../../Common/DesignKit"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "HomeInterfaces",
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "AppUtils", package: "AppUtils"),
                .product(name: "NetworkLayer", package: "network-layer"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "UIExtensions", package: "UIExtensions"),
                .product(name: "HackerNewsLocalization", package: "HackerNewsLocalization"),
                .product(name: "DesignKit", package: "DesignKit"),
                .product(name: "SkeletonUI", package: "skeleton-ui"),
                .product(name: "Blade", package: "blade"),
                .product(name: "BladeTCA", package: "blade"),
            ]
        ),
        .target(name: "HomeInterfaces", dependencies: []),
        .testTarget(name: "HomeTests", dependencies: ["Home"]),
    ]
)
