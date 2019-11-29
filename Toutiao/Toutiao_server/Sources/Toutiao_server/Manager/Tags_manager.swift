//
//  Tags_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/11/24.
//

import Foundation
import MySQLStORM

func show_all_tags() -> [Tags] {
    print("get all tags")
    
    let obj = Tags()
    try? obj.findAll()
    
    return obj.rows().sorted(by: {(n1,n2) in n1.tag_id < n2.tag_id})
}

func show_all_user_tags(user_name: String) -> [(Int,String)] {
    print("get user tags")
    
    var ret = [(Int,String)]()
    let obj = User_tags()
    do {
        try obj.find([("user_name",user_name)])
    } catch {
        print("ERROR")
    }
    obj.rows().forEach({ user_tag in
        let tag_obj = Tags()
        do {
            try tag_obj.find([("tag_id", user_tag.tag_id)])
        } catch {
            print("Error!")
        }
        tag_obj.rows().forEach({ tag in
            ret.append((tag.tag_id,tag.tag_name))
        })
    })
    print(ret)
    return ret
}

func add_user_tags(user_name: String, tag_id: Int) -> Bool {
    print("add user tags")
    
    let obj = User_tags()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = obj.rows().last!.id
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","user_name","tag_id"], params: [max_id + 1, user_name,tag_id], idcolumn: "id")
        print("auto_id:\(auto_id)")
        
    } catch {
        return false
    }
    return true
}

func remove_user_tags(user_name: String, tag_id: Int) -> Bool {
    print("remove user tags")
    
    let obj = User_tags()
        
    do {
        try obj.select(whereclause: "user_name = ? AND tag_id = ?", params: [user_name, tag_id], orderby: ["id"])
        if let target_row = obj.rows().last {
            var target_id = target_row.id
            print(target_id)
            obj.id = target_id
            try obj.delete()
        } else {
            return false
        }
    } catch {
        return false
    }
    return true
}
