//
//  NewsManager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/22.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

func init_tutorials_with_cache(vc:Tutorial_text?) ->[(Int, String, String, String, String, String)]? {
    var urlPath = "http://localhost:8888/show_tutorials"
    print("urlPath:\(urlPath)")
    var user_tags = vc!.user_tags
    if (user_tags == nil || user_tags.count == 0) {
        return []
    }
    
    var user_tags_str = "\(user_tags)"
    var params = ["user_tags": user_tags_str,"load_type":"init","latest_time":"", "page_no":1] as [String : Any]
    
    var all_tutorials = [(Int, String, String, String, String, String)]()
    
    DaisyNet.request(urlPath, method:.post, params: params,dynamicParams: ["latest_time":"", "load_type": "init"]).cacheString { value in
        print("read from cache:\(value)")
        if let tutorial = string2dict(value) as? [String : [String]] {
            tutorial.forEach { (cur_id, cur_content) in
                all_tutorials.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3], cur_content[4]))
            }
        }
        InfoViewController.next_more_page += 1
        return
    }
    print("all blogs from cache: \(all_tutorials)")

    return all_tutorials.sorted(by: {(a,b) in a.0 < b.0})
}

// 之所以加个可选的complete_handle，让这个函数有两种调用方式，是因为，在RefreshAutoGifHeader
func get_all_tutorials(vc: Tutorial_text?, load_type:String, latest_time: String, page_no:Int, complete_handle: (([(Int, String, String, String, String, String)]) -> ())? = nil) {
    var urlPath = "http://localhost:8888/show_tutorials"

    var user_tags = vc!.user_tags
    
    var all_tutorials = [(Int, String, String, String, String, String)]()
    
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return
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
    DaisyNet.timeoutIntervalForRequest(5)
    
    if(!check_network_available()) {
        complete_handle!(all_tutorials)
        vc?.prompt(OFFLINE_LOAD_PROMPT, OFFLINE_LOAD_PROMPT_DELAY)
        return
    } else {
        var cache = (load_type == "refresh")
        var success = false
        DaisyNet.request(urlPath, method: .post, params: params, dynamicParams:["latest_time":latest_time, "load_type": load_type]).cache(cache).responseJson {value in
            switch value.result {
            case .success(let json):
                var json_dict = JSON(json)
                json_dict.forEach { (arg) in
                    let (id, info) = arg
                all_tutorials.append((Int(id)!,info.array![0].string!,info.array![1].string!,info.array![2].string!,info.array![3].string!,info.array![4].string!))
                }
                success = true
                SERVER_CRASHED = false
                if (load_type == "more") {
                    if (all_tutorials.count == 0) {
                        Tutorial_text.no_more = true
                    } else {
                        Tutorial_text.next_more_page += 1
                    }
                } else {
                    Tutorial_text.no_more = false
                    Tutorial_text.next_more_page = 2
                }
                
                all_tutorials = all_tutorials.sorted(by: {(a,b) in a.0 < b.0})
                print("all tutorials from network:\(all_tutorials)")
            case .failure(let error):
                vc?.prompt(NETWORK_SLOW_PROMPT, NETWORK_SLOW_PROMPT_DELAY)
                print("error:\(error)")
            }
            
            if (complete_handle != nil) {
                complete_handle!(all_tutorials)
            }
            return
          }
    }
}

