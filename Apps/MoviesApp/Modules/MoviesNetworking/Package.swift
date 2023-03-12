// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesNetworking",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "MoviesNetworking",
            targets: ["MoviesNetworking"]
        )
    ],
    dependencies: [
        .package(path: "../../../../Modules/Injection"),
        .package(path: "../../../../Modules/SuperKit"),
        .package(path: "../MoviesDomain"),
        .package(path: "../MoviesData"),
        .package(
            url: "https://github.com/brennobemoura/request-dl.git",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "MoviesNetworking",
            dependencies: [
                "Injection",
                "SuperKit",
                "MoviesDomain",
                "MoviesData",
                .product(name: "RequestDL", package: "request-dl")
            ]
        )
    ]
)