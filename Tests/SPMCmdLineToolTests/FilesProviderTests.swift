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

    var documentsProvider:LocalFileProvider!
    var pngexpectation: XCTestExpectation! = nil
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        documentsProvider = LocalFileProvider(for: .userDirectory, in: .allDomainsMask)
        pngexpectation = self.expectation(description: "FilesProviderTests")
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
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
