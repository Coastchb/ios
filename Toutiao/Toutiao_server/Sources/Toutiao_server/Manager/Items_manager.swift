//
//  news_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//

import Foundation
import MySQLStORM

func show_all_tutorials(tags:[Int]) -> [Tutorial] {
    print("show all tutorials")
    var ret = [Tutorial]()
    tags.forEach({ tag_id in
        let tag_obj = Tags()
        tag_obj.tag_id = tag_id
        try? tag_obj.get()
        var tag_name = tag_obj.tag_name
        let obj = Tutorial()
        obj.tag = tag_name
        try? obj.select(whereclause: "tag = ?", params: [tag_name], orderby: ["id"])
        //try? obj.findAll()
        print(obj.rows())
        obj.rows().forEach({tutorial in
            ret.append(tutorial)
        })
    })
    
    return ret.sorted(by: {(n1,n2) in n1.id < n2.id})
}

func show_all_blogs(tags:[Int]) -> [Blog] {
    print("show all blogs")
    var ret = [Blog]()
    tags.forEach({ tag_id in
        let tag_obj = Tags()
        tag_obj.tag_id = tag_id
        try? tag_obj.get()
        var tag_name = tag_obj.tag_name
        let obj = Blog()
        obj.tag = tag_name
        try? obj.select(whereclause: "tag = ?", params: [tag_name], orderby: ["id"])
        //try? obj.findAll()
        print(obj.rows())
        obj.rows().forEach({tutorial in
            ret.append(tutorial)
        })
    })
    
    return ret.sorted(by: {(n1,n2) in n1.id < n2.id})
}

func show_all_videos(tags:[Int]) -> [Video] {
    print("show all videos")
    var ret = [Video]()
    tags.forEach({ tag_id in
        let tag_obj = Tags()
        tag_obj.tag_id = tag_id
        try? tag_obj.get()
        var tag_name = tag_obj.tag_name
        let obj = Video()
        obj.tag = tag_name
        try? obj.select(whereclause: "tag = ?", params: [tag_name], orderby: ["id"])
        //try? obj.findAll()
        print(obj.rows())
        obj.rows().forEach({tutorial in
            ret.append(tutorial)
        })
    })
    
    return ret.sorted(by: {(n1,n2) in n1.id < n2.id})
}

func show_target_tutorial(id : Int) -> Tutorial {
    print("show target tutorial")
    let obj = Tutorial()
    obj.id = id
    try? obj.get()
    return obj
}

func show_target_blog(id : Int) -> Blog {
    print("show target blog")
    let obj = Blog()
    obj.id = id
    try? obj.get()
    return obj
}

func show_target_video(id : Int) -> Video {
    print("show target video")
    let obj = Video()
    obj.id = id
    try? obj.get()
    return obj
}

func show_user_stared_items(user_name : String) -> [Stared_items] {
    print("get stared items for user:\(user_name)")
    let obj = Stared_items()
    //obj.user_name = user_name
    try? obj.find([("user_name", user_name)])
    return obj.rows()
}

func get_item_url(type: String, id : Int) -> String {
    print("get item url")
    if (type == "tutorial_text") {
        let obj = Tutorial()
        obj.id = id
        try? obj.get()
        return obj.link
    } else if (type == "tutorial_video") {
        let obj = Video()
        obj.id = id
        try? obj.get()
        return obj.link
    } else {
        let obj = Blog()
        obj.id = id
        try? obj.get()
        return obj.link
    }
}

func add_stared_item(user_name:String,type:String,id:Int) -> Bool {
    print("add stared item")
    let obj = Stared_items()
    //obj.user_name = user_name
    //obj.item_type = type
    //obj.item_id = id
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = obj.rows().last!.id
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","user_name","item_type","item_id"], params: [max_id + 1, user_name,type,id], idcolumn: "id")
        print("auto_id:\(auto_id)")
        
    } catch {
        return false
    }
    return true
}

func remove_stared_item(user_name:String,type:String,id:Int) -> Bool {
    print("remove stared item")
    //let getObj = Stared_items()
    //try getObj.select(whereclause: "associatedUser = ?", params: [user], orderby: ["id"])
    let obj = Stared_items()
    do {
        
        try obj.select(whereclause: "user_name = ? AND item_type = ? AND item_id = ?", params: [user_name, type, id], orderby: ["id"])
        var target_id = obj.rows().last!.id
        print(target_id)
        obj.id = target_id
        try obj.delete()
        
    } catch {
        return false
    }
    return true
}





func show_all() -> [News] {
    print("show all news")
    let obj = News()
    try? obj.findAll()
    return obj.rows().sorted(by: {(n1,n2) in n1.news_id < n2.news_id})
}

func show_target(id: Int) -> News {
    print("show target news")
    let obj = News()
    obj.news_id = id
    try? obj.get(id)
    return obj
}
