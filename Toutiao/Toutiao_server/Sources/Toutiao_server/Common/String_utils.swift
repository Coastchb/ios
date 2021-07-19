//
//  String_utils.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2020/2/2.
//

import Foundation

// "[1,2,3]" => [1,2,3]
func string2intarray(raw_str:String, seperator: String) -> [Int] {
    return raw_str.components(separatedBy: CharacterSet(charactersIn: seperator)).filter( { a -> Bool in
        return a.count != 0
    }).map({ s -> Int in
        print(s)
        return Int(s)!
    })
}
