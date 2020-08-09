#!/usr/bin/swift sh
// 切换：系统命令工具
//#!/usr/bin/swift sh
// 默认：swift-sh命令工具 修改版本号：.macOS(.v10_15)
// (https://github.com/it-boyer)

/*:
  功能描述:

  - 主要接口:
  接口
  - 主要构造器:
  构造器
  - 模块

  使用：
  文件权限：chmod u+x file.swift
  执行命令： /.file.swif
 */

class script
{

    //MARK:- override

    //MARK:- api
    func say(name:String)->String
    {
        //该怎么开启算法的旅程
        //从类图，用例图，流程图开启算法之旅
        return "\(name)欢迎光临";
    }
    //MARK:- model event


    //MARK:- view event


    //MARK:- private

    //MARK:-  getter / setter

    //TODO: - 将要实现
    //FIXME: - 待修复

}

let say = script().say(name:"李四")
for x in 0..<4
{
    print(say)
}
