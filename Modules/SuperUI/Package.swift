// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SuperUI",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "SuperUI",
            targets: ["SuperUI"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SuperUI",
            dependencies: [],
            resources: [.process("Resources")]
        )
    ]
)
