// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iSPMCmd",
//    products: [
//        // Products define the executables and libraries produced by a package, and make them visible to other packages.
//        .library(
//            name: "SPMCmdLineTool",
//            targets: ["SPMCmdLineTool"]
//        )
//    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/amosavian/FileProvider.git",from:"0.25.1"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Python.git", from: "3.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "iSPMCmd",
                dependencies: ["FilesProvider", "PerfectPython"],
                path:"Sources/iSPMCmd"),
        
        .testTarget(name: "SPMCmdLineToolTests",
                    dependencies: ["iSPMCmd"],
                    path:"Tests/SPMCmdLineToolTests"),
        
        .target(name: "Panagrams",
                path: "Sources/Panagrams"
                exclude:["docs"],
                sources:["Sources"]),
        
        .target(name: "hsg.util.firstPattern",
                dependencies: [],
                path: "DesignPatterns/hsg.util.firstPattern"),
        
        .testTarget(name: "DesignPatternsTest",
                dependencies: ["hsg.util.firstPattern"],
                path:"DesignPatterns/hsg.util.firstPatternTests"),
        ]
)
