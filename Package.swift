// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SPMCmdLineTool",
    dependencies: [
        .package(url: "https://github.com/amosavian/FileProvider.git",from:"0.25.1"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Python.git", from: "3.2.0")
    ],
    targets: [
        .target(name: "SPMCmdLineTool",
        dependencies: ["FilesProvider", "PerfectPython"],
             sources:["Sources/SPMCmdLineTool/Panagram"]),
        .testTarget(
            name: "SPMCmdLineToolTests",
            dependencies: ["SPMCmdLineTool"]),
        ],
    targets: [
        .target(name: "JazzyConsoleIO",
             sources:["Sources/SPMCmdLineTool/Jazzy"]),
        ]
)
