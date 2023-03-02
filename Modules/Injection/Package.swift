// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Injection",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "Injection",
            targets: ["Injection"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Injection",
            dependencies: []
        )
    ]
)
