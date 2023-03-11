// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetwork",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "CoreNetwork",
            targets: ["CoreNetwork"]
        )
    ],
    dependencies: [
        .package(path: "../Injection"),
        .package(path: "../CoreApp"),
        .package(path: "../CoreKit"),
        .package(path: "../DataKit"),
        .package(
            url: "https://github.com/brennobemoura/request-dl.git",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "CoreNetwork",
            dependencies: [
                "Injection",
                "CoreApp",
                "CoreKit",
                "DataKit",
                .product(name: "RequestDL", package: "request-dl")
            ]
        )
    ]
)
