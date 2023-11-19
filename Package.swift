// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CodableGraphics",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .macOS(.v12),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "CodableGraphics",
            targets: ["CodableGraphics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/heestand-xyz/AsyncGraphics", from: "1.8.2")
    ],
    targets: [
        .target(
            name: "CodableGraphics",
            dependencies: ["AsyncGraphics"],
            resources: [.process("Localizable.xcstrings")]),
        .testTarget(
            name: "CodableGraphicsTests",
            dependencies: ["CodableGraphics"]),
    ]
)
