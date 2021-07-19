//
//  news_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//

import Foundation
import MySQLStORM

func show_tutorials(load_type: String, latest_time: String, page_no: Int, tags:[Int]) -> [Tutorial_text] {
    print("show all tutorials")
    var ret = [Tutorial_text]()
    
    tags.forEach({ tag_id in
        let tag_obj = Tags()
        tag_obj.tag_id = tag_id
        try? tag_obj.get()
        var tag_name = tag_obj.tag_name
        let obj = Tutorial_text()
        obj.tag = tag_name
        print(tag_name)
        var cur_tutorials = ArraySlice<Tutorial_text>()
        if (load_type == "init" || load_type == "refresh") {
            print("initial loading")
            try? obj.select(whereclause: "tag = ?", params: [tag_name], orderby: ["id"])
            //print(obj.rows())
            //cur_tutorials = obj.rows()[0..<min(obj.rows().count,NUM_PER_PAGE)]
            ret.append(contentsOf: obj.rows())
            print(ret)
        } else if (load_type == "more") {
            try? obj.select(whereclause: "tag = ? and published_date <= ?", params: [tag_name, latest_time], orderby: ["id"])
            //if (obj.rows().count < (page_no-1)*NUM_PER_PAGE) {
            //    return
            //}
            //cur_tutorials = obj.rows()[((page_no-1)*NUM_PER_PAGE)..<min(page_no*NUM_PER_PAGE,obj.rows().count)]
            ret.append(contentsOf: obj.rows())
        }
    })
    
    if(ret.count < (page_no-1)*NUM_PER_PAGE) {
        return []
    }
    return Array(ret.sorted(by: {(n1,n2) in n1.id < n2.id})[(page_no-1)*NUM_PER_PAGE..<min(ret.count,page_no*NUM_PER_PAGE)])
}

func show_blogs(load_type: String, latest_time: String, page_no: Int, tags:[Int]) -> [Blog] {
    print("show all blogs")
    var ret = [Blog]()
    tags.forEach({ tag_id in
        let tag_obj = Tags()
        tag_obj.tag_id = tag_id
        try? tag_obj.get()
        var tag_name = tag_obj.tag_name
        let obj = Blog()
        obj.tag = tag_name
        var cur_blogs = ArraySlice<Blog>()
        if (load_type == "init" || load_type == "refresh") {
            print("initial loading")
            try? obj.select(whereclause: "tag = ?", params: [tag_name], orderby: ["id"])
            ret.append(contentsOf: obj.rows())
        } else if (load_type == "more") {
            try? obj.select(whereclause: "tag = ? and published_date <= ?", params: [tag_name, latest_time], orderby: ["id"])
            ret.append(contentsOf: obj.rows())
        }
        /*} else {
            try? obj.select(whereclause: "tag = ? and published_date <= ? and published_date >= ?", params: [tag_name, time2, time1], orderby: ["id"])
            ret.append(contentsOf: obj.rows())
        }*/
    })
    
    if(ret.count < (page_no-1)*NUM_PER_PAGE) {
        return []
    }
    return Array(ret.sorted(by: {(n1,n2) in n1.published_date > n2.published_date})[(page_no-1)*NUM_PER_PAGE..<min(ret.count,page_no*NUM_PER_PAGE)])
}

func show_videos(load_type: String, time1: String, time2: String, page_no: Int, tags:[Int]) -> [Video] {
    print("show all videos")
    var ret = [Video]()
    tags.forEach({ tag_id in
        let tag_obj = Tags()
        tag_obj.tag_id = tag_id
        try? tag_obj.get()
        var tag_name = tag_obj.tag_name
        let obj = Video()
        obj.tag = tag_name
        var cur_videos = ArraySlice<Video>()
        if (load_type == "init") {
            print("video initial loading")
            try? obj.select(whereclause: "tag = ? and published_date <= ?", params: [tag_name, time1], orderby: ["id"])
            ret.append(contentsOf: obj.rows())
        } else if (load_type == "more") {
            try? obj.select(whereclause: "tag = ? and published_date <= ?", params: [tag_name, time1], orderby: ["id"])
            ret.append(contentsOf: obj.rows())
        } else {
            try? obj.select(whereclause: "tag = ? and published_date <= ? and published_date >= ?", params: [tag_name, time2, time1], orderby: ["id"])
            ret.append(contentsOf: obj.rows())
        }
    })
    
    if(ret.count < (page_no-1)*NUM_PER_PAGE) {
        return []
    }
    return Array(ret.sorted(by: {(n1,n2) in n1.id < n2.id})[(page_no-1)*NUM_PER_PAGE..<min(ret.count,page_no*NUM_PER_PAGE)])}

