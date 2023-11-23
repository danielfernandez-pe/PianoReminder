// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [.iOS(.v17)],
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
        .package(path: "../PianoUI"),
        .package(path: "../Core"),
        .package(path: "../DependencyInjection"),
        .package(url: "git@github.com:danielfcodes/UI.git", from: "1.0.0")
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
            path: "Sources",
            resources: [
                .process("Resources/Sounds/success.wav"),
                .process("Resources/Sounds/error.wav"),
            ]
        ),
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
