//
//  blog_manger.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/18.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func get_all_blogs() -> [(Int, String, String, String, String, Int)] {
    
    var urlPath = "http://localhost:8888/show_all_blogs"
    var user_tags = Tag_item.get_user_tags(user_name: User.get_user_name())
    if (user_tags == nil || user_tags!.count == 0) {
        return []
    }
    var tag_str = ""
    for i in 0..<(user_tags!.count - 1) {
        tag_str += String(user_tags![i])
        tag_str += "&"
    }
    tag_str += String(user_tags!.last!)
    
    urlPath += "?"
    urlPath += tag_str
    print("urlPath:\(urlPath)")
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
    
    var all_blogs = [(Int, String, String, String, String, Int)]()
    var finished = false
    
    print("to get all blogs")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let blog = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                blog.forEach { (cur_id, cur_content) in
                    all_blogs.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])!))
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
    return all_blogs.sorted(by: {(a,b) in a.0 < b.0})
 
 /*
    print("to get all")
    return all
 */
}

func get_target_blog(id: Int) -> (Int, String, String, String, String, Int) {
    let urlPath = "http://localhost:8888/show_target_blog?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","", "", -1)
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
    
    var target_tutorial_text = (-1,"","","", "", -1)
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
                news.forEach { (arg) in
                    
                    let (cur_id, cur_content) = arg
                    target_tutorial_text = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])) as! (Int, String, String, String, String, Int)
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
    return target_tutorial_text

}
