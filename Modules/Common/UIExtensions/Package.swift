// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "UIExtensions",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "UIExtensions", targets: ["UIExtensions"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "UIExtensions", dependencies: []),
        .testTarget(name: "UIExtensionsTests", dependencies: ["UIExtensions"]),
    ]
)
