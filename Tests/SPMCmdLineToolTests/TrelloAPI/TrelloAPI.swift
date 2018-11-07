//
//  TrelloAPI.swift
//  SPMCmdLineToolTests
//
//  Created by admin on 2018/11/5.
//

import XCTest

import PythonAPI
import PerfectPython
/**
 安装：pip install py-trello
 使用：
 ```
 from trello import TrelloClient
 
 client = TrelloClient(
     api_key='your-key',
     api_secret='your-secret',
     token='your-oauth-token-key',
     token_secret='your-oauth-token-secret'
 )
 ```
 */
class TrelloAPI: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //初始化python嵌入环境
        Py_Initialize()
        
        let path = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/trello/py-trello/trello/"
        let pymod = try PyObj(path: path, import: "trelloclient")
        NSArray *args = ["735d020b354aa278f97c0bc0088323c3","9c44061777cc331cc5b36633774cc6e930bcacdd2b31bb797317b3c9be0c2431"];
        if let clientClass = pymod.load("TrelloClient"),
            let client = clientClass.construct(args) {
            // client is now the object instance list_boards函数返回board对象，无法支持
            if let all_boards:Array = client.call("list_boards", args: nil)?.value as? Array {
                last_board = all_boards.last
                print(name, age, intro)
            }
            //        all_boards = client.list_boards()
            //        last_board = all_boards[-1]
            //        print(last_board.name)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
