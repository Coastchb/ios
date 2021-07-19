//
//  Stared_item_manager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/21.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire

func add_star(tableCell: UITableViewCell, item_type: String, item_id: Int, user_id: String) -> Bool {    
    var stared_time = currentTime("YYYY-MM-dd/HH:mm:ss")
    let params = [
        "item_id": "\(item_id)",
        "item_type": "\(item_type)",
        "user_id": "\(user_id)",
        "stared_date": "\(stared_time)"
    ]

    var ret = false
    var finished = false
    let url = "http://localhost:8888/add_star"
    print(url)
    print(params)
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            tableCell.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
            finished = true
            return
        }
        print("response.result.value:\(response.result.value)")
        if let json = response.result.value as? [String : [String]] {
            print(json["ret"]![0])
            ret = (json["ret"]![0] == "OK")
           }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }

    return ret
}

func remove_star(tableCell: UITableViewCell, item_type: String, item_id: Int, user_id: String) -> Bool {
    
    let urlPath = "http://localhost:8888/remove_stared_item?\(user_id)&\(item_type)&\(item_id)"
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
                finished = true
                return
             }
            if let json_data = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let rep = json_data as? [String: [String]] {
                    print("\(rep)")
                    rep.forEach { (arg) in
                        let (type, val) = arg
                        ret = val[0]
                    }
                }

             } else {
                tableCell.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
            }
             finished = true
         } catch let err as NSError {
             print("catch error:\(err.debugDescription)")
         }
     }
     task.resume()
     
     while(finished == false) {
        //print("waiting...")
     }
    
    return ret == "OK"
}

func get_stared_items() -> (Int, [(String,Int,String)]) {
    var ret = [(Int,String, Int,String)]()
    var status = -1
    
    let user_id = User.get_user_id()!
    let params = [
        "user_id": "\(user_id)"
    ]

    var finished = false
    let url = "http://localhost:8888/get_stared_items"
    print(url)
    print(params)
    if(check_network_available()) {
        DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cache(true).responseString {value in
            switch value.result {
            case .success(let string):
                print("read stared items from network:\(string)")
                
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    break
                } else {
                    print("Not Error")
                }
                if let json = string2dict(string) as? [String : Any?] {
                    if let r = json["ret"] as? Array<Dictionary<String,String>> {
                        r.forEach({item in
                            print(item)
                            ret.append((Int(item["id"]!)!,item["item_type"]!,Int(item["item_id"]!)!,item["stared_date"]!))
                        })
                    }
                }
                status = 0
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
        /*
        DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cacheString {value in
            print("read stared items from cache:\(value)")
            if let json = string2dict(value) as? [String : Any?] {
                if let r = json["ret"] as? Array<Dictionary<String,String>> {
                    r.forEach({item in
                        print(item)
                        ret.append((Int(item["id"]!)!,item["item_type"]!,Int(item["item_id"]!)!,item["stared_date"]!))
                    })
                    status = 0
                }
            }
        }*/
        status = -2
        ret = []
    }

    var final_ret = [(String, Int, String)]()
    ret.sorted(by: {(n1,n2) in n1.0 > n2.0}).forEach({item in
        final_ret.append((item.1,item.2,item.3))
    })
    print("stared items:\(final_ret)")
    return (status,final_ret)
}

func get_stared_item_url(item : (String,Int)) -> String {
    var ret = ""
    let urlPath = "http://localhost:8888/get_item_url"

     
    let params = ["item_type":item.0,
                  "item_id":item.1] as [String : Any]
    
    var finished = false
    if(check_network_available()) {
        DaisyNet.request(urlPath, method: .post, params:params, dynamicParams: [:]).cache(true).responseString { value in
            switch value.result {
            case .success(let string):
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    break
                } else {
                    print("Not Error")
                }
                print("read stared items url from network:\(string)")
                if let rep = string2dict(string) as? [String : [String]] {
                    ret = rep["url"]![0]
                }
            case .failure(let error):
                print("error: \(error)")
            }
            finished = true
        }
        while !finished {
            RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
        }
    } else {
            DaisyNet.request(urlPath, method: .post, params:params, dynamicParams: [:]).cacheString { value in
                print("read stared items url from cache:\(value)")
                if let rep = string2dict(value) as? [String : [String]] {
                    ret = rep["url"]![0]
                }
            }
        }
     print("stared item url:\(ret)")
     return ret
}

/*
func add_stared_item_to_DB(item_type:String, item_id:Int) -> Bool {
    var user_id = User.get_user_id()!
    
    var existed_stared_items = get_stared_items()
    let isContains = existed_stared_items.contains{ (type, id, date) -> Bool in
        return type == item_type && id == item_id
    }
    if(isContains) {
        return true
    }
    
    var stared_time = currentTime("YYYY-MM-dd/HH:mm:ss")
    let urlPath = "http://localhost:8888/add_stared_item?\(user_id)&\(item_type)&\(item_id)&\(stared_time)"
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
    var user_id = User.get_user_id()!
 
     let urlPath = "http://localhost:8888/remove_stared_item?\(user_id)&\(item_type)&\(item_id)"
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
}*/
