//
//  User.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/20.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

class User {
    static func get_user_info() -> [String]? {
        // user_info : ["user_id", "phone_num", "passwd", "user_name", “gender", "avatar_url"]
        if let user_info = UserDefaults.standard.value(forKey: USER_INFO_KEY) as? [String] {
            return user_info
        }
        return nil
    }
    
    static func is_logined() -> Bool {
        print("user_info:\(get_user_info())")
        return get_user_info() != nil
    }
    
    static func get_user_id() -> String? {
        if let user_info = get_user_info() {
            return user_info[0]
        }
        return nil
    }
    
    static func get_user_name() -> String? {
        if let user_info = get_user_info() {
            return user_info[3]
        }
        return nil
    }
    
    static func get_user_phone_num() -> String? {
        if let user_info = get_user_info() {
            return user_info[1]
        }
        return nil
    }
    
    static func get_user_gender() -> String? {
        if let user_info = get_user_info() {
            return user_info[4]
        }
        return nil
    }
    
    static func get_user_avatar_url() -> String? {
        if let user_info = get_user_info() {
            print(user_info)
            return user_info[5]
        }
        return nil
    }
    
    static func reset_user_name(new_user_name:String) -> Int {
        var ret = change_username(user_id: User.get_user_id()!, new_name: new_user_name)
        if (ret == 0) {
            var user_info = User.get_user_info()!
            user_info[3] = new_user_name
            UserDefaults.standard.set(user_info, forKey: USER_INFO_KEY)
        }
        return ret
    }
    
    static func reset_user_passwd(phone_num:String, old_passwd:String, new_passwd:String) -> Int {
        print("to change user passwd")
        print("\(old_passwd), \(new_passwd)")
        return change_passwd(phone_num: phone_num, old: old_passwd, new: new_passwd)
    }
    
    static func reset_phone_num(new_phone_num: String, complete_handle: ((Int) ->())? = nil) {
        // update DB
        change_phone_num(user_id: User.get_user_id()!, new_phone_num: new_phone_num,complete_handle: complete_handle)
    }
    
    static func reset_gender(gender:String) -> Int {
        var ret = change_gender(user_id: User.get_user_id()!, new_gender: gender)
        if (ret == 0) {
            var user_info = User.get_user_info()!
            user_info[4] = gender
            UserDefaults.standard.set(user_info, forKey: USER_INFO_KEY)
        }
        return ret
    }

    static func get_user_avatar(vc: UIViewController) -> UIImage? {
        // 1. read from cache
        let user_avatar_path = UserDefaults.standard.value(forKey: "\(USER_AVATAR_KEY)_\(User.get_user_id() ?? "-1")") as? String
        print("user_avatar_path:\(user_avatar_path)")
        let fileManager = FileManager.default
        // 2. read from server if none in cache
        if (user_avatar_path == nil || !fileManager.fileExists(atPath: user_avatar_path!)) {
            return get_user_avatar_from_server(vc: vc, avatar_url_str: User.get_user_avatar_url()!)
        }

        let user_avatar = UIImage.init(contentsOfFile: user_avatar_path!)
        print("avatar read from cache")
        return user_avatar
    }
    
    static func save_avatar_to_cache(avatar_path: String, image_content: Data) -> Bool{
        do {
            try image_content.write(to: URL(fileURLWithPath: avatar_path), options: NSData.WritingOptions.atomic)
        }catch _{
            return false
        }
        return true
    }
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: USER_INFO_KEY)
        UserDefaults.standard.synchronize()
        print("logouted!")
    }
}
