// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreStorage",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "CoreStorage",
            targets: ["CoreStorage"]
        )
    ],
    dependencies: [
        .package(path: "../Injection"),
        .package(path: "../CoreApp"),
        .package(path: "../CoreKit"),
        .package(path: "../DataKit")
    ],
    targets: [
        .target(
            name: "CoreStorage",
            dependencies: [
                "Injection",
                "CoreApp",
                "CoreKit",
                "DataKit"
            ]
        )
    ]
)
