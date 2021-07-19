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
    
    return obj.rows().sorted(by: {(n1,n2) in n1.tag_name < n2.tag_name})
}

func show_all_user_tags(user_id: String) -> [(Int,String)] {
    print("get user \(user_id) tags")
    var ret = [(Int,String)]()
    let obj = User_tags()
    do {
        try obj.find([("user_id",user_id)])
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

func add_user_tags(user_id: String, tag_id: Int) -> Bool {
    print("add user tags")
    
    let obj = User_tags()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = obj.rows().last!.id
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","user_id","tag_id"], params: [max_id + 1, user_id,tag_id], idcolumn: "id")
        print("auto_id:\(auto_id)")
        
    } catch {
        return false
    }
    return true
}

func remove_user_tags(user_id: Int, tag_id: Int) -> Bool {
    print("remove user tags")
    
    let obj = User_tags()
        
    do {
        try obj.select(whereclause: "user_id = ? AND tag_id = ?", params: [user_id, tag_id], orderby: ["id"])
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

func add_user_added_tags(user_id: String, tag_name: String, tag_fullname: String, tag_descrip:String) -> Bool {
    print("add user added tags")
    
    let obj = User_added_tags()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.id
        }
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","user_id","tag_name","tag_fullname","tag_descrip"], params: [max_id + 1, user_id,tag_name, tag_fullname, tag_descrip], idcolumn: "id")
        print("auto_id:\(auto_id)")
        
    } catch {
        return false
    }
    return true
}
