// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Toutiao_server",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Toutiao_server",
            targets: ["Toutiao_server"]),
    ],
    dependencies: [
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTP.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftORM/MySQL-StORM", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Toutiao_server", dependencies: ["PerfectHTTPServer","PerfectHTTP", "PerfectMySQL", "MySQLStORM"]),
        .testTarget(name: "Toutiao_serverTests", dependencies: ["Toutiao_server"])
    ]
)
