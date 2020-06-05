// (https://github.com/it-boyer)                    
//

import ArgumentParser

struct Random: ParsableCommand {
    // 自定义设置
    static var configuration =
      CommandConfiguration(commandName: "掷骰子", // 自定义命令名，默认是类型名
                           abstract: "掷骰子",
                           discussion: "练习swift终端命令编写设计",
                           version: "1.0.0",
                           shouldDisplay: true,
                           subcommands: [Number.self],
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
        @Argument(help: "最大值")
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

Random.main()
