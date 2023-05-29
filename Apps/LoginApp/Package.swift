// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let cores = [
    "LoginDomain",
    "LoginData",
    "LoginNetworking",
    "LoginStorage"
]

let features = [
    "CoreFeature"
]

let package = Package(
    name: "LoginApp",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "LoginApp",
            targets: ["LoginApp"]
        )
    ],
    dependencies: cores.map {
        .package(path: "Modules/\($0)")
    } + features.map {
        .package(path: "Modules/Features/\($0)")
    } + [
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
        .package(path: "../../Modules/SuperKit"),
        .package(path: "../../Modules/SuperUI")
    ],
    targets: [
        .target(
            name: "LoginApp",
            dependencies: cores.map {
                .product(name: $0, package: $0)
            } + features.map {
                .product(name: $0, package: $0)
            } + [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI"
            ]
        )
    ]
)
