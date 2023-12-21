// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "AppUtils",
    products: [
        .library(name: "AppUtils", targets: ["AppUtils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AliSoftware/Dip.git", .upToNextMajor(from: "7.1.1")),
    ],
    targets: [
        .target(name: "AppUtils", dependencies: [
            .product(name: "Dip", package: "Dip"),
        ]),
        .testTarget(name: "AppUtilsTests", dependencies: ["AppUtils"]),
    ]
)
