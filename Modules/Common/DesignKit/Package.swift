// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let package = Package(
    name: "DesignKit",
    products: [
        .library(name: "DesignKit", targets: ["DesignKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DesignKit",
            dependencies: [],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(name: "DesignKitTests", dependencies: ["DesignKit"]),
    ]
)
