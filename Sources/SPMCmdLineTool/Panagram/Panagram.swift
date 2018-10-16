//
//  Panagram.swift
//  CommandLineTool
//
//  Created by admin on 2018/10/15.
//  Copyright © 2018年 clcw. All rights reserved.
//

import Foundation

class Panagram {
    //
    let consoleIO = ConsoleIO()
    func staticMode() {
        //1. 获取传递给程序的参数数量
        let argCount = CommandLine.argc
        //2.  take the first “real” argument from the arguments array.
        let argument = CommandLine.arguments[1]
        //3. parse the argument and convert it to an OptionType.
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        //4. log the parsing results to the console.
        //        print("Argument count:\(argCount) Option:\(option) value:\(value)")
        
        //1. First, switch to see what should be detected.
        switch option {
        case .Anagram:
            //2 there must be four command-line arguments passed in.
            if argCount != 4 {
                if argCount > 4 {
                    //
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .Error)
                }else{
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .Error)
                }
                
                ConsoleIO.printUsage()
                
            }else{
                //3. If the argument count is good, store the two strings in local variables, check the strings and print the result.
                let first = CommandLine.arguments[2]
                let second = CommandLine.arguments[3]
                if first.isAnagramOfString(s: second) {
                    consoleIO.writeMessage("\(second) is an anagram of \(first)", to: .Error)
                }else{
                    consoleIO.writeMessage("\(second) is not an anagram of \(first)", to: .Error)
                }
            }
        case .Palindrome:
            //4. In the case of a palindrome, you must have three arguments.
            if argCount != 3 {
                if argCount > 3 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .Error)
                }else{
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .Error)
                }
            }else{
                //5. Check for the palindrome and print the result.
                let s = CommandLine.arguments[2]
                let isPalindrome = s.isPalindrome()
                consoleIO.writeMessage("\(s) is \(isPalindrome ? "" : "not ")a palindrome", to: .Error)
            }
        case .Help:
            //6. If the -h option was passed in, then print the usage information.
            ConsoleIO.printUsage()
        case .Unknown, .Quit:
            //7. If an unknown option is passed, print the usage to the console.
            consoleIO.writeMessage("Unknown option \(value)", to: .Error)
            ConsoleIO.printUsage()
        }
    }
    //接收String参数，返回OptionType选项类型元组和字符串
    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    func interactiveMode() {
        //1. print a welcome message.
        consoleIO.writeMessage("Welcome to Panagram. This program checks if an  input string is an anagram or palindrome.")
        //2. shouldQuit breaks the infinite loop that is started in the next line.
        var shouldQuit = false
        while !shouldQuit {
            //3. Prompt the user for input and convert it to one of the two options if possible.
            consoleIO.writeMessage("Type 'a' to check for anagrams or 'p' for palindromes type 'p' to quit.")
            let (option,value) = getOption(consoleIO.getInput())
            switch option {
            case .Anagram:
                //4. Prompt the user for the two strings to compare.
                consoleIO.writeMessage("Type the first string:")
                let first = consoleIO.getInput()
                consoleIO.writeMessage("Type the second string:")
                let second = consoleIO.getInput()
                //5. Write the result out. The same logic flow applies to the palindrome option.
                if first.isAnagramOfString(s: second) {
                    consoleIO.writeMessage("\(second) is an anagram of \(first)")
                }else{
                    consoleIO.writeMessage("\(second) is not an anagram of \(first))")
                }
            case .Palindrome:
                consoleIO.writeMessage("Type a word or sentence:")
                let s = consoleIO.getInput()
                let isPalindrome = s.isPalindrome()
                consoleIO.writeMessage("\(s) is \(isPalindrome ? "" : "not ")a palindrome")
            case .Quit:
                shouldQuit = true
            default:
                //6. If the user enters an unknown option, print an error and start the loop again.
                consoleIO.writeMessage("Unknown option \(value)",to: .Error)
            }
        }
    }
}
