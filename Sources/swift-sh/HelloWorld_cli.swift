#!/usr/bin/swift sh
// (https://github.com/it-boyer)
import Foundation
import ArgumentParser // https://gitee.com/iTBoyer/swift-argument-parser
// import Regex // @sharplet ~> 2.1
import Regex  // ~/hsg/Regex
//
import ArgumentParser

struct HelloWorld_cli: ParsableCommand {
    // 自定义设置
    static var configuration =
      CommandConfiguration(commandName: "HelloWorld", // 自定义命令名，默认是类型名
                           abstract: "使用终端练习swift，代替python，shell，来编写效率工具",
                           discussion: "全身心的学习swift",
                           version: "1.0.0",
                           shouldDisplay: true,
                           subcommands: [Study.self],
                           defaultSubcommand: Study.self,
                           helpNames: NameSpecification.customLong("h"))
}

struct MyOptions: ParsableArguments {

    //MARK: 参数
    @Option(name: [.customShort("t"), .long], help:"努力学习swift开发")
    var time:String
    @Argument(help: "正在学习的内容")
    var learn: String
    //MARK: flag
    @Flag(name: [.customLong("study"), .customShort("s")],
          help: "学习")
    var study
}

extension HelloWorld_cli {

    //MARK: 定义自命令 struct结构体
    struct Study:ParsableCommand {
        //MARK: 配置
        static var configuration = CommandConfiguration(abstract:"学习机制",
                                                        shouldDisplay: true)
        //加载封装好的指令
        @OptionGroup()
        var customOpts:MyOptions

        func run() throws {
            //MARK: 命令操作
            print("在\(customOpts.time)，我正在学习\(customOpts.learn)")
            //使用正则算法
            let time = "#(\" [22:54] (org-agenda 科学使用 [0%])\" 0 31"
            let greeting = Regex("\\[\\d.*\\)")
            let result = greeting.firstMatch(in: time)?.matchedString
            print("匹配结果：\(result!)")
        }
    }
}

HelloWorld_cli.main()
