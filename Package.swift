// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "CodX",
    platforms: [.macOS(.v26)],
    products: [
        .executable(name: "codx", targets: ["AgenticCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.7.1"),
        .package(url: "https://github.com/apple/swift-log", from: "1.12.0"),
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk", from: "0.12.0"),
        .package(url: "https://github.com/stephencelis/SQLite.swift", from: "0.15.4"),
    ],
    targets: [
        .executableTarget(
            name: "AgenticCLI",
            dependencies: [
                "Core",
                "TUI",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "Core",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "SQLite", package: "SQLite.swift"),
                .product(name: "MCP", package: "swift-sdk"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .target(name: "TUI", dependencies: ["Core"]),
        .testTarget(name: "CoreTests", dependencies: ["Core"]),
    ]
)
