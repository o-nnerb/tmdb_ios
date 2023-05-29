// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesData",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "MoviesData",
            targets: ["MoviesData"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/hmlongco/Factory.git",
            from: "2.1.5"
        ),
        .package(path: "../../../../Modules/SuperKit"),
        .package(path: "../MoviesDomain")
    ],
    targets: [
        .target(
            name: "MoviesData",
            dependencies: [
                "Factory",
                "SuperKit",
                "MoviesDomain"
            ]
        )
    ]
)
