//
//  TestFilesProvider.swift
//  SPMCmdLineToolTests
//
//  Created by admin on 2018/10/16.
//

import XCTest
import FilesProvider
//@testable import SPMCmdLineTool
//@import SPMCmdLineTool

class PngquantTests: XCTestCase {

    var documentsProvider:LocalFileProvider!
    var pngexpectation: XCTestExpectation! = nil
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        documentsProvider = LocalFileProvider(for: .userDirectory, in: .allDomainsMask)
        pngexpectation = self.expectation(description: "PngquantTests")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testRenames() {
        documentsProvider.contentsOfDirectory(path: "admin/Downloads/门店详情") { (contents, error) in
            var i = 0
            for file in contents{
                let path = file.path.replacingOccurrences(of: " ", with: "")
                ///重命名
                self.documentsProvider.moveItem(path: file.path, to: path, overwrite: true,  completionHandler: { (error) in
                    if i == contents.count
                    {
                        self.pngexpectation.fulfill()
                    }
                })
                i = i + 1
            }
        }
        waitForExpectations(timeout: 60, handler: nil)
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //创建文件夹
        documentsProvider.create(folder: "testPng", at: "admin/hsg/") { (err) in
            print("新建目录成功")
            //拷贝图片到目录
            self.documentsProvider.contentsOfDirectory(path: "admin/Desktop", completionHandler: { (contents, error) in
                for file in contents
                {
                    let png = file.path.hasSuffix("png")
                    if png{
                        print("文件路径:\(file.path)")
                        let thePath:NSString = file.path as NSString
                        let toFile = "admin/hsg/testPng/\(thePath.lastPathComponent)"
                        self.documentsProvider.copyItem(path: file.path, to: toFile, overwrite: true, completionHandler: { (err) in
                            //调用shell工具压缩图片
                            self.testProcessRunShellScript(filePath: toFile)
                            print("Name: \(file.name)")
                            print("Size: \(file.size)")
                            print("路径: \(file.path)")
                        })
                     }
                 }
            })
        }
        waitForExpectations(timeout: 40, handler: nil)
    }
    //可用
    func testProcessRunShellScript(filePath:String) {
        let sub = "_temp.png"
        let pngquantFile = "/Users/"+filePath
        let tmpFilePath = filePath.replacingOccurrences(of: ".png", with: sub)
        let exePath = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/pngquant/pngquant"
        Process.launchedProcess(launchPath: exePath, arguments: ["--ext",sub,"--speed=3",pngquantFile])
        // 删除旧文件
//        documentsProvider.removeItem(path: filePath) { (error) in
//            //重命名压缩过的tmp文件
//            print("ddddddderr:\(error?.localizedDescription)")
//            self.documentsProvider.moveItem(path: tmpFilePath, to: filePath, overwrite: true,  completionHandler: { (error) in
//                self.pngexpectation.fulfill()
//            })
//        }
    }
    
    //1. 
    //测试不执行
    func testAppleScript() {
        //
        let filePath = "/Users/admin/hsg/testPng/123.png"
        let exePath = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/pngquant/pngquant"
        let myAppleScript = """
        on run
        do shell script
        \(exePath) -h
        end run
        """
        print("命令：\(myAppleScript)")
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
                print("ccccc:\(output.stringValue)")
            } else if (error != nil) {
                print("error: \(String(describing: error))")
            }
        }
    }
    
    //测试不执行
    func testProcessShell() {
        if #available(OSX 10.13, *) {
            let process = Process()
            let exePath = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/pngquant/pngquant"
            process.launchPath = exePath //URL.init(fileURLWithPath: exePath)
            process.arguments = ["/admin/hsg/testPng/123.png"]
            process.launch()
        }
    }
    //测试不执行
    func pngquant(file:FilesProvider.FileObject) {
        let process = Process()
        if #available(OSX 10.13, *) {
            // 指定可执行文件
            let exePath = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/pngquant/pngquant"
//            process.executableURL = URL.init(fileURLWithPath: exePath)
            process.launchPath = exePath
            let suffix="_temp.png"
//            let exestr = " --ext \(suffix) --force --speed=3 \(file.path)"
            let exestr = file.path
            print("命令:\(exestr)")
            process.arguments = [exestr]
            let inputpipe = Pipe()
            process.standardInput = inputpipe
            let outpipe = Pipe()
            process.standardOutput = outpipe
            let errpipe = Pipe()
            process.standardError = errpipe
            //开始运行
//            try! process.run()
            process.launch()
            let inputdata = inputpipe.fileHandleForReading.availableData
            let inputString = String(data: inputdata, encoding: String.Encoding.utf8) ?? ""
            print("input: %@", inputString)
            
            let outdata = outpipe.fileHandleForReading.availableData
            let outputString = String(data: outdata, encoding: String.Encoding.utf8) ?? ""
            print("Ouput: %@", outputString)
            
            let errdata = errpipe.fileHandleForReading.availableData
            let errString = String(data: errdata, encoding: String.Encoding.utf8) ?? ""
            print("Err: %@", errString)
            
            process.waitUntilExit()
        } else {
            // Fallback on earlier versions
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
