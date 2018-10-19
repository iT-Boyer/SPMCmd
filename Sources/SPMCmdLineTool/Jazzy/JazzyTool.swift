//
//  JazzyTool.swift
//  SPMCmdLineTool(github地址)
//
//  Created by admin on 2018/10/19.
//
//

import Foundation

/*:
 功能描述: 通过命令输入，来引导用户生成自己的文档，
 需求：仿照jazzy-create.sh shell工具完成功能
 
 - 主要接口:
     ```
         接口
     ```
 - 主要构造器:
     ```
         构造器
     ```
 - 模块
 */
class JazzyTool
{
    
    //MARK:- override
    
    //MARK:- api
    func generatesAllDoc() {
        let arcCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        print("输入的内容：\(argument)")
    }
    //MARK:- model event
    
    
    //MARK:- view event
    
    
    //MARK:- private
    
    //MARK:-  getter / setter
    
    //TODO: - 将要实现
    //FIXME: - 待修复
    
}