func show_target_tutorial(id : Int) -> Tutorial_text {
    print("show target tutorial")
    let obj = Tutorial_text()
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

/*
func show_user_stared_items(user_id : String) -> [Stared_items] {
    print("get stared items for user:\(user_id)")
    let obj = Stared_items()
    //obj.user_name = user_name
    try? obj.find([("user_id", user_id)])
    return obj.rows()
}*/

func show_user_stared_items(user_id : String) -> [Stared_item_info] {
    print("get stared items for user:\(user_id)")
    let obj = Stared_items()
    var ret = [Stared_item_info]()
    try? obj.find([("user_id", user_id)])
    obj.rows().forEach {stared_item in
        var title = ""
        var tag = ""
        var link = ""
        var source = ""
        if(stared_item.item_type == "tutorial_text") {
            let tutorial_text_obj = Tutorial_text()
            tutorial_text_obj.id = stared_item.item_id
            try? tutorial_text_obj.get()
            title = tutorial_text_obj.title
            tag = tutorial_text_obj.tag
            link = tutorial_text_obj.link
            source = tutorial_text_obj.source
        } else if (stared_item.item_type == "blog") {
            let blog_obj = Blog()
            blog_obj.id = stared_item.item_id
            try? blog_obj.get()
            title = blog_obj.title
            tag = blog_obj.tag
            link = blog_obj.link
            print(blog_obj)
        }
        ret.append(Stared_item_info(id: stared_item.id, item_type: stared_item.item_type, item_id: stared_item.item_id, stared_date: stared_item.stared_date, item_tag: tag, item_title: title, source: source, link: link))
    }
    return ret
}

func get_item_url(type: String, id : Int) -> String {
    print("get item url")
    if (type == "tutorial_text") {
        let obj = Tutorial_text()
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

func add_stared_item(user_id:Int,type:String,id:Int,date:String) -> Bool {
    print("add stared item")
    let obj = Stared_items()
    //obj.user_name = user_name
    //obj.item_type = type
    //obj.item_id = id
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.id
        }
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","user_id","item_type","item_id","stared_date"], params: [max_id + 1, user_id,type,id,date], idcolumn: "id")
        print("auto_id:\(auto_id)")
        
    } catch {
        return false
    }
    return true
}

func remove_stared_item(user_id:String,type:String,id:Int) -> Bool {
    print("remove stared item")
    //let getObj = Stared_items()
    //try getObj.select(whereclause: "associatedUser = ?", params: [user], orderby: ["id"])
    let obj = Stared_items()
    do {
        try obj.select(whereclause: "user_id = ? AND item_type = ? AND item_id = ?", params: [user_id, type, id], orderby: ["id"])
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

func add_user_added_tutorials(user_id: String, tutorial_name: String, tutorial_url: String, tutorial_descrip:String) -> Bool {
    print("add user added tutorial")
    
    let obj = User_added_tutorial()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.id
        }
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","user_id","tutorial_name","tutorial_url","tutorial_descrip"], params: [max_id + 1, user_id,tutorial_name, tutorial_url, tutorial_descrip], idcolumn: "id")
        print("auto_id:\(auto_id)")
        
    } catch {
        return false
    }
    return true
}

func select_blog_by_date(cur_datetime: String) -> [Blog] {
    let obj = Blog()
    do {
        try obj.select(whereclause: "published_date < ?", params: [cur_datetime], orderby: ["id"])
        return  obj.rows()
    } catch {
        return []
    }
}

func get_recom_info(item_type: String, item_id: Int, user_id: Int) -> (Int,Int){
    var ret = (0,0) // [recomended_num, user_recommended]
    
    let obj = Recommended_items()
    do {
        try obj.select(whereclause: "item_type = ? AND item_id = ?", params: [item_type, item_id], orderby: [])
        ret.0 = obj.rows().count
    } catch {
        return ret
    }
    
    if (user_id != -1 ) {
        let obj = Recommended_items()
        do {
            try obj.select(whereclause: "user_id = ? AND item_type = ? AND item_id = ?", params: [user_id, item_type, item_id], orderby: [])
            ret.1 = obj.rows().count
        } catch {
            return ret
        }
    }
    
    return ret
}

func add_recom(item_type: String, item_id: Int, user_id: Int) -> String {
    var ret = "ERROR" // [recomended_num, user_recommended]
    
    let obj = Recommended_items()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.id
        }
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","item_type","item_id","user_id"], params: [max_id+1, item_type, item_id, user_id], idcolumn: "id")
        ret = "OK"
        print("auto_id:\(auto_id)")
    } catch {
        return ret
    }
    return ret
}

