// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iSPMCmd",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
//        .library(name: "iSPMCmd", targets: ["iSPMCmd"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name:"FilesProvider", url: "https://github.com/amosavian/FileProvider.git",from:"0.26.0"),
        .package(name:"PerfectPython", url: "https://github.com/PerfectlySoft/Perfect-Python.git", from: "3.2.0"),
        //https://github.com/SwiftWebUI/SwiftWebUI
        .package(name:"SwiftWebUI", url: "https://github.com/SwiftWebUI/SwiftWebUI", from: "0.1.7"),
        // CLI快速创建和管理命令工具
        .package(name:"Guaka", url: "https://github.com/oarrabi/Guaka.git", from: "0.0.0"),
        // XML/HTML 解析工具
        .package(name:"Kanna", url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.2"),
        // 解析命令行参数
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.1.0"),
        .package(name: "HTMLEntities", url: "https://github.com/IBM-Swift/swift-html-entities.git", from: "3.0.14"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "3.0.1"),
        .package(url: "https://github.com/nsomar/FileUtils", from: "0.2.0"),
        .package(url: "https://github.com/sharplet/Regex.git", from: "2.1.1"),
        //quick行为测试
        .package(url: "https://github.com/Quick/Quick.git", from: "3.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "iSPMCmd",
                dependencies: ["FilesProvider", "PerfectPython","Guaka","Kanna",
                                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                ],
                path:"Sources"
        ),
        
        .testTarget(name: "SPMCmdLineToolTests",
                    dependencies: ["iSPMCmd"],
                    path:"Tests/SPMCmdLineToolTests"
        ),
        
        .target(name: "Panagrams",
                path: "Others/Panagrams",
                exclude:["docs"],
                sources:["Sources"]
        ),
        
        .target(name: "Designer",
                dependencies: [],
                        path: "Others/Design",
                     exclude: ["docs","other"],
                     sources: ["Sources"]
        ),
        
        .target(name:"math",
                dependencies:[
                    .product(name: "ArgumentParser", package: "swift-argument-parser"),
                ],
                path: "Others/math"
        ),
        .target(name:"Random",
                dependencies:[
                    .product(name: "ArgumentParser", package: "swift-argument-parser"),
                ],
                path: "Others/Random"
        ),
        .target(name: "Jonyfive",
                dependencies: [
                    "HTMLEntities",
                    "Yams",
                    "FileUtils",
                    "Guaka",
                    "Regex",
                    "Kanna",
                ],
                path: "Others/Jonyfive",
                sources: ["Sources"]
        )
        
//        .target(name: "SwiftUIServer",
//            dependencies: [],
//                    path: "Others/SwiftWebUI",
//                 exclude: ["docs","other"],
//                 sources: ["Sources"])
        ]
)
