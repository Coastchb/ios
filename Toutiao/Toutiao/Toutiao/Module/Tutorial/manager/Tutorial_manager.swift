//
//  NewsManager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/22.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func get_all_tutorials() -> [(Int, String, String, String, String, Int)] {
    
    var urlPath = "http://localhost:8888/show_all_tutorials"
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
    
    var all_tutorials = [(Int, String, String, String, String, Int)]()
    var finished = false
    
    print("to get_all")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let tutorial = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                print(tutorial)
                tutorial.forEach { (cur_id, cur_content) in
                    all_tutorials.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])!))
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
    print(all_tutorials)
    return all_tutorials.sorted(by: {(a,b) in a.0 < b.0})
}

func get_all_videos() -> [(Int, String, String, String, String, Int)] {
    
    var urlPath = "http://localhost:8888/show_all_videos"
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
    
    var all_videos = [(Int, String, String, String, String, Int)]()
    var finished = false
    
    print("to get_all")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let video = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                print(video)
                video.forEach { (cur_id, cur_content) in
                    all_videos.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])!))
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
    print(all_videos)
    return all_videos.sorted(by: {(a,b) in a.0 < b.0})
}

func get_target_tutorial_text(id: Int) -> (Int, String, String, String, String, Int) {
    let urlPath = "http://localhost:8888/show_target_tutorial_text?" + String(id)
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

func get_target_tutorial_video(id: Int) -> (Int, String, String, String, String, Int) {
    let urlPath = "http://localhost:8888/show_target_tutorial_video?" + String(id)
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

/*
 func get_all() -> [(Int, String, String, String)] {
     
     let urlPath = "http://localhost:8888/show_all"
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
     
     var all_news = [(Int, String, String, String)]()
     var finished = false
     
     print("to get_all")
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         do {
             guard let data = data else {
                 return
             }
             // It seems that the key for json must be String! so is cast to [String,Int]!
             if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                 news.forEach { (cur_id, cur_content) in
                     all_news.append((Int(cur_id) ?? 0 ,cur_content[0], cur_content[1], cur_content[2]))
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
     //print(all_news)
     return all_news.sorted(by: {(a,b) in a.0 < b.0})
  
  /*
     print("to get all")
     return all
  */
 }

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

func get_target_2(id: Int) -> (Int, String, String, String) {
    
    let urlPath = "http://localhost:8888/show_target_2?" + String(id)
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

func get_all_3() -> [(Int, String, String, String, String, Int)] {
    
    let urlPath = "http://localhost:8888/show_all_3"
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
    
    var all_news = [(Int, String, String, String, String, Int)]()
    var finished = false
    
    print("to get_all")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (arg) in
                    
                    let (cur_id, cur_content) = arg
                    all_news.append((Int(cur_id) ?? 0 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])!))
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
    //print(all_news)
    return all_news.sorted(by: {(a,b) in a.0 < b.0})
 
 /*
    print("to get all")
    return all
 */
}

func get_target_3(id: Int) -> (Int, String, String, String) {
    
    let urlPath = "http://localhost:8888/show_target_3?" + String(id)
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