/*
func get_all_videos(load_type:String, latest_time:String, page_no:Int, complete_handle: (([(Int, String, String, String, String)]) -> ())? = nil) -> [(Int, String, String, String, String)] {
    
    var urlPath = "http://localhost:8888/show_videos"
    var user_tags = Tag_item.get_user_tags()
    if (user_tags == nil || user_tags.count == 0) {
        return []
    }

    print("urlPath:\(urlPath)")
    
    var all_videos = [(Int, String, String, String, String)]()
    var finished = false
    
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return []
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    var params = ["user_tags": user_tags,"load_type":load_type,"time1":time1,"time2":time2, "page_no":page_no] as [String : Any]
    
    DaisyNet.request(urlPath, method: .post, params: params, dynamicParams: ["latest_time":latest_time, "load_type": load_type]).responseJSON(completionHandler: {response in
        //print("response.result.isSuccess:\(response.result.isSuccess)")
        if(!response.result.isSuccess) {
            return
        }
        //print("response.result.value:\(response.result.value)")
        if let tutorial = response.result.value as? [String : [String]] {
            tutorial.forEach { (cur_id, cur_content) in
                all_videos.append((Int(cur_id)! ,cur_content[0], cur_content[1], cur_content[2], cur_content[3]))
            }
           }
        finished = true
        print("complete_handle:\(complete_handle)")
        
        if (load_type == "init" || (load_type == "more")) {
            if (all_videos.count == 0) {
                Tutorial_video.no_more = true
            } else {
                Tutorial_video.next_more_page += 1
            }
        }
        
        all_videos = all_videos.sorted(by: {(a,b) in a.0 < b.0})
        if (complete_handle != nil) {
            complete_handle!(all_videos)
        }
        return
    })

    print("complete_handle:\(complete_handle)")
    while(complete_handle == nil && !finished) {
        print("waiting...")
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }

    print(all_videos)
    return all_videos.sorted(by: {(a,b) in a.0 < b.0})
}

func get_target_tutorial_text(id: Int) -> (Int, String, String, String, String) {
    var target_tutorial_text = (-1,"","","", "")
    
    let params = [
        "id": "\(id)"
    ]

    var finished = false
    let url = "http://localhost:8888/show_target_tutorial_text"
    print(url)
    print(params)
    if(check_network_available()) {
        DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cache(true).responseString {value in
            switch value.result {
            case .success(let string):
                print("read target tutorial text from network:\(string)")
                
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    break
                } else {
                    print("Not Error")
                }
                if let json = string2dict(string) as? [String : [String]] {
                    json.forEach { (arg) in
                        let (cur_id, cur_content) = arg
                        target_tutorial_text = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3]) as! (Int, String, String, String, String)
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
            print("read target tutorial text from cache:\(value)")
            if let json = string2dict(value) as? [String : [String]] {
                json.forEach { (arg) in
                    let (cur_id, cur_content) = arg
                    target_tutorial_text = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3]) as! (Int, String, String, String, String)
                }
            }
        }
    }

    return target_tutorial_text
}*/

// 不能基于Alamofire， 否则删除收藏后会出错
func get_target_tutorial_text(id: Int) -> (Int, String, String, String, String) {
    let urlPath = "http://localhost:8888/show_target_tutorial_text?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","", "")
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
    
    var target_tutorial_text = (-1,"","","", "")
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
                    target_tutorial_text = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3]) as! (Int, String, String, String, String)
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

func get_target_tutorial_video(id: Int) -> (Int, String, String, String, String) {
    let urlPath = "http://localhost:8888/show_target_tutorial_video?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","", "")
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
    
    var target_tutorial_text = (-1,"","","", "")
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
                    target_tutorial_text = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2], cur_content[3]) as! (Int, String, String, String, String)
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


func add_user_added_tutorial_to_DB(vc: UIViewController, tutorial_name:String, tutorial_url:String, tutorial_descrip: String) -> Bool {
    var user_id = User.get_user_id() ?? "-1"
   
    var params = [
        "user_id": "\(user_id)",
        "tutorial_name": "\(tutorial_name)",
        "tutorial_url": "\(tutorial_url)",
        "tutorial_descrip": "\(tutorial_descrip)"
    ]

    var ret = ""
    var finished = false
    var url = "http://localhost:8888/add_user_added_tutorial"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(response.result.isSuccess) {
           if let json = response.result.value as? [String : [String]] {
                ret = json["ret"]![0]
            }
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    return (ret == "OK")
}

func get_related_info(info_type: String, item_type: String, item_id: Int, user_id: String) -> (Int, Int) {
    let params = [
        "item_id": "\(item_id)",
        "item_type": "\(item_type)",
        "user_id": "\(user_id)"
    ]

    var ret = (-1, -1)
    var finished = false
    let url = "http://localhost:8888/get_\(info_type)_info"

    DaisyNet.openResultLog = false
    /// 20s过期
    DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.never)
    /// 5s超时
    DaisyNet.timeoutIntervalForRequest(5)

    if(check_network_available()) {
        print("online while getting star info")
        var success = false

        DaisyNet.request(url, method:.post, params: params, dynamicParams: [:]).cache(true).responseString{ value in
            switch value.result {
                 case .success(let string):
                     print("read from network:\(string)")

                     if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                         SERVER_CRASHED = true
                         break
                     }
                     
                     if let rep = string2dict(string) as? [String : [String]] {
                        var star_ret = rep["ret"]
                        ret.0 = Int(star_ret![0])!
                        ret.1 = Int(star_ret![1])!
                        //finished = true
                     }
                     
                     print("all info from remote: \(ret)")
                 
                 case .failure(let error):
                     print("error: \(error)")
                 }
                 finished = true
                 return
             }
             
             while (!finished) {
                 print("waiting...")
                 RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
            }
    } else {
        print("offline while getting star info")
        DaisyNet.request(url, method:.post, params: params, dynamicParams: [:]).cacheString(completion: { value in
            print("read from 'related info' cache:\(value)")
            if let rep = string2dict(value) as? [String : [String]] {
                var star_ret = rep["ret"]
                ret.0 = Int(star_ret![0])!
                ret.1 = Int(star_ret![1])!
            }
        })
    }

    print("ret:\(ret)")
    return ret
}