func remove_recom(item_type: String, item_id: Int, user_id: Int) -> String {
    var ret = "ERROR" // [recomended_num, user_recommended]
    
    let obj = Recommended_items()
    do {
        try obj.select(whereclause: "user_id = ? AND item_type = ? AND item_id = ?", params: [user_id, item_type, item_id], orderby: [])
        var target_id = obj.rows().last!.id
        obj.id = target_id
        try obj.delete()
        ret = "OK"
    } catch {
        return ret
    }
    return ret
}

func get_star_info(item_type: String, item_id: Int, user_id: Int) -> (Int,Int){
    var ret = (0,0) // [recomended_num, user_recommended]
    
    let obj = Stared_items()
    do {
        try obj.select(whereclause: "item_type = ? AND item_id = ?", params: [item_type, item_id], orderby: [])
        ret.0 = obj.rows().count
    } catch {
        return ret
    }
    
    if (user_id != -1 ) {
        let obj = Stared_items()
        do {
            try obj.select(whereclause: "user_id = ? AND item_type = ? AND item_id = ?", params: [user_id, item_type, item_id], orderby: [])
            ret.1 = obj.rows().count
        } catch {
            return ret
        }
    }
    
    return ret
}

func add_star(item_type: String, item_id: Int, user_id: Int, stared_date: String) -> String {
    var ret = "ERROR" // [recomended_num, user_recommended]
    
    let obj = Stared_items()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.id
        }
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","item_type","item_id","user_id","stared_date"], params: [max_id+1, item_type, item_id, user_id,stared_date], idcolumn: "id")
        ret = "OK"
        print("auto_id:\(auto_id)")
    } catch {
        return ret
    }
    return ret
}

func remove_star(item_type: String, item_id: Int, user_id: Int) -> String {
    var ret = "ERROR" // [recomended_num, user_recommended]
    
    let obj = Stared_items()
    do {
        try obj.select(whereclause: "user_id = ? AND item_type = ? AND item_id = ?", params: [user_id, item_type, item_id], orderby: [])
        var target_id = obj.rows().last!.id
        obj.id = target_id
        try obj.delete()
        ret = "OK"
    } catch {
        return ret
    }
    return ret
}

func get_thanks_info(item_type: String, item_id: Int, user_id: Int) -> (Int,Int){
    var ret = (0,0) // [recomended_num, user_recommended]
    
    let obj = Thank_publisher()
    do {
        try obj.select(whereclause: "item_type = ? AND item_id = ?", params: [item_type, item_id], orderby: [])
        ret.0 = obj.rows().count
    } catch {
        return ret
    }
    
    if (user_id != -1 ) {
        let obj = Thank_publisher()
        do {
            try obj.select(whereclause: "user_id = ? AND item_type = ? AND item_id = ?", params: [user_id, item_type, item_id], orderby: [])
            ret.1 = obj.rows().count
        } catch {
            return ret
        }
    }
    
    return ret
}

func add_thanks(item_type: String, item_id: Int, user_id: Int, stared_date: String) -> String {
    var ret = "ERROR" // [recomended_num, user_recommended]
    
    let obj = Thank_publisher()
    do {
        try obj.select(whereclause: "", params: [], orderby: ["id"])
        var max_id = 0
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            max_id = existed_ones.last!.id
        }
        print(max_id)
        
        let auto_id = try obj.insert(cols: ["id","item_type","item_id","user_id"], params: [max_id+1, item_type, item_id, user_id], idcolumn: "id")
        ret = "OK"
        print("auto_id:\(auto_id)")
    } catch {
        return ret
    }
    return ret
}

func get_contribution_info_for_user(publisher_id: Int) -> (Int,Int) {
    var ret = (0,0)
    
    let obj = Tutorials_text_publisher()
    do {
        try obj.select(whereclause: "publisher_id = ?", params: [publisher_id], orderby: [])
        ret.0 += obj.rows().count
        
        obj.rows().forEach({item in
            let thanked_obj = Thank_publisher()
            try? thanked_obj.find([("item_type", item.item_type),("item_id", item.item_id)])
            ret.1 += thanked_obj.rows().count
        })
    } catch {
        return ret
    }
    return ret
}
