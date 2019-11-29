//
//  User_tag_manager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/24.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func get_all_tags_from_DB() -> [(Int,String)] {
    var ret = [(Int, String)]()
    
     let urlPath = "http://localhost:8888/show_all_tags"
     guard let endpoint = URL(string: urlPath) else {
         print("Error creating endpoint")
         return ret
     }
     
     var request = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
     
     do {
         let data = try JSONSerialization.data(withJSONObject: [], options: [])
         request.httpBody = data
     } catch {
         print("Error while serialize json data")
         return ret
     }
     
     var finished = false
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         do {
             guard let data = data else {
                 return
             }
            print("get all tags returns:")
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                 print("\(rep)")
                rep.forEach({ (id,name) in
                    var tag_id = Int(id)!
                    var tag_name = name.last!
                    ret.append((tag_id,tag_name))
                    print("ret:\(ret)")
                })

             }
             finished = true
         } catch let err as NSError {
             print("catch error:\(err.debugDescription)")
         }
     }
     task.resume()
     
     while(finished == false) {
     }
    return ret.sorted(by: {(n1,n2) in n1.0 < n2.0})
}

func get_user_tags_from_DB(user_name: String) -> [Int] {
    var ret = [Int]()
    
     let urlPath = "http://localhost:8888/show_all_user_tags?\(user_name)"
     guard let endpoint = URL(string: urlPath) else {
         print("Error creating endpoint")
         return ret
     }
     
     var request = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
     
     do {
         let data = try JSONSerialization.data(withJSONObject: [], options: [])
         request.httpBody = data
     } catch {
         print("Error while serialize json data")
         return ret
     }
     
     var finished = false
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         do {
             guard let data = data else {
                 return
             }
            print("get all user tags returns:")
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                 print("\(rep)")
                rep.forEach({ (id,name) in
                    var tag_id = Int(id)!
                    var tag_name = name.last!
                    ret.append(tag_id)
                    print("ret:\(ret)")
                })

             }
             finished = true
         } catch let err as NSError {
             print("catch error:\(err.debugDescription)")
         }
     }
     task.resume()
     
     while(finished == false) {
     }
    return ret
}

func add_user_tag_to_DB(tag_id:Int) -> Bool {
    var user_name = User.get_user_name()!
    
    /*
    var existed_user_tags = get_user_tags_from_DB(user_name: user_name)
    let isContains = existed_user_tags.contains(tag_id)
    if(isContains) {
        return true
    }*/
    
     let urlPath = "http://localhost:8888/add_user_tag?\(user_name)&\(tag_id)"
    print(urlPath)
     guard let endpoint = URL(string: urlPath) else {
         print("Error creating endpoint")
         return false
     }
     
     var request = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
     
     do {
         let data = try JSONSerialization.data(withJSONObject: [], options: [])
         request.httpBody = data
     } catch {
         print("Error while serialize json data")
         return false
     }
     
    var ret = ""
     var finished = false
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         do {
             guard let data = data else {
                 return
             }
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                 print("\(rep)")
                rep.forEach { (arg) in
                    let (type, val) = arg
                    ret = val[0]
                }
             }
             finished = true
         } catch let err as NSError {
             print("catch error:\(err.debugDescription)")
         }
     }
     task.resume()
     
     while(finished == false) {
     }
    return ret == "OK"
}

func remove_user_tag_from_DB(tag_id:Int) -> Bool {
    var user_name = User.get_user_name()!
    
    /*
    var existed_user_tags = get_user_tags_from_DB(user_name: user_name)
    let isContains = existed_user_tags.contains(tag_id)
    if(isContains) {
        return true
    }*/
    
     let urlPath = "http://localhost:8888/remove_user_tag?\(user_name)&\(tag_id)"
    print(urlPath)
     guard let endpoint = URL(string: urlPath) else {
         print("Error creating endpoint")
         return false
     }
     
     var request = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
     
     do {
         let data = try JSONSerialization.data(withJSONObject: [], options: [])
         request.httpBody = data
     } catch {
         print("Error while serialize json data")
         return false
     }
     
    var ret = ""
     var finished = false
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         do {
             guard let data = data else {
                 return
             }
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                 print("\(rep)")
                rep.forEach { (arg) in
                    let (type, val) = arg
                    ret = val[0]
                }
             }
             finished = true
         } catch let err as NSError {
             print("catch error:\(err.debugDescription)")
         }
     }
     task.resume()
     
     while(finished == false) {
     }
    return ret == "OK"
}
