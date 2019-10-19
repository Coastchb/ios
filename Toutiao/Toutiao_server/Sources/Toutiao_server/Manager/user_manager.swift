//
//  user_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/10/15.
//

import Foundation

func login(user_name:String, passwd:String) -> Bool {
    print("verifying user")
    let obj = Users()
    obj.name = user_name
    //obj.passwd = passwd
    try? obj.get()
   // print("\(obj.rows().count)")
   // print("\(obj.rows()[0].name)")
   // print("\(obj.rows()[0].passwd)")
    return obj.rows()[0].passwd == passwd
}
