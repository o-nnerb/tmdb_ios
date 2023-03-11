// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesFeature",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "MoviesFeature",
            targets: ["MoviesFeature"]
        )
    ],
    dependencies: [
        .package(path: "../../Injection"),
        .package(path: "../../CoreApp"),
        .package(path: "../../CoreKit"),
        .package(path: "../../CoreScene"),
        .package(
            url: "https://github.com/brennobemoura/navigation-kit.git",
            from: "1.0.0-alpha"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "0.52.0"
        )
    ],
    targets: [
        .target(
            name: "MoviesFeature",
            dependencies: [
                "Injection",
                "CoreApp",
                "CoreKit",
                "CoreScene",
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
