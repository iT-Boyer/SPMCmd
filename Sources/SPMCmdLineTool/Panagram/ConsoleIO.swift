//
//  ConsoleIO.swift
//  CommandLineTool
//
//  Created by admin on 2018/10/15.
//  Copyright © 2018年 clcw. All rights reserved.
//

import Foundation

//声明打印执行状态的枚举
enum OutputType {
    case Error
    case Standard
}
//Panagram有三个选项:-p用来检测回文，-a指定参数，-h打印帮助
enum OptionType:String {
    case Palindrome = "p"
    case Anagram = "a"
    case Help = "h"
    case Quit = "q"
    case Unknown
    
    init(value:String){
        switch value {
        case "a":
            self = .Anagram
        case "p":
            self = .Palindrome
        case "h":
            self = .Help
        case "q":
            self = .Quit
        default:
            self = .Unknown
        }
    }
}

//控制台输出类
class ConsoleIO{
        //在控制台打印说明文档信息
    class func printUsage(){
        //Process是一个围绕argc和argv参数的小包装，您可能从类似c的语言中知道这些参数
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        print("usage:")
        print("\(executableName) -a string1 string2")
        print("or")
        print("\(executableName) -p string")
        print("or")
        print("\(executableName) -h to show usage information")
        print("Type \(executableName) without an option to enter interactive mode.")
    }
    
    ///
    /// - Parameters:
    ///   - message: 打印的消息
    ///   - to: 指定打印位置。默认为.Standard
    func writeMessage(_ message: String, to: OutputType = .Standard){
        switch to {
        case .Standard:
            print("\u{001B}[;m\(message)]")
        case .Error:
            fputs("\u{001B}[0;31m\(message)\n]", stderr)
        }
    }
    
    func printUsage() {
        
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) -a string1 string2")
        writeMessage("or")
        writeMessage("\(executableName) -p string")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
    
    
    /// 获取输入内容
    /// - Returns: 返回输入内容
    func getInput() -> String {
        //1. 获取句柄
        let keyboard = FileHandle.standardInput
        //2. 读取键盘输入流数据
        let inputData = keyboard.availableData
        //3. 流数据转为String字符串
        let strData = NSString(data: inputData,encoding: String.Encoding.utf8.rawValue)!
        //4. return字符串，删除换行字符
        return strData.trimmingCharacters(in: NSCharacterSet.newlines)
    }
}
