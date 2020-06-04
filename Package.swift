// swift-tools-version:5.2
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
        .package(name:"FilesProvider", url: "https://github.com/amosavian/FileProvider.git",from:"0.25.1"),
        .package(name:"PerfectPython", url: "https://github.com/PerfectlySoft/Perfect-Python.git", from: "3.2.0"),
        //https://github.com/SwiftWebUI/SwiftWebUI
        .package(name:"SwiftWebUI", url: "https://github.com/SwiftWebUI/SwiftWebUI", from: "0.1.7"),
        .package(name:"Guaka", url: "https://github.com/oarrabi/Guaka.git", from: "0.0.0"),
        .package(name:"Kanna", url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "iSPMCmd",
                dependencies: ["FilesProvider", "PerfectPython","Guaka","Kanna"],
                path:"Sources/iSPMCmd",
                sources:["Sources"]
        ),
        
        .testTarget(name: "SPMCmdLineToolTests",
                    dependencies: ["iSPMCmd"],
                    path:"Tests/SPMCmdLineToolTests"),
        
        .target(name: "Panagrams",
                path: "Sources/Panagrams",
                exclude:["docs"],
                sources:["Sources"]),
        
        .target(name: "DesignPatterns",
                dependencies: [],
                        path: "Sources/DesignPatterns",
                     exclude: ["docs","other"],
                     sources: ["Sources"])
        
//        .target(name: "SwiftUIServer",
//            dependencies: [],
//                    path: "Sources/SwiftWebUI",
//                 exclude: ["docs","other"],
//                 sources: ["Sources"])
        ]
)
