// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "Paginator",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Paginator", targets: ["Paginator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
    ],
    targets: [
        .target(
            name: "Paginator",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(name: "PaginatorTests", dependencies: ["Paginator"]),
    ]
)
