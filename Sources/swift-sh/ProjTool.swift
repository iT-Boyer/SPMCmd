#!/usr/bin/swift sh

import Foundation
import ArgumentParser // apple/swift-argument-parser (ArgumentParser)
import XcodeProj  // @tuist ~> 7.11.1
import PathKit
/**
 ^^Import local files  https://github.com/mxcl/swift-sh/issues/17
 ^^ import Foobar // ./test2.swift
 ^^仅支持导入由 SPM 管理的项目（Package.swift）
 ^^暂时不支持swift文件导入方式，不能像ruby一样加载另一个rb文件
 */

//用法1：swift-sh ProjTool.swift [参数]
//用法2:./ProjTool.swift --version
struct ProjTool: ParsableCommand {
    // 自定义设置
    static var configuration =
      CommandConfiguration(commandName: "ProjTool", // 自定义命令名，默认是类型名
                           abstract: "操作xcodeproj文件配置",
                           discussion: "通过命令编辑xcode项目依赖，版本号管理等",
                           version: "1.0.0",
                           shouldDisplay: true,
                           subcommands: [Targets.self,Upgrade.self],
                           defaultSubcommand: Targets.self,
                           helpNames: NameSpecification.customLong("h"))
}

extension ProjTool {
    //MARK: 定义自命令 struct结构体
    struct Targets:ParsableCommand {
        //MARK: 配置
        static var configuration = CommandConfiguration(abstract:"查看项目中的所有targets",
                                                        shouldDisplay: true)
        //MARK: 参数
        @Argument(help: "终端输入proj路径")
        var projfile: String
        //MARK: flag
        
        //MARK: 校验
        func validate() throws {
            guard projfile.count >= 1 else {
                throw ValidationError("请输入正确的路径")
            }
        }
        func run() throws {
            //MARK: 命令操作
            let path = Path(projfile) // Your project path
            let xcodeproj = try! XcodeProj(path: path)
            let pbxproj = xcodeproj.pbxproj // Returns a PBXProj
            for target in pbxproj.nativeTargets {
                print(target.name)
            }
//            pbxproj.nativeTargets.each { target in
//              print(target.name)
//            }
        }
    }
}

extension ProjTool{
    //MARK: 定义自命令 struct结构体
    struct Upgrade:ParsableCommand {
            //MARK: 配置
        static var configuration = CommandConfiguration(abstract:"升级修改项目工程的版本号",
                                                       shouldDisplay: true)
        //MARK: 参数
        @Option(default:"1.0.0", help:"默认参数1.0.0")
        var defaultversion
        @Argument(help: "设置版本号")
        var newwersion:String
        //MARK: 参数
        @Argument(help: "终端输入proj路径")
        var projfile: String
        
        //MARK: flag
            
        //MARK: 校验
        func validate() throws {
            guard newwersion.count > 0 else {
                throw ValidationError("请先设置版本号")
                }
            }
        func run() throws {
            //MARK: 命令操作
            let projectPath = Path(projfile)
            let newVersion = newwersion
            let xcodeproj = try XcodeProj(path: projectPath)
            let key = "CURRENT_PROJECT_VERSION"
//            print("配置内容：\(xcodeproj.pbxproj.buildConfigurations)")
            for conf in xcodeproj.pbxproj.buildConfigurations where conf.buildSettings[key] != nil {
                conf.buildSettings[key] = newVersion
            }

            try xcodeproj.write(path: projectPath)
        }
    }
}


ProjTool.main()
