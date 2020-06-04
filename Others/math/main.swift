//===----------------------------------------------------------*- swift -*-===//
//
// This source file is part of the Swift Argument Parser open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import ArgumentParser

/// 基础属性配置
struct Math: ParsableCommand {
    // Customize your command's help and subcommands by implementing the
    // `configuration` property.
    static var configuration = CommandConfiguration(
        // Optional abstracts and discussions are used for help output.
        abstract: "一个好用的终端计算器.",

        // Commands can define a version for automatic '--version' support.
        version: "1.0.0",

        // 设置支持的子命令集合（加，乘，统计）
        // Pass an array to `subcommands` to set up a nested tree of subcommands.
        // With language support for type-level introspection, this could be
        // provided by automatically finding nested `ParsableCommand` types.
        subcommands: [Add.self, Multiply.self, Statistics.self],
        
        // 设置默认命令
        // A default subcommand, when provided, is automatically selected if a
        // subcommand is not given on the command line.
        defaultSubcommand: Add.self)

}

/** **参数和flag声明**
 注解语法 @
 1. @Argument 表明该属性是作为命令行参数
 2. @flag     命令所接收的`-v/–v`
 3. @OptionGroup 包括flag、选项和参数
 */
struct Options: ParsableArguments {
    @Flag(name: [.customLong("hex-output"), .customShort("x")],
          help: "Use hexadecimal notation for the result.")
    var hexadecimalOutput: Bool

    @Argument(
        help: "A group of integers to operate on.")
    var values: [Int]
}

extension Math {
    static func format(_ result: Int, usingHex: Bool) -> String {
        usingHex ? String(result, radix: 16)
            : String(result)
    }

    // 加法
    struct Add: ParsableCommand {
        static var configuration =
            CommandConfiguration(abstract: "打印参数（inter类型）之和.")

        // The `@OptionGroup` attribute includes the flags, options, and
        // arguments defined by another `ParsableArguments` type.
        @OptionGroup()
        var options: Options
        
        mutating func run() {
            // 解析参数，并执行算法，计算出结果
            let result = options.values.reduce(0, +)
            print(format(result, usingHex: options.hexadecimalOutput))
        }
    }

    // 乘法
    struct Multiply: ParsableCommand {
        static var configuration =
            CommandConfiguration(abstract: "打印值的乘积.")

        @OptionGroup()
        var options: Options
        
        mutating func run() {
            let result = options.values.reduce(1, *)
            print(format(result, usingHex: options.hexadecimalOutput))
        }
    }
}

// 实际上，这些嵌套类型可以分解为不同的文件
extension Math {
    struct Statistics: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "stats", // 自定义命令名，默认是类型名
            abstract: "Calculate descriptive statistics.", //简介说明
            subcommands: [Average.self, StandardDeviation.self, Quantiles.self])
    }
}

extension Math.Statistics {
    // 求平均值
    struct Average: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Print the average of the values.",
            version: "1.5.0-alpha")
        
        enum Kind: String, ExpressibleByArgument {
            case mean, median, mode
        }

        @Option(default: .mean, help: "求某一种类型的平均值.")
        var kind: Kind
        
        @Argument(help: "A group of floating-point values to operate on.")
        var values: [Double]

        // 验证
        func validate() throws {
            if (kind == .median || kind == .mode) && values.isEmpty {
                throw ValidationError("请先选一种平均值的类型 \(kind).")
            }
        }

        func calculateMean() -> Double {
            guard !values.isEmpty else {
                return 0
            }

            let sum = values.reduce(0, +)
            return sum / Double(values.count)
        }
        
        func calculateMedian() -> Double {
            guard !values.isEmpty else {
                return 0
            }
            
            let sorted = values.sorted()
            let mid = sorted.count / 2
            if sorted.count.isMultiple(of: 2) {
                return sorted[mid - 1] + sorted[mid] / 2
            } else {
                return sorted[mid]
            }
        }
        
        func calculateMode() -> [Double] {
            guard !values.isEmpty else {
                return []
            }
            
            let grouped = Dictionary(grouping: values, by: { $0 })
            let highestFrequency = grouped.lazy.map { $0.value.count }.max()!
            return grouped.filter { _, v in v.count == highestFrequency }
                .map { k, _ in k }
        }
    
        mutating func run() {
            switch kind {
            case .mean:
                print(calculateMean())
            case .median:
                print(calculateMedian())
            case .mode:
                let result = calculateMode()
                    .map(String.init(describing:))
                    .joined(separator: " ")
                print(result)
            }
        }
    }

    struct StandardDeviation: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "stdev",
            abstract: "打印值的标准偏差。")

        @Argument(help: "A group of floating-point values to operate on.")
        var values: [Double]
        
        mutating func run() {
            if values.isEmpty {
                print(0.0)
            } else {
                let sum = values.reduce(0, +)
                let mean = sum / Double(values.count)
                let squaredErrors = values
                    .map { $0 - mean }
                    .map { $0 * $0 }
                let variance = squaredErrors.reduce(0, +)
                let result = variance.squareRoot()
                print(result)
            }
        }
    }
    
    struct Quantiles: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "打印数值的分位数（待定）。")

        @Argument(help: "A group of floating-point values to operate on.")
        var values: [Double]

        // These args and the validation method are for testing exit codes:
        @Flag(help: .hidden)
        var testSuccessExitCode: Bool
        @Flag(help: .hidden)
        var testFailureExitCode: Bool
        @Flag(help: .hidden)
        var testValidationExitCode: Bool
        @Option(help: .hidden)
        var testCustomExitCode: Int32?
      
        func validate() throws {
            if testSuccessExitCode {
                throw ExitCode.success
            }
            
            if testFailureExitCode {
                throw ExitCode.failure
            }
            
            if testValidationExitCode {
                throw ExitCode.validationFailure
            }
            
            if let exitCode = testCustomExitCode {
                throw ExitCode(exitCode)
            }
        }
    }
}

Math.main()
