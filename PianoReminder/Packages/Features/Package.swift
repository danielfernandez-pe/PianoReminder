// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
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
        .package(path: "../Storage"),
        .package(url: "git@github.com:danielfcodes/UI.git", from: "1.0.0"),
        .package(url: "git@github.com:danielfcodes/Logger.git", from: "1.0.0"),
        .package(url: "git@github.com:danielfcodes/Networking.git", from: "1.2.1"),
        .package(url: "https://github.com/NoahKamara/CompoundPredicate.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "Game",
            dependencies: [
                .product(name: "PianoUI", package: "PianoUI"),
                .product(name: "Core", package: "Core"),
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .product(name: "Storage", package: "Storage"),
                .product(name: "UI", package: "UI"),
                .product(name: "Lumberjack", package: "Logger"),
                .product(name: "Networking", package: "Networking"),
                .target(name: "GameAPI"),
                .product(name: "CompoundPredicate", package: "CompoundPredicate"),
            ],
            path: "Sources/Game",
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
