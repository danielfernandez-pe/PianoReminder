// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Game",
            targets: ["Game"]),
        .library(
            name: "GameAPI",
            targets: ["GameAPI"]
        )
    ],
    dependencies: [
        .package(path: "../UI"),
        .package(path: "../PianoUI"),
        .package(path: "../Core"),
        .package(path: "../DependencyInjection")
    ],
    targets: [
        .target(
            name: "Game",
            dependencies: [
                .product(name: "UI", package: "UI"),
                .product(name: "PianoUI", package: "PianoUI"),
                .product(name: "Core", package: "Core"),
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .target(name: "GameAPI")
            ],
            path: "Sources"),
        .target(
            name: "GameAPI",
            dependencies: [
            ],
            path: "SourcesAPI"),
        .testTarget(
            name: "GameTests",
            dependencies: ["Game"])
    ]
)
