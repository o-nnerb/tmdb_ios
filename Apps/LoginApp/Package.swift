// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginApp",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "LoginApp",
            targets: ["LoginApp"]
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
            name: "LoginDomain",
            dependencies: [
                "Factory",
                "SuperKit"
            ]
        ),
        .target(
            name: "LoginData",
            dependencies: [
                "Factory",
                "SuperKit",
                "LoginDomain"
            ]
        ),
        .target(
            name: "LoginStorage",
            dependencies: [
                "Factory",
                "SuperKit",
                "LoginDomain",
                "LoginData"
            ]
        ),
        .target(
            name: "LoginNetworking",
            dependencies: [
                "Factory",
                "SuperKit",
                "LoginDomain",
                "LoginData",
                .product(name: "RequestDL", package: "request-dl-nio")
            ]
        ),
        .target(
            name: "LoginScenes",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI",
                "LoginDomain"
            ]
        ),
        // MARK: - Features targets
        .target(
            name: "CoreFeature",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI",
                "LoginDomain",
                "LoginScenes",
            ],
            path: "Sources/Features/CoreFeature"
        ),
        // MARK: - App target
        .target(
            name: "LoginApp",
            dependencies: [
                .product(name: "NavigationKit", package: "navigation-kit"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Factory",
                "SuperKit",
                "SuperUI",

                "LoginDomain",
                "LoginData",
                "LoginStorage",
                "LoginNetworking",
                "LoginScenes",

                "CoreFeature"
            ]
        )
    ]
)
