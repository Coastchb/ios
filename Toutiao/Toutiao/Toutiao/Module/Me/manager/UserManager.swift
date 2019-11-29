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
                
                if(a[0] == "failed") {
                    ret = a[0]
                } else {
                    ret = "passed"
                    
                    //var user_info = try JSONSerialization.data(withJSONObject: a, options: [])
                    UserDefaults.standard.set(a, forKey: USER_INFO_KEY)
                    UserDefaults.standard.synchronize()
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

func change_passwd(name:String, old:String, new:String) -> String {
   let urlPath = "http://localhost:8888/user/change_passwd?\(name)&\(old)&\(new)"
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
    print("to change user passwd")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            print(try? JSONSerialization.jsonObject(with: data, options: []))
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                print("\(rep)")
                ret = rep["ret"]![0]
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

func get_user_avatar_from_server() -> UIImage? {
    // update user avatar, load from server and save to local and update UserDefaults
    var avatar_url = URL(string: "http://localhost:8000/coastcao.jpg")!
    var avatar_data = NSData(contentsOf: avatar_url)!
    var avatar_path = User.save_avatar(image_content: avatar_data as Data)
    print("after logging:\(avatar_path)")
    UserDefaults.standard.set(avatar_path, forKey: USER_AVATAR_KEY)
    
    let user_avatar = UIImage.init(contentsOfFile: avatar_path!)
    return user_avatar
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
