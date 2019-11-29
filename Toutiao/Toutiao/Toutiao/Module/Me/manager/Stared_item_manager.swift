//
//  Stared_item_manager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/21.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func get_stared_items_from_DB(user_name : String) -> [(String,Int)] {
    var ret = [(String, Int)]()
    
     let urlPath = "http://localhost:8888/get_stared_items?\(user_name)"
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
            print("get all returns:")
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                 print("\(rep)")
                let val = rep["ret"] as! Array<Dictionary<String, String>>
                val.forEach { pair in
                    //print(pair["type"])
                    ret.append((pair["type"]!,Int(pair["id"]!)!))
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
    return ret
}

func get_stared_item_url(item : (String,Int)) -> String {
    var ret = ""
    let urlPath = "http://localhost:8888/get_item_url?\(item.0)&\(item.1)"
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
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                 print("\(rep)")
                rep.forEach { (arg) in
                    let (_, val) = arg
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
    return ret
}

func add_stared_item_to_DB(item_type:String, item_id:Int) -> Bool {
    var user_name = User.get_user_name()!
    
    var existed_stared_items = get_stared_items_from_DB(user_name: user_name)
    let isContains = existed_stared_items.contains{ (type, id) -> Bool in
        return type == item_type && id == item_id
    }
    if(isContains) {
        return true
    }
    
     let urlPath = "http://localhost:8888/add_stared_item?\(user_name)&\(item_type)&\(item_id)"
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

func remove_stared_item_from_DB(item_type:String, item_id:Int) -> Bool {
    var user_name = User.get_user_name()!
 
     let urlPath = "http://localhost:8888/remove_stared_item?\(user_name)&\(item_type)&\(item_id)"
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
