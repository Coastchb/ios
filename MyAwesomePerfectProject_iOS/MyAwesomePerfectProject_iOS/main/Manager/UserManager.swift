//
//  UserManager.swift
//  MyAwesomePerfectProject_iOS
//
//  Created by coastcao(操海兵) on 2019/9/21.
//  Copyright © 2019 coastcao. All rights reserved.
//

import Foundation

func get_user_count() -> Int {
    let urlPath = "http://localhost:11111/count0"
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return -1
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")

    let json = ["param0":"value0", "param1": "value1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
        return -1
    }
    
    var user_count = 0
    var finished = false
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            guard let jsonArr = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return
            }
            user_count = jsonArr["user_count"] as! Int
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    
    task.resume()
    
    while(finished == false) {
    }
    
    return user_count
}

func show_all_users() -> [(Int,String)] {
    let urlPath = "http://localhost:11111/show_all"
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return []
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
        return []
    }
    
    var all_users : [(Int, String)] = []
    var finished = false
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            //print(try JSONSerialization.jsonObject(with: data, options: []))
        
            // It seems that the key for json must be String! so is cast to [String,Int]!
            guard let users = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int] else {
                return
            }
            
            users.forEach { cur_user in
                all_users.append((cur_user.value, cur_user.key))
            }
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    
    task.resume()
    
    while(finished == false) {
        
    }
    
    return all_users
}
