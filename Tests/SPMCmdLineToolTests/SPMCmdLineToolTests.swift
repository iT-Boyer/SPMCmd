import XCTest
import class Foundation.Bundle

final class SPMCmdLineToolTests: XCTestCase {
    var process:Process!
    override func setUp() {
        guard #available(macOS 10.13, *) else {
            return
        }
        // 运行可执行文件
        let fooBinary = productsDirectory.appendingPathComponent("SPMCmdLineTool")
        process = Process()
        // 指定可执行文件
        process.executableURL = fooBinary
    }
    func testJazzyTool() {
        guard #available(macOS 10.13, *) else {
            return
        }
        let pipe = Pipe()
        process.standardOutput = pipe
        process.arguments = ["33"]
        //开始运行
        try! process.run()
        process.waitUntilExit()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }
        let pipe = Pipe()
        process.standardOutput = pipe
        //开始运行
        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, "Hello, world!\n")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            print("路径:\(bundle.bundleURL)")
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
