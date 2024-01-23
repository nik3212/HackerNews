// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "Paginator",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Paginator", targets: ["Paginator"]),
        .library(name: "PaginatorTCA", targets: ["PaginatorTCA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
    ],
    targets: [
        .target(name: "Paginator"),
        .target(
            name: "PaginatorTCA",
            dependencies: [
                "Paginator",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(name: "PaginatorTests", dependencies: ["Paginator"]),
    ]
)
