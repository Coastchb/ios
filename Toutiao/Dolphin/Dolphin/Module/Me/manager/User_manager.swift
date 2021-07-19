//
//  NewsManager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/22.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

func login(phone_num:String, password:String) -> [String] {
    
     let params = [
         "phone_num": "\(phone_num)",
         "passwd": "\(password)",
     ]

     var ret = [String]()
     var finished = false
     let url = "http://localhost:8888/user/login"
     Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
         if(!response.result.isSuccess) {
            ret.append("failed")
         }
         if let json = response.result.value as? [String : [String]] {
            print("login ret:\(json["ret"]!)")
            json["ret"]!.forEach({ item in
                ret.append(item)
            })
            
            finished = true
            }
     })
     
     while !finished {
         RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
     }
     //print(ret)
     return ret
}

func change_passwd(phone_num: String, old:String, new:String) -> Int {
    var ret : Int = 2
    
    let params = [
        "phone_num": "\(phone_num)",
        "old_passwd": "\(old)",
        "new_passwd": "\(new)",
    ]

    print(params)
    var finished = false
    let url = "http://localhost:8888/user/change_passwd"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(response.result.isSuccess) {
            if let json = response.result.value as? [String : [String]] {
                ret = Int(json["ret"]![0])!
            }
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    print(ret)
    return ret
}

func change_username(user_id:String, new_name:String) -> Int {
    var ret = -1
    
    let params = [
        "user_id": "\(user_id)",
        "new_name": "\(new_name)",
    ]

    var finished = false
    let url = "http://localhost:8888/user/change_username"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(response.result.isSuccess){
            if let json = response.result.value as? [String : [String]] {
                ret = Int(json["ret"]![0])!
            }
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    //print(ret)
    return ret
}

func change_phone_num(user_id:String, new_phone_num:String,complete_handle: ((Int) ->())? = nil) {
    
    let params = [
        "user_id": "\(user_id)",
        "new_phone_num": "\(new_phone_num)",
    ]

    print(params)
    let url = "http://localhost:8888/user/change_phone_num"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            complete_handle!(1)
        }
        if let json = response.result.value as? [String : [String]] {
            let ret = Int(json["ret"]![0])!
            complete_handle!(ret)
            
            var user_info = User.get_user_info()!
            user_info[1] = new_phone_num
            UserDefaults.standard.set(user_info, forKey: USER_INFO_KEY)
        }
    })
}

func change_gender(user_id:String, new_gender:String) -> Int{
    var ret = -1
    
    let params = [
        "user_id": "\(user_id)",
        "new_gender": "\(new_gender)",
    ]

    print(params)
    var finished = false
    let url = "http://localhost:8888/user/change_gender"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(response.result.isSuccess) {
            if let json = response.result.value as? [String : [String]] {
                ret = Int(json["ret"]![0])!
            }
        }
        finished = true
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    //print(ret)
    return ret
}

func upload_avatar(phone_num:String, image: UIImage) -> (Bool,String) {
    //var image = self.avatar_img_view.image!
    var ret = false
    var msg = ""
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      msg = "头像处理失败，请重试或者选择其他头像"
      return (ret,msg)
    }
    
    var finished = false
    Alamofire.upload(multipartFormData: { multipartFormData in
      multipartFormData.append(imageData,
                               withName: "imagefile",
                               fileName: "\(phone_num).jpg",
                               mimeType: "image/jpeg")
    }, to:"http://localhost:8888/user/avatar")
    { (result) in
        switch result {
        case .success(let upload, _, _):
            upload.uploadProgress(closure: { (progress) in
                //print(progress)
            })
            upload.responseString { response in
                switch response.result {
                case .success(let string):
                    if(string.contains(SERVER_CRASH_ERROR_MSG)) {
                        msg = SERVER_CRASH_PROMPT
                        break
                    }
                    ret = true
                case .failure( _):
                    msg = SERVER_CRASH_PROMPT
                }
                finished = true
            }
        case .failure( _):
            msg = SERVER_CRASH_PROMPT
            finished = true
        }
    }
    
    while(!finished) {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    return (ret,msg)
}

