// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Home", targets: ["Home"]),
        .library(name: "HomeInterfaces", targets: ["HomeInterfaces"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
        .package(url: "https://github.com/space-code/network-layer.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../Common/AppUtils"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "HomeInterfaces",
                .product(name: "AppUtils", package: "AppUtils"),
                .product(name: "NetworkLayer", package: "network-layer"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(name: "HomeInterfaces", dependencies: []),
        .testTarget(name: "HomeTests", dependencies: ["Home"]),
    ]
)
