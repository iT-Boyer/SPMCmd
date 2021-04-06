// (https://github.com/it-boyer)                    
//https://www.carymic.com/2020/03/01/介绍swift-argumentparser库/

import ArgumentParser

struct Random: ParsableCommand {
    // 自定义设置
    static var configuration =
      CommandConfiguration(commandName: "random", // 自定义命令名，默认是类型名
                           abstract: "掷骰子",
                           discussion: "练习swift终端命令编写设计",
                           version: "1.0.0",
                           shouldDisplay: true,
                           subcommands: [Number.self,Pick.self],
                           defaultSubcommand: Number.self,
                           helpNames: NameSpecification.customLong("h"))
}

extension Random {
    //MARK: 定义自命令 struct结构体
    struct Number:ParsableCommand {
        //MARK: 配置
        static var configuration = CommandConfiguration(abstract:"在1和最大值之间随机选择一个数字",
                                                        shouldDisplay: true)
        //MARK: 参数
        @Argument(help: "输入随机数中的最大值")
        var highVaule: Int
        //MARK: flag
        
        //MARK: 校验
        func validate() throws {
            guard highVaule >= 1 else {
                throw ValidationError("最大值必须大于1")
            }
        }
        func run() throws {
            //MARK: 命令操作
            print(Int.random(in: 1...highVaule))
        }
    }
}

//
extension Random {
    //MARK: 定义自命令 struct结构体
    struct Pick:ParsableCommand {
        //MARK: 配置
        static var configuration = CommandConfiguration(abstract:"从给定的数组中，随机抽选其中一个元素",
                                                        shouldDisplay: true)
        //MARK: 参数
        @Option(default:3, help:"随机抽取的元素的个数")
        var count:Int
        @Argument(help: "输入待抽取的元素队列")
        var elements:[String]
        //MARK: flag
        
        //MARK: 校验
        func validate() throws {
            guard !elements.isEmpty else {
                throw ValidationError("元素不存在，请输入再抽取")
            }
        }
        func run() throws {
            //MARK: 命令操作
            let picks =  elements.shuffled().prefix(count)
            print(picks.joined(separator: "\n"))
        }
    }
}

Random.main()
