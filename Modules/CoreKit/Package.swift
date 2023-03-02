// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreKit",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]
        )
    ],
    dependencies: [
        .package(path: "../Injection"),
        .package(path: "../CoreApp")
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [
                "Injection",
                "CoreApp"
            ]
        )
    ]
)
