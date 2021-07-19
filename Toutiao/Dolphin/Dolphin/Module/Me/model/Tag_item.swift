//
//  Tag_item.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/20.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

class Tag_item {
    static func get_all_tags(vc: UIViewController) -> [(Int,String)] {
        return get_all_tags_from_DB(vc:vc)
    }
    
    static func add_tag(vc: UIViewController, tag_id: Int) -> Bool {
        var ret = false
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
            ret = true
        } else {
            // add tags to DB
            print("to add tag:\(tag_id)")
            if (!check_network_available()) {
                vc.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
            } else {
                ret = add_user_tag_to_DB(tag_id: tag_id)
            }
        }
        //Tag_selection_VC.user_tags.append(tag_id)
        print("add tag ret:\(ret)")
        return ret
    }
    
    static func remove_user_tag(vc: UIViewController, tag_id:Int) -> Bool {
        var ret = false
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
            ret = true
        } else {
            // remove tag in DB
            print("to remove tag:\(tag_id)")
            if (!check_network_available()) {
                vc.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
            } else {
                ret = remove_user_tag_from_DB(tag_id:tag_id)
            }
        }
        //Tag_selection_VC.user_tags.remove(at: Tag_selection_VC.user_tags.firstIndex(of: tag_id)!)
        print("remove tag ret:\(ret)")
        return ret
    }
    
    static func get_user_tags() -> [Int] {
        if(!User.is_logined()) {
            let tmp_default_tags = UserDefaults.standard.array(forKey: USER_TAGS_KEY)
            if tmp_default_tags != nil {
                return tmp_default_tags as! [Int]
            } else {
                return []
            }
        } else {
            // get tags from DB
            var user_tags = get_user_tags_from_DB()
            return user_tags
        }
    }
}
