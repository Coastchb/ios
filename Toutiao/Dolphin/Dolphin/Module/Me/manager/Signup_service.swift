//
//  Signup_service.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

//用户注册服务
class SignupService {
     
    //密码最少位数
    let minPasswordCount = PASSWD_MIN_LEN
     
    //验证用户名
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        //判断用户名是否为空
        if username.isEmpty {
            return .just(.empty)
        }
        return .just(.ok(message: "✅"))
         /*
        //判断用户名是否只有数字和字母
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "用户名只能包含数字和字母"))
        }
         
        //发起网络请求检查用户名是否已存在
        return networkService
            .usernameAvailable(username)
            .map { available in
                //根据查询情况返回不同的验证结果
                if available {
                    return .ok(message: "用户名可用")
                } else {
                    return .failed(message: "用户名已存在")
                }
            }
            .startWith(.validating) //在发起网络请求前，先返回一个“正在检查”的验证结果
        */
    }
     
    //验证密码
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
         
        //判断密码是否为空
        if numberOfCharacters == 0 {
            return .empty
        }
         
        //判断密码位数
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码至少需要 \(minPasswordCount) 个字符")
        }
         
        //返回验证成功的结果
        return .ok(message: "✅")
    }
     
    //验证二次输入的密码
    func validateRepeatedPassword(_ password: String, repeatedPassword: String)
        -> ValidationResult {
        //判断密码是否为空
        if repeatedPassword.count == 0 {
            return .empty
        }
         
        //判断两次输入的密码是否一致
        if repeatedPassword == password {
            return .ok(message: "✅")
        } else {
            return .failed(message: "两次输入的密码不一致")
        }
    }
}

class Singup_network_service {
    static func sign_up(phone_num:String, user_name:String, passwd:String, gender: String, avatar: UIImage) -> Bool  {
        var signup_ret = false
        print("get:\(phone_num),\(user_name),\(passwd),\(gender),\(avatar)")
        upload_avatar(phone_num: phone_num, image: avatar)
                
        let params = [
            "phone_num": "\(phone_num)",
            "user_name": "\(user_name)",
            "passwd": "\(passwd)",
            "gender": "\(gender)",
        ]
        //print(params)
        var finished = false
        let url = "http://localhost:8888/user/user_signup"
        Alamofire.request(url, method: .post, parameters: params, headers: nil).responseJSON(completionHandler: {response in
            if(!response.result.isSuccess) {
                return
            }
            if let json = response.result.value as? [String : [String]] {
                signup_ret = (json["ret"]![0] == "OK")
                print("signup_ret:\(signup_ret)")
                finished = true
               }
        }
        )
        
        while !finished {
            RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
        }
        
        while(finished == false) {
            
        }
        
        return signup_ret
    }
}
