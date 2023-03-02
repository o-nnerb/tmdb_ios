// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreScene",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "CoreScene",
            targets: ["CoreScene"]
        )
    ],
    dependencies: [
        .package(path: "../Injection"),
        .package(path: "../CoreApp"),
        .package(path: "../CoreKit"),
        .package(
            url: "https://github.com/brennobemoura/navigation-kit.git",
            from: "1.0.0-alpha"
        )
    ],
    targets: [
        .target(
            name: "CoreScene",
            dependencies: [
                "Injection",
                "CoreApp",
                "CoreKit",
                .product(name: "NavigationKit", package: "navigation-kit")
            ]
        )
    ]
)
