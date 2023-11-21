// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

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
        .package(url: "https://github.com/heestand-xyz/AsyncGraphics", from: "1.8.2"),
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0"),
    ],
    targets: [
        .target(
            name: "CodableGraphics",
            dependencies: [
                "AsyncGraphics",
                "CodableGraphicsMacros",
            ],
            resources: [
                .process("Localizable.xcstrings"),
            ]),
        .macro(
            name: "CodableGraphicsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]),
        .testTarget(
            name: "CodableGraphicsTests",
            dependencies: [
                "CodableGraphics",
            ]),
    ]
)
