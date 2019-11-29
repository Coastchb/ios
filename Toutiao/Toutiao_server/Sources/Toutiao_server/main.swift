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

routes.add(method: .post, uri: "/show_all_tutorials") {
    request, response in
    print("your uri:/show_all_tutorials")
    
    var tags = [Int]()
    for i in 0..<(request.params().count-1) {
        print(request.params()[i])
        tags.append(Int(request.params()[i].0)!)
    }
    print(tags)
    let all_tutorials = show_all_tutorials(tags:tags)
    print(all_tutorials)
    let header = "show all show_tag_tutorials"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_tutorials.forEach { cur_tutorial in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_tutorial.id)\":[\"\(cur_tutorial.tag)\",\"\(cur_tutorial.title)\",\"\(cur_tutorial.abstract)\",\"\(cur_tutorial.link)\",\"\(cur_tutorial.score)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_all_blogs") {
    request, response in
    print("your uri:/show_all_blogs")
    
    var tags = [Int]()
    for i in 0..<(request.params().count-1) {
        print(request.params()[i])
        tags.append(Int(request.params()[i].0)!)
    }
    print(tags)
    let all_blogs = show_all_blogs(tags: tags)
    print(all_blogs)
    let header = "show all blogs"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_blogs.forEach { cur_blog in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_blog.id)\":[\"\(cur_blog.tag)\",\"\(cur_blog.title)\",\"\(cur_blog.abstract)\",\"\(cur_blog.link)\",\"\(cur_blog.score)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_all_videos") {
    request, response in
    print("your uri:/show_all_videos")
    
    var tags = [Int]()
    for i in 0..<(request.params().count-1) {
        print(request.params()[i])
        tags.append(Int(request.params()[i].0)!)
    }
    print(tags)
    let all_videos = show_all_videos(tags: tags)
    let header = "show all videos"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_videos.forEach { cur_video in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_video.id)\":[\"\(cur_video.tag)\",\"\(cur_video.title)\",\"\(cur_video.abstract)\",\"\(cur_video.link)\",\"\(cur_video.score)\"],"
    }
    json += "}"
    print(json)
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_target_tutorial_text") {
    request, response in
    print("your uri:/show_target_tutorial_text")
    
    let (target_id,_) = request.params()[0]

    let target_tutorial_text = show_target_tutorial(id: Int(target_id) ?? 0)
    let header = "show the target tutorial"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    json += "\"\(target_tutorial_text.id)\":[\"\(target_tutorial_text.tag)\",\"\(target_tutorial_text.title)\",\"\(target_tutorial_text.abstract)\",\"\(target_tutorial_text.link)\",\"\(target_tutorial_text.score)\"]"
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
    json += "\"\(target_tutorial_video.id)\":[\"\(target_tutorial_video.tag)\",\"\(target_tutorial_video.title)\",\"\(target_tutorial_video.abstract)\",\"\(target_tutorial_video.link)\",\"\(target_tutorial_video.score)\"]"
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

routes.add(method: .post, uri: "/login") {
    request, response in
    print("your uri:/login")
    
    let (user_name,_) = request.params()[0]
    let (passwd, _) = request.params()[1]
    
    var json = ""
    if (!login(user_name: user_name, passwd: passwd)) {
        json = "{\"ret\": [\"failed\"]}"
    } else {
        json = "{\"ret\": [\"\(user_name)\",\"\(passwd)\"]}"
    }

    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/get_stared_items") {
    request, response in
    print("your uri:/get_stared_items")
    
    let (user_name,_) = request.params()[0]

    var stared_items = show_user_stared_items(user_name: user_name)
    
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
    
    for cur_item in stared_items {
        json += "{\"type\":\"\(cur_item.item_type)\",\"id\":\"\(cur_item.item_id)\"},"
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
    
    let (type,_) = request.params()[0]
    let (id,_) = request.params()[1]

    var url = get_item_url(type: type, id: Int(id)!)
    
    /*
    var urls = [String]()

    for item in stared_items {
        let url = get_item_url(type: item.item_type, id: item.item_id)
        urls.append(url)
    }*/

    var json = "{\"url\":[\"\(url)\"]}"
    
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/add_stared_item") {
    request, response in
    print("your uri:/add_stared_item")
    
    let (user_name,_) = request.params()[0]
    let (item_type,_) = request.params()[1]
    let (item_id,_) = request.params()[2]

    var ret = ""
    if(add_stared_item(user_name: user_name, type: item_type, id: Int(item_id)!)) {
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
    
    let (user_name,_) = request.params()[0]
    let (item_type,_) = request.params()[1]
    let (item_id,_) = request.params()[2]

    var ret = ""
    if(remove_stared_item(user_name: user_name, type: item_type, id: Int(item_id)!)) {
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
    
    let (user_name, _) = request.params()[0]
    let all_user_tags = show_all_user_tags(user_name:user_name)
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
    
    let (user_name,_) = request.params()[0]
    let (tag_id,_) = request.params()[1]


    var ret = ""
    if(add_user_tags(user_name: user_name, tag_id: Int(tag_id)!)) {
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
    
    let (user_name,_) = request.params()[0]
    let (tag_id,_) = request.params()[1]


    var ret = ""
    if(remove_user_tags(user_name: user_name, tag_id: Int(tag_id)!)) {
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

routes.add(method: .post, uri: "/image/content") {
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
    try? received_file.copyTo(path: "/Users/coastcao/Desktop/ios/Toutiao/files/\(file_name)",overWrite: true)
    
    
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

routes.add(method: .post, uri: "/user/change_passwd") {
    request, response in
    let (user_name, _) = request.params()[0]
    let (old_passwd, _) = request.params()[1]
    let (new_passwd, _) = request.params()[2]
    
    var ret = change_user_passwd(user_name:user_name, old_passwd:old_passwd, new_passwd:new_passwd)
    
    var json = "{\"ret\":[\"\(ret)\"]}"
    print("\(json)")
    let header = "verifying user"
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/user/feedback") {
    request, response in
    let (user_name, _) = request.params()[0]
    let (content, _) = request.params()[1]
    
    var ret = write_feedback(user_name: user_name, content: content)
    var ret_str = ret ? "再次感谢您的反馈！" : "反馈失败！"
    var json = "{\"ret\":[\"\(ret_str)\"]}"
    print("\(json)")
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}

do {
    try HTTPServer.launch(
        .server(name:"localhost", port:8888, routes:routes))
} catch {
    fatalError("\(error)")
}

