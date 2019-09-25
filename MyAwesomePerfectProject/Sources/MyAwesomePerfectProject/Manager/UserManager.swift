//
//  UserManager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/20.
//

import Foundation

var default_id = 0

func save_user () -> Int {
    print("before default save of user,default_id=\(default_id)")
    let obj = User()
    obj.user_id = default_id
    obj.user_name = "Coast_" + String(default_id)
    try? obj.save()
    default_id += 1
    print("obj.user_id:\(obj.user_id); obj.user_name:\(obj.user_name)")
    print("after default save of user,default_id=\(default_id)")
    return default_id
}

func create_user (_ id: Int) {
    print("user_id:\(id)")
    let obj = User()
    obj.user_id = id
    obj.user_name = "coast_" + String(id)
    try? obj.create()
    print("after creating")
}

func find_user (_ id: Int) -> String {
    print("to find user_id:\(id)")
    let obj = User()
    obj.user_id = id
    try? obj.get()
    //print("\(obj.user_id)\t\(obj.user_name)")
    return obj.user_name
}

func delete_user (_ id: Int) -> String {
    let user_name = find_user(id)
    if (user_name == "") {
        return "user_id:\(id) not exists!"
    }
    let obj = User()
    obj.user_id = id
    try? obj.delete()
    return "Deleted!"
}

func count_user () -> Int {
    print("counting users")
    let obj = User()
    try? obj.findAll()
    return obj.rows().count
}

func show_all () -> [User] {
    print("to show all users")
    let obj = User()
    try? obj.findAll()
    return obj.rows()s
}
