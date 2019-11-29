//
//  Tag_item.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/20.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

class Tag_item {
    static func get_all_tags() -> [(Int,String)] {
        return get_all_tags_from_DB()
    }
    
    static func add_tag(tag_id: Int) {
        if(!User.is_logined()) {
            var user_tags = [Int]()
            if let tag_list =  UserDefaults.standard.array(forKey: USER_TAGS_KEY) as? [Int] {
                tag_list.forEach { tag in
                   user_tags.append(tag)
                }
            }
            
            user_tags.append(tag_id)
            print("after added:\(user_tags)")
            UserDefaults.standard.setValuesForKeys([USER_TAGS_KEY: user_tags])
            UserDefaults.standard.synchronize()
        } else {
            // add tags to DB
            print("to add tag:\(tag_id)")
            add_user_tag_to_DB(tag_id: tag_id)
        }
    }
    
    static func remove_tag(tag_id:Int) {
        if(!User.is_logined()) {
            var user_tags = [(Int)]()
            if let tag_list =  UserDefaults.standard.array(forKey: USER_TAGS_KEY) as? [Int] {
                tag_list.forEach { tag in
                   user_tags.append(tag)
                }
            }
            user_tags.remove(at: user_tags.firstIndex(of: tag_id)!)
            UserDefaults.standard.setValuesForKeys([USER_TAGS_KEY: user_tags])
            UserDefaults.standard.synchronize()
        } else {
            // remove tag in DB
            print("to remove tag:\(tag_id)")
            remove_user_tag_from_DB(tag_id:tag_id)
        }
    }
    
    static func get_user_tags(user_name:String?) -> [Int]? {
        if(user_name == nil) {
            return UserDefaults.standard.array(forKey: USER_TAGS_KEY) as? [Int]
        } else {
            // get tags from DB
            var user_tags = get_user_tags_from_DB(user_name: user_name!)
            return user_tags
        }
    }
}
