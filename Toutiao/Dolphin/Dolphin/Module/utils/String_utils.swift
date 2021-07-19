//
//  string_utils.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2020/1/29.
//  Copyright © 2020 coastcao(操海兵). All rights reserved.
//

import Foundation

// "https://www.google.com/a/b" => "www.google.com"
func get_domain_name(link: String) -> String {
    var ret = ""
    var pat = "^(http[s]*://){0,1}([^/]*)/.*"
    let regex = try? NSRegularExpression(pattern: pat, options: [])
    /// 进行正则匹配
    if let results = regex?.matches(in: link, options: [], range: NSRange(link.startIndex...,in:link)) {
        //print(results.count)
        for result in results{
            ret = String(link[Range(result.range(at: 2), in: link)!]) //,String(str1[Range(result.range(at: 2), in: str1)!]))
        }
    }
    return ret
}

// "["a":1,"b":2]" => ["a":1, "b":2]
func string2dict(_ str:String) -> [String: Any]?{
    let data = str.data(using:String.Encoding.utf8)
    if let dict = try? JSONSerialization.jsonObject(with: data!,options:
        JSONSerialization.ReadingOptions.mutableContainers)as? [String: Any] {
        return dict
    }
    return nil
}

// "[1,2,3]" => [1,2,3]
func string2intarray(_ str:String) -> [Int] {
    return str.components(separatedBy: CharacterSet(charactersIn: ",[]")).filter( { a -> Bool in
        return a.count != 0
    }).map({ str -> Int in
        return Int(str)!
    })
}
