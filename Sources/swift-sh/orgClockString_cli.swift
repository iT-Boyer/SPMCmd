#!/usr/bin/swift sh
// 默认：swift-sh命令工具
// (https://github.com/it-boyer)
import Foundation
import ArgumentParser // ~/hsg/swift-argument-parser
// import ArgumentParser // https://gitee.com/iTBoyer/swift-argument-parser
import Regex  // ~/hsg/Regex

 // 使用方法:./orgClockString_cli.swift -r "正则表达式" "原数据"
 // 例子：./orgClockString_cli.swift -r "\\[\\d.*\\)" "#(\" [22:54] (org-agenda 科学使用 [0%])\" 0 31"
import ArgumentParser

struct orgClockString_cli: ParsableCommand {
    // 自定义设置
    static var configuration =
      CommandConfiguration(commandName: "orgClockString", // 自定义命令名，默认是类型名
                           abstract: "练习，使用正则截取org-clock-in状态栏中的信息",
                           discussion: "主要使用正则来截取字符串",
                           version: "1.0.0",
                           shouldDisplay: true,
                           subcommands: [OrgRegex.self],
                           defaultSubcommand: OrgRegex.self,
                           helpNames: NameSpecification.customLong("h"))
}

struct RegexOpts: ParsableArguments {
    //MARK: 参数
    @Option(name: [.customShort("r"), .long], help:"正则表达式，匹配得到自己的数据")
    var regex:String
    @Argument(help: "原数据字符串")
    var data: String

}

extension orgClockString_cli {

    //MARK: 定义自命令 struct结构体
    struct OrgRegex:ParsableCommand {
        //MARK: 配置
        static var configuration = CommandConfiguration(abstract:"orgRegex",
                                                        shouldDisplay: true)
        //加载封装好的指令
        @OptionGroup()
        var customOpts:RegexOpts


        func run() throws {
            //MARK: 命令操作
            //从字符串中匹配内容
            // let rex:StaticString = "\(customOpts.regex)"
            // 不能直接使用Regex("")方法
            // let greeting = try! Regex(string:"\\[\\d.*\\)")

            let greeting = try! Regex(string:customOpts.regex)
            let result = greeting.firstMatch(in: customOpts.data)?.matchedString
            print("\(customOpts.regex)\n--匹配结果：\n\(result!)")
        }
    }
}

orgClockString_cli.main()
