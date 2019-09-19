// swift-tools-version:4.2
// Generated automatically by Perfect Assistant
// Date: 2019-09-19 01:25:04 +0000
import PackageDescription

let package = Package(
	name: "MyAwesonPerfectProject",
	dependencies: [
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTP.git", from: "3.0.0")
	],
	targets: [
		.target(name: "MyAwesonPerfectProject", dependencies: ["PerfectHTTPServer","PerfectHTTP"]),
		.testTarget(name: "MyAwesonPerfectProjectTests", dependencies: ["MyAwesonPerfectProject"])
	]
)
