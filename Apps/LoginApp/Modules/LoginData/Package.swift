// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataKit",
    platforms: [.iOS(.v16), .watchOS(.v9), .tvOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "LoginData",
            targets: ["LoginData"]
        )
    ],
    dependencies: [
        .package(path: "../../../../Modules/Injection"),
        .package(path: "../../../../Modules/SuperKit"),
        .package(path: "../LoginDomain")
    ],
    targets: [
        .target(
            name: "LoginData",
            dependencies: [
                "Injection",
                "SuperKit",
                "LoginDomain"
            ]
        )
    ]
)
