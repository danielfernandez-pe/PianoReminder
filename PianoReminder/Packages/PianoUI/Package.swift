// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageName = "PianoUI"
let package = Package(
    name: "PianoUI",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: packageName,
            targets: [packageName]
        )
    ],
    dependencies: [
        .package(url: "git@github.com:danielfcodes/UI.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: packageName,
            dependencies: [
                .product(name: "UI", package: "UI")
            ],
            path: "Sources"
        )
    ]
)
