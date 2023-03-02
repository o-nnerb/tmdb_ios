// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let cores = [
    "Injection",
    "CoreApp",
    "CoreKit",
    "DataKit",
    "CoreNetwork",
    "CoreStorage"
]

let features = [
    "MoviesFeature"
]

let package = Package(
    name: "TMDbApp",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "TMDbApp",
            targets: ["TMDbApp"]
        )
    ],
    dependencies: cores.map {
        .package(path: "../\($0)")
    } + features.map {
        .package(path: "../Features/\($0)")
    } + [
        .package(
            url: "https://github.com/brennobemoura/navigation-kit.git",
            from: "1.0.0-alpha"
        )
    ],
    targets: [
        .target(
            name: "TMDbApp",
            dependencies: cores.map {
                .product(name: $0, package: $0)
            } + features.map {
                .product(name: $0, package: $0)
            } + [
                .product(name: "NavigationKit", package: "navigation-kit")
            ]
        )
    ]
)
