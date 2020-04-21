// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreSwiftUI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CoreSwiftUI",
            targets: ["CoreSwiftUI"]),
    ],
    targets: [
        .target(
            name: "CoreSwiftUI",
            dependencies: []),
        .testTarget(
            name: "CoreSwiftUITests",
            dependencies: ["CoreSwiftUI"]),
    ]
)
