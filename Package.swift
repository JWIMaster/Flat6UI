// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Flat6UI",
    platforms: [
        .iOS("7.0"),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Flat6UI",
            targets: ["Flat6UI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JWIMaster/UIKitExtensions", branch: "master"),
        .package(url: "https://github.com/JWIMaster/UIKitCompatKit", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Flat6UI",
            dependencies: ["UIKitCompatKit", "UIKitExtensions"],
            path: "Sources/Flat6UI"),
        .testTarget(
            name: "Flat6UITests",
            dependencies: ["Flat6UI"]),
    ]
)








