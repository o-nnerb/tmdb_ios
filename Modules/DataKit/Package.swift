// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataKit",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "DataKit",
            targets: ["DataKit"]
        )
    ],
    dependencies: [
        .package(path: "../Injection"),
        .package(path: "../CoreApp"),
        .package(path: "../CoreKit")
    ],
    targets: [
        .target(
            name: "DataKit",
            dependencies: [
                "Injection",
                "CoreApp",
                "CoreKit"
            ]
        )
    ]
)