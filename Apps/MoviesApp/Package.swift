// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesApp",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "MoviesApp",
            targets: ["MoviesApp"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/brennobemoura/navigation-kit.git",
            from: "1.0.0-alpha.4"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "0.53.2"
        ),
        .package(
            url: "https://github.com/hmlongco/Factory.git",
            from: "2.1.5"
        ),
        .package(
            url: "https://github.com/request-dl/request-dl.git",
            from: "2.3.0"
        ),
        .package(path: "../../Modules/SuperKit"),
        .package(path: "../../Modules/SuperUI")
    ],
    targets: [
        // MARK: - Core targets
        .target(
            name: "MoviesDomain",
            dependencies: [
                "Factory",
                "SuperKit"
            ]
        ),
        .target(
            name: "MoviesData",
            dependencies: [
                "Factory",
                "SuperKit",
                "MoviesDomain"
            ]
        ),
        .target(
            name: "MoviesStorage",
            dependencies: [
                "Factory",
                "SuperKit",
                "MoviesDomain",
                "MoviesData"
            ]
        ),
        .target(
            name: "MoviesNetworking",
            dependencies: [
                "Factory",
                "SuperKit",
                "MoviesDomain",
                "MoviesData",
                .product(name: "RequestDL", package: "request-dl")
            ]
        ),
        .target(
            name: "MoviesScenes",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI",
                "MoviesDomain"
            ]
        ),
        // MARK: - Features targets
        .target(
            name: "MoviesFeature",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI",
                "MoviesDomain",
                "MoviesScenes",
            ],
            path: "Sources/Features/MoviesFeature"
        ),
        // MARK: - App target
        .target(
            name: "MoviesApp",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI",

                "MoviesDomain",
                "MoviesData",
                "MoviesStorage",
                "MoviesNetworking",
                "MoviesScenes",

                "MoviesFeature"
            ]
        )
    ]
)
