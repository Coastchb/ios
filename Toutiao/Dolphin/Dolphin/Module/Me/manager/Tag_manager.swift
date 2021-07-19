//
//  User_tag_manager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/24.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire

func get_all_tags_from_DB(vc: UIViewController) -> [(Int,String)] {
    var ret = [(Int, String)]()
    
    let urlPath = "http://localhost:8888/show_all_tags"

    DaisyNet.openResultLog = false
    /// 20s过期
    DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.never)
    /// 5s超时
    DaisyNet.timeoutIntervalForRequest(5)
    
    var finished = false
    
    if(check_network_available()) {
        DaisyNet.request(urlPath, method: .post, params: [:], dynamicParams: [:]).cache(true).responseString {value in
            switch value.result {
            case .success(let string):
                print("read tags from network:\(string)")
                
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    vc.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
                    break
                } else {
                    print("Not Error")
                }
                
                if let json = string2dict(string) as? [String : [String]] {
                   json.forEach({cur_tag in
                       ret.append((Int(cur_tag.key)!,cur_tag.value[0]))
                   })
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
        DaisyNet.request(urlPath, method: .post, params: [:], dynamicParams: [:]).cacheString {value in
            print("read tags from cache:\(value)")
            if let rep = string2dict(value) as? [String : [String]] {
                rep.forEach({cur_tag in
                    ret.append((Int(cur_tag.key)!,cur_tag.value[0]))
                })
            }
        }
    }
    print("all tags: \(ret)")
    return ret.sorted(by: {(n1,n2) in n1.1 < n2.1})
}

func get_user_tags_from_DB() -> [Int] {
    var ret = [Int]()
    let urlPath = "http://localhost:8888/show_all_user_tags"
     
    var finished = false
    
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return ret
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    var params = ["user_id": User.get_user_id()!]

    DaisyNet.openResultLog = false
    /// 20s过期
    DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.never)
    /// 5s超时
    DaisyNet.timeoutIntervalForRequest(5)
    
    if(check_network_available()) {
        var success = false

        DaisyNet.request(urlPath, method:.post, params: params, dynamicParams: [:]).cache(true).responseString{ value in
            switch value.result {
            case .success(let string):
                print("read from network:\(string)")
                
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    break
                } else {
                    print("Not Error")
                }
                
                if let rep = string2dict(string) as? [String : [String]] {
                    rep.forEach({cur_tag in
                        ret.append((Int(cur_tag.key)!))
                    })
                }
                
                print("all user tags from remote: \(ret)")
            
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
        DaisyNet.request(urlPath, method:.post, params: params, dynamicParams: [:]).cacheString(completion: { value in
            print("read from cache:\(value)")
            if let rep = string2dict(value) as? [String : [String]] {
                rep.forEach { cur_tag in
                    ret.append((Int(cur_tag.key)!))
                }
            }
        })
    }
    print("all user tags:\(ret)")
    return ret.sorted(by: {(n1,n2) in n1 < n2})
}

func add_user_tag_to_DB(tag_id:Int) -> Bool {
    var ret = false

    let urlPath = "http://localhost:8888/add_user_tag"
    let params = ["user_id":User.get_user_id()!,
                  "tag_id": tag_id] as [String : Any]
    
     var finished = false
     Alamofire.request(urlPath, method: .post, parameters:params, headers: nil).responseJSON(completionHandler: {response in
         if(response.result.isSuccess) {
            if let json = response.result.value as? [String : [String]] {
                ret = (json["ret"]![0] == "OK")
            }
        }
         finished = true
     })
     
     while !finished {
         RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
     }

    return ret
}

func remove_user_tag_from_DB(tag_id:Int) -> Bool {
    var user_id = User.get_user_id()!
    var ret = false
    
    let urlPath = "http://localhost:8888/remove_user_tag"
    let params = ["user_id":User.get_user_id()!,
                  "tag_id": tag_id] as [String : Any]
    
     var finished = false
     Alamofire.request(urlPath, method: .post, parameters:params, headers: nil).responseJSON(completionHandler: {response in
         if(response.result.isSuccess) {
            if let json = response.result.value as? [String : [String]] {
                print("json:\(json)")
               ret = (json["ret"]![0] == "OK")
            }
         }
         finished = true
     })
     
     while !finished {
         RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
     }
     
    return ret
}

func add_user_added_tag_to_DB(tag_name:String, tag_fullname:String, tag_descrip: String) -> Bool {
    var user_name = ""
    var tmp_user_name = User.get_user_name()
    if tmp_user_name == nil {
        user_name = "anonymity"
    } else {
        user_name = tmp_user_name!
    }
    
    let urlPath = "http://localhost:8888/add_user_added_tag"

    let params = ["user_id":User.get_user_id() ?? "-1",
                  "tag_name": tag_name,
                  "tag_abb": tag_fullname,
                  "tag_descrip":tag_descrip]
    
    var ret = false
    var finished = false
    Alamofire.request(urlPath, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
         if(response.result.isSuccess) {
             if let json = response.result.value as? [String : [String]] {
                ret = (json["ret"]![0] == "OK")
             }
         }
        finished = true
     })
     
     while !finished {
         RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
     }
    
     return ret
}

/*
func get_user_tags_from_DB() -> [Int] {
    var ret = [Int]()
    let urlPath = "http://localhost:8888/show_all_user_tags?\(User.get_user_id()!)"
    print("(urlPath):\(urlPath)")
    guard let endpoint = URL(string: urlPath) else {
         print("Error creating endpoint")
         return []
     }
     
     var request = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
     
     do {
         let data = try JSONSerialization.data(withJSONObject: [], options: [])
         request.httpBody = data
     } catch {
         print("Error while serialize json data")
         return []
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
                rep.forEach({cur_tag in
                    ret.append((Int(cur_tag.key)!))
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
    
    return ret.sorted(by: {(n1,n2) in n1 < n2})
}*/
