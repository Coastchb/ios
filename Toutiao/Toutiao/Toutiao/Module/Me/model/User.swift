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
        if let user_info = UserDefaults.standard.value(forKey: USER_INFO_KEY) as? [String] {
            return user_info
        
        }
        return nil
    }
    
    static func is_logined() -> Bool {
        print("user_info:\(get_user_info())")
        return get_user_info() != nil
    }
    
    static func get_user_name() -> String? {
        if let user_info = get_user_info() {
            return user_info[0]
        }
        return nil
    }
    
    /*
    static func get_user_id() -> Int? {
        if let user_info = get_user_info() {
            return user_info[
        }
    }*/
    
    static func get_user_avatar() -> UIImage? {
        let user_avatar_path = UserDefaults.standard.value(forKey: USER_AVATAR_KEY) as? String
        print("user_avatar_path:\(user_avatar_path)")
        
        /*if user_avatar_path == nil {
            return UIImage(imageLiteralResourceName: "dropdown_loading_03")
        }*/
        
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: user_avatar_path!)) {
            return get_user_avatar_from_server()
        }
        
        let user_avatar = UIImage.init(contentsOfFile: user_avatar_path!)
        return user_avatar
    }
    
    static func save_avatar(image_content: Data) -> String? {
        
        let avatar_path = NSString(string: USER_DATA_BASE_DIR).appendingPathComponent("\(User.get_user_name()!).jpg")
        do {
            try image_content.write(to: URL(fileURLWithPath: avatar_path), options: NSData.WritingOptions.atomic)
        }catch _{
            return nil
        }
        return avatar_path
    }
    
    static func change_user_passwd(name:String, old_passwd:String, new_passwd:String) -> String {
        return change_passwd(name: name, old: old_passwd, new: new_passwd)
    }
    static func logout() {
        UserDefaults.standard.removeObject(forKey: USER_INFO_KEY)
        UserDefaults.standard.synchronize()
        print("logouted!")
    }
}
