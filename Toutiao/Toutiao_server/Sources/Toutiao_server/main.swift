import PerfectHTTP
import PerfectHTTPServer
import MySQLStORM
import Foundation


MySQLConnector.host = "localhost"
MySQLConnector.port = 3306
MySQLConnector.username = "root"
MySQLConnector.password = "Mysql1991"
MySQLConnector.database = "Toutiao"

// the connection info and setup() should be infront of the launch of servers
let obj = News()
do {
    try obj.setup() // if table exists, use it, or create it
} catch {
    print("Error while setup table")
}

var routes = Routes()
/*
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello,world!</body></html>").completed()
}
routes.add(method: .get, uri: "/s0") {
    request, response in
    print("your uri:/s0")
    let saved_id = save_user()
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Congrate!</title><body>created successfully!  id:\(saved_id)</body></html>").completed()
}

routes.add(method: .get, uri: "/c0") {
    request, response in
    print("your uri:/c0")
    let (created_id,_) = request.params()[0]
    print("created_id:\(created_id)")
    try? create_user(Int(created_id)!)
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Congrate!</title><body>created successfully!  id:\(created_id)</body></html>").completed()
}

routes.add(method: .get, uri: "/f0") {
    request, response in
    print("your uri:/f0")
    let (find_id,_) = request.params()[0]
    print("find_id:\(find_id)")
    let find_ret = find_user(Int(find_id)!)
    let header = find_ret != "" ? "Found" : "Not found"
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>\(header)</title><body>created successfully!<br>  id:\(find_id);name:\(find_ret)</body></html>").completed()
}
*/
routes.add(method: .post, uri: "/show_all") {
    request, response in
    print("your uri:/show_all")
    
    let all_news = show_all()
    let header = "show all news"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    all_news.forEach { cur_news in
        //json += "\"\(cur_news.news_id)\":[{\"news_title\":\"\(cur_news.news_title)\"},{\"news_abstract\":\"\(cur_news.news_abstract)\"},{\"news_body\":\"\(cur_news.news_body)\"}],"
        json += "\"\(cur_news.news_id)\":[\"\(cur_news.news_title)\",\"\(cur_news.news_abstract)\",\"\(cur_news.news_body)\"],"
    }
    json += "}"
    response.appendBody(string: json).completed()
}

routes.add(method: .post, uri: "/show_target") {
    request, response in
    print("your uri:/show_target")
    
    let (target_id,_) = request.params()[0]
    
    let target_news = show_target(id: Int(target_id) ?? 0)
    let header = "show the target news"
    response.setHeader(.contentType, value: "application/json")
    var json = "{"
    json += "\"\(target_news.news_id)\":[\"\(target_news.news_title)\",\"\(target_news.news_abstract)\",\"\(target_news.news_body)\"]"
    json += "}"
    response.appendBody(string: json).completed()
}

/*
routes.add(method: .get, uri: "/d0") {
    request, response in
    print("your uri:/d0")
    let (delete_id,_) = request.params()[0]
    print("delete_id:\(delete_id)")
    let delete_ret = delete_user(Int(delete_id)!)
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>delete user</title><body>created successfully!<br> \(delete_ret)</body></html>").completed()
}

routes.add(method: .post, uri: "/count0") {
    request, response in
    let (a, _) = request.params()[0]
    
    var params : [String:String] = [:]
    // use str.data() to convert str (String) to Data
    do {
        if let tmp_params = try? JSONSerialization.jsonObject(with: a.data(using: String.Encoding.utf8)!, options: []) as! [String:String] {
            params = tmp_params
        }
    }catch {
    }
    print(params)
    print(params["param0"])
    
    
    
    let count = count_user()
    print("count:\(count)")
    var json = "{\"user_count\": \(count)}"
    
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: json).completed()
}
*/
do {
    try HTTPServer.launch(
        .server(name:"localhost", port:8888, routes:routes))
} catch {
    fatalError("\(error)")
}
