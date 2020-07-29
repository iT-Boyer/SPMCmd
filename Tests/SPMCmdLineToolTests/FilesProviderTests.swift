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
    var testBundle:Bundle!
    let sampleText = "Hello world!"
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = LocalFileProvider(for: .userDirectory, in: .allDomainsMask)
        testBundle = Bundle.init(for: FilesProviderTests.self)
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
    
    func testPersonalNewPage() {
        let desc = "Copying file in \(provider.type)"
        print("Test started: \(desc).")
        let expectation = XCTestExpectation(description: desc)
        // 1. 菜单名重命名为icon名
        //       let plistPath = testBundle.path(forResource: "personalNewPage", ofType: "plist")
        let plistPath = "/Users/jhmac/hsg/SupervisionSel/SupervisionSelTests/Jinher/personalNew/personalNewPage.plist"
        let iconDoc = "jhmac/Desktop/icon"
        let toPath = "jhmac/hsg/hppersonalpagelib/HDPersonalPageBundle"
        let dicInfo = NSDictionary(contentsOfFile: plistPath)
        let menus:Array = dicInfo?.object(forKey: "menu") as! Array<NSDictionary>
        for i in 0..<menus.count {
            let icons:Array = menus[i].object(forKey: "array") as! Array<NSDictionary>
            for j in 0..<icons.count {
                let icon:NSDictionary = icons[j]
                let iconstr = icon.object(forKey: "icon")
                let iconname = icon.object(forKey: "name")
                //               print("\(iconname!):\(iconstr!)")
                let filePath2 = "\(iconDoc)/\(iconname!)@2x.png"
                let toPath2 = "\(toPath)/\(iconstr!)@2x.png"
                let filePath3 = "\(iconDoc)/\(iconname!)@3x.png"
                let toPath3 = "\(toPath)/\(iconstr!)@3x.png"
                
                let ext2 = "/Users/\(toPath2)"
                let ext3 = "/Users/\(toPath3)"
                
                if FileManager.default.fileExists(atPath: ext2) {
//                    print("准备替换：\(filePath2)")
                    provider.removeItem(path: toPath2) { (error) in
                        self.provider.moveItem(path: filePath2, to: toPath2, completionHandler: nil)
                    }
                }else{
                    print("\(iconname!)不存在：\(toPath2)")
                }
                if FileManager.default.fileExists(atPath: ext3) {
//                    print("准备替换：\(filePath3)")
                    provider.removeItem(path: toPath3) { (error) in
                        self.provider.moveItem(path: filePath3, to: toPath3, overwrite: true) { (error) in
                            if j == menus.count - 1
                            {
                                expectation.fulfill()
                            }
                        }
                    }
                }else{
//                    print("不存在：\(toPath3)")
                }
            }
        }
        waitForExpectations(timeout: 100, handler: nil)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}
