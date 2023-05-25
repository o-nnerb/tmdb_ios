// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginNetworking",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "LoginNetworking",
            targets: ["LoginNetworking"]
        )
    ],
    dependencies: [
        .package(path: "../../../../Modules/Injection"),
        .package(path: "../../../../Modules/SuperKit"),
        .package(path: "../LoginDomain"),
        .package(path: "../LoginData"),
        .package(
            url: "https://github.com/brennobemoura/request-dl.git",
            from: "2.2.0"
        )
    ],
    targets: [
        .target(
            name: "LoginNetworking",
            dependencies: [
                "Injection",
                "SuperKit",
                "LoginDomain",
                "LoginData",
                .product(name: "RequestDL", package: "request-dl")
            ]
        )
    ]
)
