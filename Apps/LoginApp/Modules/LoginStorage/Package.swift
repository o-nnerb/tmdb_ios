// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginStorage",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "LoginStorage",
            targets: ["LoginStorage"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/hmlongco/Factory.git",
            from: "2.1.5"
        ),
        .package(path: "../../../../Modules/SuperKit"),
        .package(path: "../LoginDomain"),
        .package(path: "../LoginData")
    ],
    targets: [
        .target(
            name: "LoginStorage",
            dependencies: [
                "Factory",
                "SuperKit",
                "LoginDomain",
                "LoginData"
            ]
        )
    ]
)
