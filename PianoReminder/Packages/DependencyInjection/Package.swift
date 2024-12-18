// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"])
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3")
    ],
    targets: [
        .target(
            name: "DependencyInjection",
            dependencies: ["Swinject"],
            path: "Sources"
        ),
    ]
)
