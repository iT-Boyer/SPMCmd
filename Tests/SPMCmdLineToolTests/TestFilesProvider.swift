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

class TestFilesProvider: XCTestCase {

    var documentsProvider:LocalFileProvider!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        documentsProvider = LocalFileProvider(for: .userDirectory, in: .allDomainsMask)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
                        let thePath:NSString = file.path as NSString
                        let toFile = "admin/hsg/testPng/\(thePath.lastPathComponent)"
                        self.documentsProvider.copyItem(path: file.path, to: toFile, overwrite: true, completionHandler: { (err) in
                            //
                        })
                    }
                }
            })
            
            //调用shell工具压缩图片
            self.documentsProvider.contentsOfDirectory(path: "admin/hsg/testPng", completionHandler: { contents, error in
                    for file in contents {
                        print("Name: \(file.name)")
                        print("Size: \(file.size)")
                        print("路径: \(file.path)")
                        if file.path.hasSuffix("png"){
                                self.pngquant(file: file)
                        }
                    }
            })
        }
    }
    
    func AppleScript() {
        //
//        let bundle = Bundle.main
//        if let scriptPath = bundle.path(forResource: "main", ofType: "scpt"){
//            let paths = [scriptPath]
//            let myAppleScript = """
//                                on run
//                                do shell script
//                                \"open -na /Applications/mpv.app \(videoPath!)\"
//                                tell application \"mpv\" to activate
//                                end run
//                                """
//            Process.launchedProcess(launchPath: "/usr/bin/osascript", arguments: paths)
//        }
    }
    
    func pngquant(file:FilesProvider.FileObject) {
        let process = Process()
        
        if #available(OSX 10.13, *) {
            // 指定可执行文件
            let exePath = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/pngquant/pngquant"
            //https://pngquant.org/
//            process.executableURL = URL.init(fileURLWithPath: exePath)
            process.launchPath = exePath
            let suffix="_temp.png"
            let exestr = " --ext \(suffix) --force --speed=3 \(file.path)"
            print("命令:\(exestr)")
            process.arguments = [exestr]
            let outpipe = Pipe()
            process.standardOutput = outpipe
            let errpipe = Pipe()
            process.standardError = errpipe
            //开始运行
//            try! process.run()
            process.launch()
            // 删除旧文件
//            documentsProvider.removeItem(path: file.path, completionHandler: nil)
//            //重命名压缩过的tmp文件
//            documentsProvider.moveItem(path: file.path, to: "new.txt", overwrite: false, completionHandler: nil)
            let outdata = outpipe.fileHandleForReading.availableData
            let outputString = String(data: outdata, encoding: String.Encoding.utf8) ?? ""
            print("Ouput: %@", outputString)
            
            let errdata = errpipe.fileHandleForReading.availableData
            let errString = String(data: errdata, encoding: String.Encoding.utf8) ?? ""
            print("Err: %@", errString)
            
//            process.waitUntilExit()
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
