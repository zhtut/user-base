// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let latestVersion: Range<Version> = "0.0.1"..<"99.99.99"

let package = Package(
    name: "user-base",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserBase",
            targets: ["UserBase"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", latestVersion),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", latestVersion),
        // 🐘 Fluent driver for Postgres.
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", latestVersion),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", latestVersion),
        // 自己的库
        .package(url: "https://github.com/zhtut/vapor-utils.git", latestVersion),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UserBase", dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "VaporUtils", package: "vapor-utils"),
            ]),
        .testTarget(
            name: "UserBaseTests",
            dependencies: ["UserBase"]
        ),
    ]
)
