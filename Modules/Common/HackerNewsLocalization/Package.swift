// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let package = Package(
    name: "HackerNewsLocalization",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "HackerNewsLocalization", targets: ["HackerNewsLocalization"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "HackerNewsLocalization", dependencies: []),
    ]
)