func get_user_avatar_from_server(vc: UIViewController, avatar_url_str:String) -> UIImage? {
    // update user avatar, load from server and save to local and update UserDefaults
    var avatar_url = URL(string: avatar_url_str)
    var user_avatar : UIImage?
    
    if(!check_network_available()) {
        vc.prompt("未联网，获取头像失败", 1.0)
        user_avatar = UIImage(imageLiteralResourceName: DEFAULT_USER_AVATAR)
    }
    if let avatar_data = NSData(contentsOf: avatar_url!) {
        // 2.1 server is available
        let avatar_path = NSString(string: USER_DATA_BASE_DIR).appendingPathComponent("\(User.get_user_phone_num()!).jpg")
        User.save_avatar_to_cache(avatar_path: avatar_path, image_content: avatar_data as! Data)
        UserDefaults.standard.set(avatar_path, forKey: "\(USER_AVATAR_KEY)_\(User.get_user_id() ?? "-1")")
        user_avatar = UIImage.init(contentsOfFile: avatar_path)
    } else {
        // 2.2 server is inavailable
        user_avatar = UIImage(imageLiteralResourceName: DEFAULT_USER_AVATAR)
        vc.prompt("服务端错误，获取头像失败", 1.0)
    }
    return user_avatar
}

func is_phone_num_existed(phone_num:String) -> Bool{
    let params = [
        "phone_num": "\(phone_num)",
    ]

    var ret = false
    var finished = false
    let url = "http://localhost:8888/user/find_phone_num"
    Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
        if(!response.result.isSuccess) {
            return
        }
        if let json = response.result.value as? [String : [String]] {
            ret = (json["ret"]![0] == "existed")
           finished = true
           }
    })
    
    while !finished {
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }
    //print(ret)
    return ret
}

func init_contribution_of_user() -> (Int,Int) {
    var user_id = Int(User.get_user_id() ?? "-1")!
    var ret = (0,0)
    let params = [
        "publisher_id": "\(user_id)",
    ]
    let url = "http://localhost:8888/user/get_contribution_info_for_user"
    DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cacheString{ value in
        print("read from 'contribution info' cache:\(value)")
        if let json = string2dict(value) as? [String : [String]] {
            ret.0 = Int(json["ret"]![0])!
            ret.1 = Int(json["ret"]![1])!
        }
    }
    return ret
}

func get_contributions_of_user(vc: UIViewController, callback_func: (((Int,Int))->())? = nil){
    var user_id = Int(User.get_user_id() ?? "-1")!
    var ret = (0,0)
    
    if(user_id == -1) {
        callback_func!(ret)
        return
    }
    
    let params = [
        "publisher_id": "\(user_id)",
    ]

    let url = "http://localhost:8888/user/get_contribution_info_for_user"
    
    DaisyNet.openResultLog = false
    /// 20s过期
    DaisyNet.cacheExpiryConfig(expiry: DaisyExpiry.never)
    /// 5s超时
    DaisyNet.timeoutIntervalForRequest(5)
    
    if(check_network_available()) {
        print("network is availabel")
        DaisyNet.request(url, method: .post, params: params, dynamicParams: [:]).cache(true).responseString{value in
            print("to get contribution from network")
            //sleep(10)
            print("value.result:\(value.result)")
            switch value.result {
            case .success(let string):
                if (string.contains(SERVER_CRASH_ERROR_MSG)) {
                    //vc.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
                    SERVER_CRASHED = true
                    break
                }
                if let json = string2dict(string) as? [String : [String]] {
                    ret.0 = Int(json["ret"]![0])!
                    ret.1 = Int(json["ret"]![1])!
                }
                SERVER_CRASHED = false
            case .failure(let error):
                vc.prompt(UNKNOWN_ERROR_PROMPT, UNKNOWN_ERROR_PROMPT_DELAY)
            }
            print("contribution ret:\(ret)")
            callback_func!(ret)
            return
        }
    } else {
        vc.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
    }
}
