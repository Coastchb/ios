import PerfectHTTP
import PerfectHTTPServer
import MySQLStORM
import Foundation
import PerfectLib

MySQLConnector.host = "localhost"
MySQLConnector.port = 3306
MySQLConnector.username = "root"
MySQLConnector.password = "Mysql1991"
MySQLConnector.database = "Toutiao"

// the connection info and setup() should be infront of the launch of servers
let obj_news = News()
do {
    try obj_news.setup() // if table exists, use it, or create it
} catch {
    print("Error while setup news table")
}


let user_obj = Users()
do {
    try user_obj.setup()
} catch {
    print("Error while steup user table")
}

var routes = Routes()

routes.add(method: .post, uri: "/show_tutorials") {
    request, response in
    print("your uri:/show_tutorials")
        
    let (_,load_type) = request.params()[1]
    let (_,page_no) = request.params()[2]
    let (_,latest_time) = request.params()[0]
    //let (_,time2_str) = request.params()[3]
    let (_,user_tags_str) = request.params()[3]

    let user_tags = string2intarray(raw_str:user_tags_str, seperator:"[], ")
    print(user_tags)
    
    let all_tutorials = show_tutorials(load_type: load_type, latest_time: latest_time, page_no: Int(page_no)!, tags:user_tags)
    print("all_tutorials:\(all_tutorials)")
    let header = "show all show_tag_tutorials"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_tutorials.forEach { cur_tutorial in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_tutorial.id)\":[\"\(cur_tutorial.tag)\",\"\(cur_tutorial.title)\",\"\(cur_tutorial.source)\",\"\(cur_tutorial.link)\",\"\(cur_tutorial.published_date)\"],"
    }
    json += "}"
    print("json:\(json)")
    //json = "{\"165\":[\"C++\",\"C++入门教程\",\"C语言网\",\"https://www.dotcpp.com/course/cpp/\",\"0\",\"0\",\"0\"],\"166\":[\"C++\",\"C++ 教程\",\"菜鸟教程\",\"https://www.runoob.com/cplusplus/cpp-tutorial.html\",\"0\",\"0\",\"0\"],}"
    print("json:\(json)")
    response.appendBody(string: json).completed()
    print(response.status)
}

