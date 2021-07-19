//
//  blog_manger.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/18.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func init_blogs_with_cache(vc:InfoViewController?) ->[(Int, String, String, String, String, Int, String)]? {
    var urlPath = "http://localhost:8888/show_blogs"
    print("urlPath:\(urlPath)")
    var user_tags = vc!.user_tags
    if (user_tags == nil || user_tags.count == 0) {
        return []
    }
    
    var user_tags_str = "\(user_tags)"
    var params = ["user_tags": user_tags_str,"load_type":"init","latest_time":"", "page_no":1] as [String : Any]
    
    var all_blogs = [(Int, String, String, String, String, Int, String)]()
    
    DaisyNet.request(urlPath, method:.post, params: params,dynamicParams: ["latest_time":"", "load_type": "init"]).cacheString { value in
        print("read from cache:\(value)")
        if let tutorial = string2dict(value) as? [String : [String]] {
            tutorial.forEach { (cur_id, cur_content) in
                all_blogs.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3],
                                  Int(cur_content[4])!, cur_content[5]))
            }
        }
        InfoViewController.next_more_page += 1
        return
    }
    print("all blogs from cache: \(all_blogs)")

    return all_blogs.sorted(by: {(a,b) in a.6 > b.6})
}

func get_all_blogs(vc: InfoViewController?, load_type:String, latest_time:String,page_no:Int, complete_handle: (([(Int, String, String, String, String, Int, String)]) -> ())? = nil) {
    var urlPath = "http://localhost:8888/show_blogs"
    print("urlPath:\(urlPath)")
    var user_tags = vc!.user_tags
    
    var all_blogs = [(Int, String, String, String, String, Int, String)]()

    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return //all_blogs
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    var user_tags_str = "\(user_tags)"
    var params = ["user_tags": user_tags_str,"load_type":load_type,"latest_time":latest_time, "page_no":page_no] as [String : Any]

    DaisyNet.openResultLog = false
    /// 20s过期
    DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.never)
    /// 5s超时
    DaisyNet.timeoutIntervalForRequest(50)
    
   /*
    DaisyNet.removeObjectCache(urlPath, params: params,dynamicParams: ["time1":time1]) { success in
        switch success {
        case true:
            print("removed")
        case false:
            print("false")
        }
    }*/
    
    //print("params:\(params)")
    
    if(!check_network_available()) {
        complete_handle!(all_blogs)
        vc?.prompt(OFFLINE_LOAD_PROMPT, OFFLINE_LOAD_PROMPT_DELAY)
        return
    } else {
        //var finished = false
        var cache = (load_type == "refresh")
        print("Cache:\(cache)")
        var success = false

        DaisyNet.request(urlPath, method:.post, params: params,dynamicParams: ["latest_time":latest_time, "load_type": load_type]).cache(cache).responseJson{ value in
            switch value.result {
            case .success(let json):
                print("read from network:\(json)")
                
                var json_dict = JSON(json)

                json_dict.forEach { (arg) in
                    
                    let (cur_id, cur_content) = arg
                    all_blogs.append((Int(cur_id)! ,cur_content.array![0].string!, cur_content.array![1].string!, cur_content.array![2].string!, cur_content.array![3].string!,
                                      Int(cur_content.array![4].string!)!, cur_content.array![5].string!))
                }
                
                success = true
                SERVER_CRASHED = false
                if (load_type == "more") {
                    if (all_blogs.count == 0) {
                        InfoViewController.no_more = true
                    } else {
                        InfoViewController.next_more_page += 1
                    }
                } else {
                    InfoViewController.no_more = false
                    InfoViewController.next_more_page = 2
                }

                all_blogs = all_blogs.sorted(by: {(a,b) in a.6 > b.6})
                print("all blogs from remote: \(all_blogs)")
            case .failure(let error):
                vc?.prompt(NETWORK_SLOW_PROMPT, NETWORK_SLOW_PROMPT_DELAY)
                print("error: \(error)")
            }
    
            if (complete_handle != nil) {
                 complete_handle!(all_blogs)
                 //if (!success) {
                 //    vc?.prompt("加载失败！",0.5)
                 //}
             }
            return
        }
        //remote_available = success //(check_network_available() && success)
    }
}
/*
func get_target_blog(id: Int) -> (Int, String, String, String, String, Int) {
    var target_blog = (-1,"","","", "", -1)
    
    let params = [
        "id": "\(id)"
    ]

    var finished = false
    let url = "http://localhost:8888/show_target_blog"
    print(url)
    print(params)
    if(check_network_available()) {
        DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cache(true).responseString {value in
            switch value.result {
            case .success(let string):
                print("read target blog from network:\(string)")
                
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    break
                } else {
                    print("Not Error")
                }
                if let json = string2dict(string) as? [String : [String]] {
                    json.forEach { (arg) in
                        let (cur_id, cur_content) = arg
                        target_blog = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])) as! (Int, String, String, String, String, Int)
                    }
                }
            case .failure(let error):
                print("error: \(error)")
            }
            finished = true
            return
        }
        while !finished {
            RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
        }
    } else {
        DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cacheString {value in
            print("read target blog from cache:\(value)")
            if let json = string2dict(value) as? [String : [String]] {
                json.forEach { (arg) in
                    let (cur_id, cur_content) = arg
                    target_blog = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], Int(cur_content[4])) as! (Int, String, String, String, String, Int)
                }
            }
        }
    }

    return target_blog
}*/

func get_target_blog(id: Int) -> (Int, String, String, String, String, Int) {
    let urlPath = "http://localhost:8888/show_target_blog?\(id)"
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
