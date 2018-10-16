//
//  StringExtension.swift
//  Panagram
//
//  Created by pengyucheng on 16/6/15.
//  Copyright © 2016年 recomend. All rights reserved.
//

import Foundation

extension String{
    
    /// 字符串比较
    ///
    /// - Parameter s: 比较的字符串
    /// - Returns: 字符串是否一样
    func isAnagramOfString(s:String) -> Bool {
        //1. 忽略两个字符串之间的大写和空格
        let lowerSelf = self.lowercased().replacingOccurrences(of: " ", with: "")
        let lowerOther = s.lowercased().replacingOccurrences(of:" ", with: "")
        
        //2. 检查两个字符串是否包含相同的字符，以及所有字符出现的次数是否相同
        return lowerSelf.sorted() == lowerOther.sorted()
    }
    
    /// 比较字符串字符是否对称排序
    /// - Returns: 是否
    func isPalindrome() -> Bool {
        //1.删除大写和空格
        let f = self.lowercased().replacingOccurrences(of:" ", with: "")
        //2. 用反向字符创建第二个字符串
        let s = String(f.reversed())
        //3. 如果它们相等，就是回文
        return f == s
    }
}
