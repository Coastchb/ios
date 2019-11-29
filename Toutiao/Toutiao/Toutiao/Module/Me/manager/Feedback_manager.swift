//
//  Feedback_manager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/28.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func Feedback(content: String) -> String {
    var user_name = User.get_user_name()!
    var ret = "反馈失败！"
    let urlPath = "http://localhost:8888/user/feedback?\(user_name)&\(content)"
    print(urlPath)
    let a = URL(string: urlPath)
    print(a)
     guard let endpoint = URL(string: urlPath) else {
         print("Error creating endpoint")
         return ret
     }
     
     var request = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
     
     do {
         let data = try JSONSerialization.data(withJSONObject: [], options: [])
         request.httpBody = data
     } catch {
         print("Error while serialize json data")
         return ret
     }
     
     var finished = false
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         do {
             guard let data = data else {
                 return
             }
            print("feedback returns:")
             print(try? JSONSerialization.jsonObject(with: data, options: []))
             // It seems that the key for json must be String!
             if let rep = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [String]] {
                 print("\(rep)")
                rep.forEach({ arg in
                    ret = rep["ret"]![0]
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
    
    return ret
}
