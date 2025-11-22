// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SuperUI",
    platforms: [.iOS(.v26), .watchOS(.v26), .tvOS(.v26), .macOS(.v26)],
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
