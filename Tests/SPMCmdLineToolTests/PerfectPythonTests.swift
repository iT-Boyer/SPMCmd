//
//  PerfectPythonTests.swift
//  SPMCmdLineToolTests
//
//  Created by admin on 2018/10/17.
//

import XCTest
import PythonAPI
import PerfectPython

class PerfectPythonTests: XCTestCase {

    override func setUp() {
        //初始化python嵌入环境
        Py_Initialize()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        //导入Python函数库模块/compresspng.py
        let path = "/Users/admin/hsg/hexo/GitSubmodules/hsgTool/pngquant"
        let pymod = try! PyObj(path: path, import: "compresspng")
        //获取变量值
        if let str = pymod.load("stringVar")?.value as? String {
            print("加载变量:\(str)")
        }
        //更新变量值
        try! pymod.save("stringVar", newValue: "Hola, 🇨🇳🇨🇦！")
        if let str = pymod.load("stringVar")?.value as? String {
            print("保存当前变量:\(str)")
        }
        //执行Python函数
        if let res = try! pymod.call("mymul", args: [2,3])?.value as? Int
        {
                print(res)
            // 结果为 6
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
