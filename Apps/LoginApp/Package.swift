// swift-tools-version: 5.8
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
                .product(name: "RequestDL", package: "request-dl")
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
