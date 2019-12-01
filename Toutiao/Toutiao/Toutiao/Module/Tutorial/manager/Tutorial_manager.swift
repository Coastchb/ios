//
//  NewsManager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/22.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire

// 之所以加个可选的complete_handle，让这个函数有两种调用方式，是因为，在RefreshAutoGifHeader里直接调用get_all_tutorials的话，异步问题没法解决
func get_all_tutorials(complete_handle: (([(Int, String, String, String, String, Int)]) -> ())? = nil) -> [(Int, String, String, String, String, Int)]? {
    var urlPath = "http://localhost:8888/show_all_tutorials"

    var user_tags = Tag_item.get_user_tags(user_name: User.get_user_name())
    if (user_tags == nil || user_tags.count == 0) {
        return []
    }
    
    var all_tutorials = [(Int, String, String, String, String, Int)]()
    var finished = false
    let sema = DispatchSemaphore(value: 0)
    print(sema)
    print("user_tags:\(user_tags)")
    
    let semaphore = DispatchSemaphore(value: 0)
    
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return all_tutorials
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    let params = try? JSONSerialization.data(withJSONObject: user_tags, options: [])
    request.httpBody = params
    Alamofire.request(request).responseJSON(completionHandler: {response in
        print("response.result.isSuccess:\(response.result.isSuccess)")
        if(!response.result.isSuccess) {
            return
        }
        print("response.result.value:\(response.result.value)")
        if let tutorial = response.result.value as? [String : [String]] {
            tutorial.forEach { (cur_id, cur_content) in
                all_tutorials.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3],
                                      Int(cur_content[4])!))
            }
           }
        finished = true
        print("complete_handle:\(complete_handle)")
        if (complete_handle != nil) {
            complete_handle!(all_tutorials)
        }
        return
    })

    //print(sema)
    //semaphore.wait(timeout: DispatchTime(uptimeNanoseconds: 100) )

    print("complete_handle:\(complete_handle)")
    while(complete_handle == nil && !finished) {
        print("waiting...")
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    
    print(all_tutorials)
    return all_tutorials.sorted(by: {(a,b) in a.0 < b.0})
}
/*
  private func requestUrl(url:String, isPost:Bool) ->Any{

        var data:Any=""

        let request:DataRequest=self.getDataRequest(url: url, isPost: isPost)

        request.responseJSON(queue:DispatchQueue.main, options: .allowFragments, completionHandler: { (response)in

            data = response.result.value;

        })

        while String(describing: data).count == 0 {

            print("等待data有值")

           RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)

        }

        return data

    }*/

func get_all_videos() -> [(Int, String, String, String, String, Int)] {
    
    var urlPath = "http://localhost:8888/show_all_videos"
    var user_tags = Tag_item.get_user_tags(user_name: User.get_user_name())
    if (user_tags == nil || user_tags.count == 0) {
        return []
    }
    var tag_str = ""
    for i in 0..<(user_tags.count - 1) {
        tag_str += String(user_tags[i])
        tag_str += "&"
    }
    tag_str += String(user_tags.last!)
    
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
    
    while(!finished) {
        //RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
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


func add_user_added_tutorial_to_DB(tutorial_name:String, tutorial_url:String, tutorial_descrip: String) -> String {
    var user_name = ""
    var tmp_user_name = User.get_user_name()
    if tmp_user_name == nil {
        user_name = "anonymity"
    } else {
        user_name = tmp_user_name!
    }
   
    var params = [
        "user_name": "\(user_name)",
        "tutorial_name": "\(tutorial_name)",
        "tutorial_url": "\(tutorial_url)",
        "tutorial_descrip": "\(tutorial_descrip)"
    ]

    var ret = ""
    var finished = false
    var url = "http://localhost:8888/add_user_added_tutorial"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            ret = "Error"
        }
        if let json = response.result.value as? [String : [String]] {
            ret = json["ret"]![0]
            print("OK:\(ret)")
            finished = true
           }
    }
    )
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    print(ret)
    return ret
}
