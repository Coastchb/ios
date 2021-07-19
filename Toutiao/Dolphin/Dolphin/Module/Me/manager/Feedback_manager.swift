//
//  Feedback_manager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/28.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire

func Feedback(content: String) -> Bool {
    var user_id = User.get_user_id() ?? "-1"
    var ret = false
    let urlPath = "http://localhost:8888/user/feedback"
    print(urlPath)
    var params = ["content": content,
                  "user_id":user_id]
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
