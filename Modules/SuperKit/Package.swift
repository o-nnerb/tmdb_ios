// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SuperKit",
    platforms: [.iOS(.v26), .watchOS(.v26), .tvOS(.v26), .macOS(.v26)],
    products: [
        .library(
            name: "SuperKit",
            targets: ["SuperKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/brennobemoura/navigation-kit.git",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "1.23.1"
        ),
        .package(
            url: "https://github.com/hmlongco/Factory.git",
            from: "2.5.3"
        )
    ],
    targets: [
        .target(
            name: "SuperKit",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory"
            ]
        )
    ]
)