routes.add(method: .post, uri: "/show_blogs") {
    request, response in
    print("your uri:/show_all_blogs")
    print(request.params())
    
    let (_,load_type) = request.params()[1]
    let (_,page_no) = request.params()[2]
    let (_,latest_time) = request.params()[0]
    //let (_,time2_str) = request.params()[3]
    let (_,user_tags_str) = request.params()[3]

    let user_tags = string2intarray(raw_str:user_tags_str, seperator:"[], ")
    print(user_tags)

    print(load_type)
    print(page_no)
    print(latest_time)
    print(user_tags_str)
    let all_blogs = show_blogs(load_type: load_type, latest_time: latest_time, page_no: Int(page_no)!, tags: user_tags)
    print(all_blogs)
    let header = "show all blogs"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_blogs.forEach { cur_blog in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_blog.id)\":[\"\(cur_blog.tag)\",\"\(cur_blog.title)\",\"\(cur_blog.abstract)\",\"\(cur_blog.link)\",\"\(cur_blog.score)\",\"\(cur_blog.published_date)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_videos") {
    request, response in
    print("your uri:/show_all_videos")
    
    let body_str = request.postBodyString
    
    var time1_str = ""
    var time2_str = ""
    var load_type = ""
    var page_no = 0
    var user_tags = [Int]()

    //print(try? JSONSerialization.jsonObject(with: (body_str?.data(using: .utf8))!, options: []))
    if let body_dict =  try? JSONSerialization.jsonObject(with: (body_str?.data(using: .utf8))!, options: []) as? Dictionary<String, Any> {
        time1_str = body_dict["time1"] as! String
        time2_str = body_dict["time2"] as! String
        load_type = body_dict["load_type"] as! String
        user_tags = body_dict["user_tags"] as! [Int]
        page_no = body_dict["page_no"] as! Int
    }
    
    let all_videos = show_videos(load_type: load_type, time1: time1_str, time2: time2_str, page_no: page_no, tags: user_tags)
    let header = "show all videos"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_videos.forEach { cur_video in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_video.id)\":[\"\(cur_video.tag)\",\"\(cur_video.title)\",\"\(cur_video.abstract)\",\"\(cur_video.link)\",\"\(cur_video.recommend_num)\",\"\(cur_video.star_num)\",\"\(cur_video.thanks_num)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_target_tutorial_text") {
    request, response in
    print("your uri:/show_target_tutorial_text")
    
    let (target_id, _) = request.params()[0]

    let target_tutorial_text = show_target_tutorial(id: Int(target_id) ?? 0)
    let header = "show the target tutorial"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    json += "\"\(target_tutorial_text.id)\":[\"\(target_tutorial_text.tag)\",\"\(target_tutorial_text.title)\",\"\(target_tutorial_text.source)\",\"\(target_tutorial_text.link)\"]"
    json += "}"
    response.appendBody(string: json).completed()
}
routes.add(method: .post, uri: "/show_target_tutorial_video") {
    request, response in
    print("your uri:/show_target_tutorial_video")
    
    let (target_id,_) = request.params()[0]

    let target_tutorial_video = show_target_video(id: Int(target_id) ?? 0)
    let header = "show the target tutorial video"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    json += "\"\(target_tutorial_video.id)\":[\"\(target_tutorial_video.tag)\",\"\(target_tutorial_video.title)\",\"\(target_tutorial_video.abstract)\",\"\(target_tutorial_video.link)\",\"\(target_tutorial_video.recommend_num)\"]"
    json += "}"
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_target_blog") {
    request, response in
    print("your uri:/show_target_blog")
    
    let (target_id,_) = request.params()[0]

    let target_blog = show_target_blog(id: Int(target_id) ?? 0)
    let header = "show the target blog"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    json += "\"\(target_blog.id)\":[\"\(target_blog.tag)\",\"\(target_blog.title)\",\"\(target_blog.abstract)\",\"\(target_blog.link)\",\"\(target_blog.score)\"]"
    json += "}"
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/login") {
    request, response in
    print("your uri:/login")
    
    let (_,phone_num) = request.params()[1]
    let (_,passwd) = request.params()[0]
    
    var json = ""
    print("\(phone_num),\(passwd)")
    
    if let target_user = login(phone_num: phone_num, passwd: passwd) {
        json = "{\"ret\": [\"\(target_user.user_id)\",\"\(target_user.phone_num)\",\"\(target_user.passwd)\",\"\(target_user.name)\",\"\(target_user.gender)\",\"\(target_user.avatar_url)\"]}"
    } else {
        json = "{\"ret\": [\"failed\"]}"
    }

    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/get_stared_items") {
    request, response in
    print("your uri:/get_stared_items")
    
    //let (_, user_id) = request.params()[0]
    let (_, user_id) = request.params()[0]

    var items_info = show_user_stared_items(user_id: user_id)
    
    /*
    var urls = [String]()

    for item in stared_items {
        let url = get_item_url(type: item.item_type, id: item.item_id)
        urls.append(url)
    }*/

    var json = "{\"ret\":["
    /*
    for cur_item in stared_items {
        json += "\"\(cur_item.item_type)\":[\"\(cur_item.item_id)\"],"
    }*/
    
    for info in items_info {
        json += "{\"id\":\"\(info.id)\",\"item_type\":\"\(info.item_type)\",\"item_id\":\"\(info.item_id)\",\"stared_date\":\"\(info.stared_date)\",\"item_title\":\"\(info.item_title)\",\"item_tag\":\"\(info.item_tag)\",\"source\":\"\(info.source)\",\"link\":\"\(info.link)\"},"
    }
    
    json += "]}"
    
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/get_item_url") {
    request, response in
    print("your uri:/get_item_url")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]

    var url = get_item_url(type: item_type, id: Int(item_id)!)

    var json = "{\"url\":[\"\(url)\"]}"
    
    print("\(json)")
    let header = "get item url"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_stared_item") {
    request, response in
    print("your uri:/add_stared_item")
    
    let (user_id,_) = request.params()[0]
    let (item_type,_) = request.params()[1]
    let (item_id,_) = request.params()[2]
    let (stared_date,_) = request.params()[3]

    var ret = ""
    if(add_stared_item(user_id: Int(user_id)!, type: item_type, id: Int(item_id)!, date:stared_date)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/remove_stared_item") {
    request, response in
    print("your uri:/remove_stared_item")
    
    let (user_id,_) = request.params()[0]
    let (item_type,_) = request.params()[1]
    let (item_id,_) = request.params()[2]

    var ret = ""
    if(remove_stared_item(user_id: user_id, type: item_type, id: Int(item_id)!)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_all_tags") {
    request, response in
    print("your uri:/show_all_tags")
    
    let all_tags = show_all_tags()
    print(all_tags)
    let header = "show all tags"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_tags.forEach { cur_tag in
        json += "\"\(cur_tag.tag_id)\":[\"\(cur_tag.tag_name)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_all_user_tags") {
    request, response in
    print("your uri:/show_all_user_tags")
    
    let (_,user_id) = request.params()[0]
    print(user_id)
    let all_user_tags = show_all_user_tags(user_id:user_id)
    print(all_user_tags)
    let header = "show all user tags"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_user_tags.forEach { cur_tag in
        json += "\"\(cur_tag.0)\":[\"\(cur_tag.1)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_user_tag") {
    request, response in
    print("your uri:/add_user_tag")
    
    let (_, user_id) = request.params()[1]
    let (_, tag_id) = request.params()[0]
    
    var ret = ""
    if(add_user_tags(user_id : user_id, tag_id: Int(tag_id)!)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/remove_user_tag") {
    request, response in
    print("your uri:/remove_user_tag")
    
    let (_, user_id) = request.params()[1]
    let (_, tag_id) = request.params()[0]

    var ret = ""
    if(remove_user_tags(user_id: Int(user_id)!, tag_id: Int(tag_id)!)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_user_added_tag") {
    request, response in
    print("your uri:/add_user_added_tag")
    
    let (_, user_id) = request.params()[3]
    let (_, tag_name) = request.params()[2]
    let (_, tag_fullname) = request.params()[0]
    let (_, tag_descrip) = request.params()[1]


    var ret = ""
    if(add_user_added_tags(user_id: user_id, tag_name: tag_name, tag_fullname:tag_fullname,tag_descrip:tag_descrip)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_user_added_tutorial") {
    request, response in
    print("your uri:/add_user_added_tutorial")
    print(request.params())
    let (_,user_id) = request.params()[3]
    let (_,tutorial_name) = request.params()[1]
    let (_,tutorial_url) = request.params()[2]
    let (_,tutorial_descrip) = request.params()[0]


    var ret = ""
    if(add_user_added_tutorials(user_id: user_id, tutorial_name: tutorial_name, tutorial_url: tutorial_url, tutorial_descrip: tutorial_descrip)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/get_recommendation_info") {
    request, response in
    print("your uri:/get_recommendation_info")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[2]

    var ret = get_recom_info(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!)

    var json = "{\"ret\":[\"\(ret.0)\",\"\(ret.1)\"]}"
    
    print("\(json)")
    let header = "get recommendation info"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_recommendation") {
    request, response in
    print("your uri:/add_recommendation")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[2]

    var ret = add_recom(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!)

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "add recommendation"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/remove_recommendation") {
    request, response in
    print("your uri:/remove_recommendation")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[2]

    var ret = remove_recom(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!)

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "remove recommendation"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/get_star_info") {
    request, response in
    print("your uri:/get_star_info")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[2]

    var ret = get_star_info(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!)

    var json = "{\"ret\":[\"\(ret.0)\",\"\(ret.1)\"]}"
    
    print("\(json)")
    let header = "get star info"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_star") {
    request, response in
    print("your uri:/add_star")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[3]
    let (_, stared_date) = request.params()[2]

    var ret = add_star(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!, stared_date: stared_date)

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "add star"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/remove_star") {
    request, response in
    print("your uri:/remove_star")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[2]

    var ret = remove_star(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!)

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "remove star"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/get_thanks_info") {
    request, response in
    print("your uri:/get_thanks_info")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[2]

    var ret = get_thanks_info(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!)

    var json = "{\"ret\":[\"\(ret.0)\",\"\(ret.1)\"]}"
    
    print("\(json)")
    let header = "get thanks info"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_thanks") {
    request, response in
    print("your uri:/add_thanks")
    
    let (_, item_type) = request.params()[1]
    let (_, item_id) = request.params()[0]
    let (_, user_id) = request.params()[3]
    let (_, stared_date) = request.params()[2]

    var ret = add_thanks(item_type: item_type, item_id: Int(item_id)!, user_id: Int(user_id)!, stared_date: stared_date)

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    let header = "add thanks"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/get_contribution_info_for_user") {
    request, response in
    print("your uri:/user/get_contribution_info_for_user")
    
    let (_, publisher_id) = request.params()[0]
    //print("user id: \(publisher_id)")
    var ret = get_contribution_info_for_user(publisher_id: Int(publisher_id)!)

    var json = "{\"ret\":[\"\(ret.0)\",\"\(ret.1)\"]}"
    
    print("\(json)")
    let header = "get thanks_num for user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/avatar") {
    request, response in
    print("your uri:/image/content")
    /*
    print(try? request.postBodyBytes)
    print(try? request.postBodyString)
    print(try? request.postParams)
    print(try? request.pathComponents)
    print(try? request.postFileUploads)
    print(try? request.postFileUploads![0].fileName)
    print(try? request.postFileUploads![0].file)*/
    
    var file_name = (try? request.postFileUploads![0].fileName)!
    var received_file = (try? request.postFileUploads![0].file)!
    try? received_file.copyTo(path: "\(AVATAR_BASE_DIR)/\(file_name)",overWrite: true)
    
    
    //var ff = File("a")
    //var ff_str = try? ff.readString()
    //var d = Data(base64Encoded: <#T##String#>)
    //var image_data =
    
    var json = "{ret:OK}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/user_signup") {
    request, response in
    print("your uri:/user_signup")
    print(request.params())
    let (_,phone_num) = request.params()[2]
    let (_,user_name) = request.params()[3]
    let (_,passwd) = request.params()[1]
    let (_,gender) = request.params()[0]

    //print(request.params())
    //print("got:\(phone_num),\(user_name),\(passwd),\(gender)")
    var ret = ""
    if(signup(phone_num: phone_num, user_name:user_name, passwd: passwd, gender:gender)) {
        ret = "OK"
    } else {
        ret = "Error"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/find_phone_num") {
    request, response in
    print("your uri:/find_phone_num")
    let (_,phone_num) = request.params()[0]

    var ret = ""
    if(find_phone_num(phone_num: phone_num)) {
        ret = "existed"
    } else {
        ret = "not existed"
    }

    var json = "{\"ret\":[\"\(ret)\"]}"
    
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/change_username") {
    request, response in
    let (_, user_id) = request.params()[1]
    let (_, new_name) = request.params()[0]
    
    var ret = change_user_name(user_id:user_id, new_username:new_name)
    
    var json = "{\"ret\":[\"\(ret)\"]}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/change_passwd") {
    request, response in
    let (_, phone_num) = request.params()[2]
    let (_, old_passwd) = request.params()[1]
    let (_, new_passwd) = request.params()[0]
    
    var ret = change_user_passwd(phone_num:phone_num, old_passwd:old_passwd, new_passwd:new_passwd)
    
    var json = "{\"ret\":[\"\(ret)\"]}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/change_phone_num") {
    request, response in
    let (_, user_id) = request.params()[1]
    let (_, new_phone_num) = request.params()[0]
    
    var ret = change_phone_num(user_id:user_id, new_phone_num:new_phone_num)
    
    var json = "{\"ret\":[\"\(ret)\"]}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/change_gender") {
    request, response in
    let (_, user_id) = request.params()[1]
    let (_, new_gender) = request.params()[0]
    
    var ret = change_gender(user_id:user_id, new_gender:new_gender)
    
    var json = "{\"ret\":[\"\(ret)\"]}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/feedback") {
    request, response in
    let (_, user_id) = request.params()[1]
    let (_, content) = request.params()[0]
    
    var ret = write_feedback(user_id: user_id, content: content)
    var ret_str = ret ? "OK" : "ERROR"
    var json = "{\"ret\":[\"\(ret_str)\"]}"
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

func currentTime() -> String {
  let dateformatter = DateFormatter()
  dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
  // GMT时间 转字符串，直接是系统当前时间
  return dateformatter.string(from: Date())
}

routes.add(method: .get, uri: "/select_blog") {
    request, response in
    let cur_datetime = currentTime()
    print(cur_datetime)
    var ret = select_blog_by_date(cur_datetime: cur_datetime)
    
    var json = "{"
    ret.forEach { cur_blog in
        json += "\"\(cur_blog.id)\":[\"\(cur_blog.published_date)\"],"
    }
    json += "}"
    
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

do {
    try HTTPServer.launch(
        .server(name:"localhost", port:8888, routes:routes))
} catch {
    fatalError("\(error)")
}


/*
routes.add(method: .get, uri: "/image/get_avatar") {
    request, response in
    let (user_name, _) = request.params()[0]
    
    var avatar_path = "/Users/coastcao/Desktop/ios/Toutiao/files/\(user_name).jpg"
    print(avatar_path)
    var file = File(avatar_path)
    try? file.open()
    print(file)
    print(file.exists)
    print(file.isOpen)
    print(file.path)
    var content_str = try? file.readString()
    print(content_str)
    var data = Data(base64Encoded: content_str!)
    
    var json = "{avatar_content:\(data)}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}*/
