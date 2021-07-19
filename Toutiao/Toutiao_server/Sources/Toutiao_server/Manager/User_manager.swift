//
//  user_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/10/15.
//

import Foundation

func login(phone_num:String, passwd:String) -> Users? {
    print("verifying user")
    let obj = Users()
    do {
        try obj.select(whereclause: "phone_num=? and passwd=?", params: [phone_num,passwd], orderby: ["user_id"])
        if(obj.rows().count > 0) {
            return obj.rows()[0]
        }
    } catch {
        return nil
    }
    return nil
}

func change_user_name(user_id: String, new_username: String) -> Int {
    print("change username")
    let obj = Users()
    do {
        try obj.select(whereclause: "user_id=?", params:[user_id],orderby: ["user_id"])
        try obj.update(data: [("name", new_username)], idName: "user_id", idValue: obj.user_id)
    }catch {
        return 1
    }

    return 0
}

func change_user_passwd(phone_num: String, old_passwd: String, new_passwd: String) -> Int {
    print("change passwd")
    let obj = Users()
    try? obj.select(whereclause: "phone_num=?", params:[phone_num],orderby: ["user_id"])
    if (old_passwd != "" && obj.passwd != old_passwd) {
        return 1
    }
    try? obj.update(data: [("passwd", new_passwd)], idName: "user_id", idValue: obj.user_id)
    return 0
}

func change_phone_num(user_id: String, new_phone_num: String) -> Int {
    print("change phone num")
    let obj = Users()
    try? obj.select(whereclause: "user_id=?", params:[user_id],orderby: ["user_id"])

    try? obj.update(data: [("phone_num", new_phone_num)], idName: "user_id", idValue: obj.user_id)
    return 0
}

func change_gender(user_id: String, new_gender: String) -> Int {
    print("change gender")
    let obj = Users()
    try? obj.select(whereclause: "user_id=?", params:[user_id],orderby: ["user_id"])

    try? obj.update(data: [("gender", new_gender)], idName: "user_id", idValue: obj.user_id)
    return 0
}

func signup(phone_num: String, user_name:String, passwd: String, gender:String) -> Bool {
    print("new user signup")
    let obj = Users()
    
    do {
        try obj.select(whereclause: "", params: [], orderby: ["user_id"])
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.user_id
        }
        print(max_id)
        
        let avatar_url = "\(AVATAR_URL_BASE)/\(phone_num).jpg"
        try obj.insert(cols: ["user_id","name","passwd","avatar_url","gender","phone_num"], params: [max_id + 1, user_name, passwd, avatar_url, gender, phone_num], idcolumn: "user_id")
    } catch {
        return false
    }
    return true
}

func find_phone_num(phone_num:String) -> Bool{
    print("find phone num")
    let obj = Users()
    
    do {
        try obj.select(whereclause: "phone_num=?", params: [phone_num], orderby: ["user_id"])
        if(obj.rows().count > 0) {
            return true
        }
    } catch {
        return false
    }
    return false
}
