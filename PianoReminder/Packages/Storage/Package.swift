// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Storage",
            targets: ["Storage"]
        ),
    ],
    dependencies: [
        .package(path: "../DependencyInjection"),
        .package(url: "git@github.com:danielfcodes/Logger.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: [
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .product(name: "Lumberjack", package: "Logger"),
            ],
            path: "Sources"
        )
    ]
)
