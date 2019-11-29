//
//  user_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/10/15.
//

import Foundation

func login(user_name:String, passwd:String) -> Bool {
    print("verifying user")
    //print("received user name:\(user_name)")
    //print("received passwd:\(passwd)")
    let obj = Users()
    obj.name = user_name
    //obj.passwd = passwd
    try? obj.get()
    //print("\(obj.rows().count)")
    //print("\(obj.rows()[0].name)")
    //print("\(obj.rows()[0].passwd)")
    return obj.rows().count > 0 ? obj.rows()[0].passwd == passwd : false
}

func change_user_passwd(user_name: String, old_passwd: String, new_passwd: String) -> String {
    print("change passwd")
    let obj = Users()
    obj.name = user_name
    try? obj.get()
    if (obj.passwd != old_passwd) {
        return "原密码错误！"
    }
    try? obj.update(data: [("passwd", new_passwd)], idName: "name", idValue: user_name)
    return "修改成功！"
    
}
