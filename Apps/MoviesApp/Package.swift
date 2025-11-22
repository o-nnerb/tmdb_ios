// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesApp",
    platforms: [.iOS(.v26), .watchOS(.v26), .tvOS(.v26), .macOS(.v26)],
    products: [
        .library(
            name: "MoviesApp",
            targets: ["MoviesApp"]
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
        ),
        .package(
            url: "https://github.com/request-dl/request-dl-nio.git",
            from: "3.1.1"
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
                .product(name: "RequestDL", package: "request-dl-nio")
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