func add_recommendation(tableCell: UITableViewCell, item_type: String, item_id: Int, user_id: String) -> Bool {
    let params = [
        "item_id": "\(item_id)",
        "item_type": "\(item_type)",
        "user_id": "\(user_id)"
    ]

    var ret = false
    var finished = false
    let url = "http://localhost:8888/add_recommendation"
    print(url)
    print(params)
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            tableCell.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
        }else if let json = response.result.value as? [String : [String]] {
            print(json["ret"]![0])
            ret = (json["ret"]![0] == "OK")
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    print(ret)
    return ret
}

func remove_recommendation(tableCell: UITableViewCell, item_type: String, item_id: Int, user_id: String) -> Bool {
    let params = [
        "item_id": "\(item_id)",
        "item_type": "\(item_type)",
        "user_id": "\(user_id)"
    ]

    var ret = false
    var finished = false
    let url = "http://localhost:8888/remove_recommendation"
    print(url)
    print(params)
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            tableCell.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
        } else if let json = response.result.value as? [String : [String]] {
            print(json["ret"]![0])
            ret = (json["ret"]![0] == "OK")
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    print(ret)
    return ret
}

func add_thanks(tableCell: UITableViewCell, item_type: String, item_id: Int, user_id: String) -> Bool {
    var stared_time = currentTime("YYYY-MM-dd/HH:mm:ss")
    let params = [
        "item_id": "\(item_id)",
        "item_type": "\(item_type)",
        "user_id": "\(user_id)",
        "stared_date": "\(stared_time)"
    ]

    var ret = false
    var finished = false
    let url = "http://localhost:8888/add_thanks"
    print(url)
    print(params)
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            tableCell.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
        }else if let json = response.result.value as? [String : [String]] {
            print(json["ret"]![0])
            ret = (json["ret"]![0] == "OK")
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    print(ret)
    return ret
}

func get_website_logo(link: String) -> UIImage? {
    var domain_name = get_domain_name(link: link)
    // domain_name = ""
    if (domain_name == "") {
        domain_name = "default"
    }
    
    let logo_url = URL(string: "\(WEBSITE_LOGO_PREFIX)/\(domain_name).png")!
    var website_logo : Data
    if let logo_data = NSData(contentsOf: logo_url) {
        website_logo = logo_data as Data
        return UIImage.init(data: website_logo)
    } else {
        return UIImage(imageLiteralResourceName: DEFAULT_WEBSITE_LOGO_KEY)
    }
}

/*
func get_save_website_logo(link: String) -> UIImage? {
    var website_logo_local_path = UserDefaults.standard.value(forKey: WEBSITE_LOGO_KEY) as? String
    //print("website_logo_local_path:\(website_logo_local_path)")
    
    let fileManager = FileManager.default
    if ((website_logo_local_path == nil) || (!fileManager.fileExists(atPath: website_logo_local_path!))) {
        var domain_name = get_domain_name(link: link)
        // domain_name = ""
        if (domain_name == "") {
            domain_name = "default"
        }
    
        let logo_url = URL(string: "\(WEBSITE_LOGO_PREFIX)/\(domain_name).png")!
        var logo_data = NSData(contentsOf: logo_url)!
        
        website_logo_local_path = NSString(string: USER_DATA_BASE_DIR).appendingPathComponent("\(domain_name).png")
        do {
            try logo_data.write(to: URL(fileURLWithPath: website_logo_local_path!), options: NSData.WritingOptions.atomic)
        }catch _{
            return nil
        }
        
        print("after logging:\(website_logo_local_path)")
        UserDefaults.standard.set(website_logo_local_path, forKey: WEBSITE_LOGO_KEY)
    }
    
    let website_logo = UIImage.init(contentsOfFile: website_logo_local_path!)
    return website_logo
}*/
