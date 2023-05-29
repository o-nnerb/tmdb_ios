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
        .package(
            url: "https://github.com/hmlongco/Factory.git",
            from: "2.1.5"
        ),
        .package(path: "../../../../Modules/SuperKit"),
        .package(path: "../MoviesDomain"),
        .package(path: "../MoviesData"),
        .package(
            url: "https://github.com/request-dl/request-dl.git",
            from: "2.2.0"
        )
    ],
    targets: [
        .target(
            name: "MoviesNetworking",
            dependencies: [
                "Factory",
                "SuperKit",
                "MoviesDomain",
                "MoviesData",
                .product(name: "RequestDL", package: "request-dl")
            ]
        )
    ]
)
