//
//  NewsManager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/22.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func login(user_name:String, password:String) -> String {
    
    let urlPath = "http://localhost:8888/login?\(user_name)&\(password)"
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return ""
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
        return ""
    }
    
    var finished = false
    var ret : String = ""
    print("to verify user")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            //print(try? JSONSerialization.jsonObject(with: data, options: []))
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                print("\(rep)")
                let a = rep["ret"]!
                ret = a[0]
               
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    //print(all_news)
    return ret
 
 /*
    print("to get all")
    return all
 */
}

/*
func get_target(id: Int) -> (Int, String, String, String) {
    
    let urlPath = "http://localhost:8888/show_target?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","")
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
    }
    
    var target_news : (Int, String, String, String) = (-1,"","","")
    var finished = false
    
    print("to get_target")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            //print(try? JSONSerialization.jsonObject(with: data, options: []))
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    target_news = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2])
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
    return target_news
 /*
    print("to get \(id)")
    return all[id] //(1,"a","aa","aaa")
 */
}
*/
