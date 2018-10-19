//
//  JazzyConsoleIO.swift
//  SPMCmdLineTool(github地址)
//
//  Created by admin on 2018/10/19.
//
//

import Foundation

/*:
 功能描述: 控制台输出类
 
 - 主要接口:
    - `printUsage`:在控制台打印说明文档信息
     ```swift
        class func printUsage(){
            let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        }
     ```
    - getInput() 获取输入内容
    - writeMessage(message:to:):打印的消息
 - 主要构造器:
     ```
         构造器
     ```
 - 模块
 */

/// 生成的命令参数：暂时用不到，只需要回车，通过提示，输入参数值就行
//enum GenerParam:String {
//    typealias RawValue = <#type#>
//    
//    
//}
class JazzyConsoleIO:ConsoleIO{
    
    //MARK:- override
    
    /// 工具使用说明
    override func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        writeMessage("""
            用法:
                \(executableName) -path 指定工程路径
                \(executableName) -language 指定语言
                \(executableName) -prjname 指定工程名称
                \(executableName) -systom 指定平台
                \(executableName) -docv 指定版本号
            """)
    }
    override func getInput() -> String {
        let inputStr = super.getInput()
        print("输入的命令：\(inputStr)")
        return inputStr
    }
    //MARK:- api
    
    //MARK:- private
    
    //MARK:-  getter / setter
    
    //TODO: - 将要实现
    //FIXME: - 待修复
    
}


