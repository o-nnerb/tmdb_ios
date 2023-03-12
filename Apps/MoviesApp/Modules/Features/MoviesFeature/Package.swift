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
        .package(
            url: "https://github.com/brennobemoura/navigation-kit.git",
            from: "1.0.0-alpha.2"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "0.52.0"
        ),

        .package(path: "../../../../../Modules/Injection"),
        .package(path: "../../../../../Modules/SuperKit"),
        .package(path: "../../../../../Modules/SuperUI"),
        .package(path: "../../MoviesDomain"),
        .package(path: "../../MoviesScenes")
    ],
    targets: [
        .target(
            name: "MoviesFeature",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),

                "Injection",
                "SuperKit",
                "SuperUI",
                "MoviesDomain",
                "MoviesScenes"
            ]
        )
    ]
)