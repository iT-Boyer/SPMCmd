//
//  FilesProviderTests.swift
//  SPMCmdLineToolTests
//
//  Created by admin on 2018/10/19.
//

import XCTest
import FilesProvider
/// 修改文本内容
class FilesProviderTests: XCTestCase {

    var provider:LocalFileProvider!
    let timeout: Double = 60.0
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = LocalFileProvider(for: .userDirectory, in: .allDomainsMask)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let data = "What's up Newyork!".data(encoding: .utf8)
//        documentsProvider.writeContents(path: "old.txt", content: data, atomically: true, completionHandler: nil)
//        documentsProvider.writeContents(path: <#T##String#>, contents: <#T##Data?#>, overwrite: <#T##Bool#>, completionHandler: <#T##SimpleCompletionHandler##SimpleCompletionHandler##(Error?) -> Void#>)
//        documentsProvider.writeContents(path: <#T##String#>, contents: <#T##Data?#>, atomically: <#T##Bool#>, completionHandler: <#T##SimpleCompletionHandler##SimpleCompletionHandler##(Error?) -> Void#>)
//        documentsProvider.
        
        
        let desc = "Copying file in \(provider.type)"
        print("Test started: \(desc).")
        let expectation = XCTestExpectation(description: desc)
        let filePath = ""
        let toPath = ""
        provider.copyItem(path: filePath, to: toPath, overwrite: true) { (error) in
            XCTAssertNil(error, "\(desc) failed: \(error?.localizedDescription ?? "no error desc")")
            expectation.fulfill()
        }
        if provider is FTPFileProvider {
            // FTP will need to download and upload file again.
            wait(for: [expectation], timeout: timeout * 6)
        } else {
            wait(for: [expectation], timeout: timeout)
        }
        print("Test fulfilled: \(desc).")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
