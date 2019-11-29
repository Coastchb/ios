//
//  Cotent_item.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/19.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

class Stared_item : Equatable { // NSObject, NSCoding {
    static let `default` = Stared_item()
    
    var id : Int = -1
    var content_type : String = ""
    
    static func == (lhs: Stared_item, rhs: Stared_item) -> Bool {
        return (lhs.content_type == rhs.content_type) && (lhs.id == rhs.id)
    }
    
    static func add_stared_item(type: String, id: Int) -> Bool {
        // not logged in
        if(!User.is_logined()) {
            var existed_types = [String]()
            var existed_ids = [Int]()
            
            if let stared_types =  UserDefaults.standard.array(forKey: STARED_TYPE_KEY) as? [String], let stared_ids = UserDefaults.standard.array(forKey: STARED_ID_KEY) as? [Int] {
                for (_type,_id) in zip(stared_types, stared_ids) {
                    print("\(type)--\(_type)")
                    print("\(id) -- \(_id)")
                    if(type == _type && id == _id) {
                        return true
                    }
                    existed_types.append(_type)
                    existed_ids.append(_id)
                }
            }
            existed_types.append(type)
            existed_ids.append(id)
            UserDefaults.standard.setValue(existed_types, forKey: STARED_TYPE_KEY)
            UserDefaults.standard.setValue(existed_ids, forKey: STARED_ID_KEY)
            UserDefaults.standard.synchronize()
        } else {
            // logged in (add to DB)
            if(!add_stared_item_to_DB(item_type:type, item_id:id)) {
                return false
            }
        }
        return true
    }
    
    static func get_all_stared_items() -> [(String,Int)] {
        var ret = [(String, Int)]()
        print("in get_all()")
        
        // not logged in
        if(!User.is_logined()) {
            if let stared_types =  UserDefaults.standard.array(forKey: STARED_TYPE_KEY) as? [String], let stared_ids = UserDefaults.standard.array(forKey: STARED_ID_KEY) as? [Int] {
                print("\(stared_types);\(stared_ids)")
                for (_type,_id) in zip(stared_types, stared_ids) {
                    ret.append((_type,_id))
                }
            }
        } else {
            // logged in (get from DB)
            if let user_name = User.get_user_name() {
                ret = get_stared_items_from_DB(user_name: user_name)
            }
        }
        return ret
    }
    
    static func remove_stared_item(type:String, id:Int) -> Bool{
        print("in remove started item")
        
        // not logged in
            if(!User.is_logined()) {
               var existed_types = [String]()
                var existed_ids = [Int]()
                
                if let stared_types =  UserDefaults.standard.array(forKey: STARED_TYPE_KEY) as? [String], let stared_ids = UserDefaults.standard.array(forKey: STARED_ID_KEY) as? [Int] {
                    for (_type,_id) in zip(stared_types, stared_ids) {
                        print("\(type)--\(_type)")
                        print("\(id) -- \(_id)")
                        existed_types.append(_type)
                        existed_ids.append(_id)
                    }
                }
                existed_types.remove(at: existed_types.firstIndex(of: type)!)
                existed_ids.remove(at: existed_ids.firstIndex(of: id)!)
                UserDefaults.standard.setValue(existed_types, forKey: STARED_TYPE_KEY)
                UserDefaults.standard.setValue(existed_ids, forKey: STARED_ID_KEY)
                UserDefaults.standard.synchronize()
            } else {
                // logged in (add to DB)
                if(!remove_stared_item_from_DB(item_type: type, item_id: id)) {
                    return false
                }
            }
        return true
    }
    
    init(type: String, id:Int) {
        self.content_type = type
        self.id = id
    }
    
    init() {
        
    }
    
    /*
    struct PropertyKey {
        static let typeKey = "content_type"
        static let idKey = "id"
        static let tagKey = "tag"
        static let titleKey = "title"
        static let abstractKey = "abstract"
        static let linkKey = "link"
        static let scoreKey = "score"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(content_type, forKey:PropertyKey.typeKey)
        coder.encode(id, forKey:PropertyKey.idKey)
        coder.encode(tag, forKey: PropertyKey.tagKey)
        coder.encode(title, forKey: PropertyKey.titleKey)
        coder.encode(abstract, forKey: PropertyKey.abstractKey)
        coder.encode(link, forKey: PropertyKey.linkKey)
        coder.encode(score, forKey: PropertyKey.scoreKey)
    }
    
    
    required init?(coder: NSCoder) {
        content_type = coder.decodeObject(forKey: PropertyKey.typeKey) as! String
        print("\(content_type)")
        print("\(coder.decodeObject(forKey: PropertyKey.idKey))")
        //id = coder.decodeObject(forKey: PropertyKey.idKey) as! String as! Int
        tag = coder.decodeObject(forKey: PropertyKey.tagKey) as! String
        title = coder.decodeObject(forKey: PropertyKey.titleKey) as! String
        abstract = coder.decodeObject(forKey: PropertyKey.abstractKey) as! String
        link = coder.decodeObject(forKey: PropertyKey.linkKey) as! String
        score = coder.decodeObject(forKey: PropertyKey.scoreKey) as! Int
    }
    
    static func == (lhs: Content_item, rhs: Content_item) -> Bool {
        return (lhs.content_type == rhs.content_type) && (lhs.id == rhs.id) && (lhs.tag == rhs.tag) && (lhs.title == rhs.title)
            && (lhs.link == rhs.link) && (lhs.abstract == rhs.abstract) && (lhs.score == rhs.score)
    }
    
    var content_type = ""
    var id = -1
    var tag = ""
    var title = ""
    var abstract = ""
    var link = ""
    var score = -1
    
    init(json: NSDictionary) { // Dictionary object
         self.content_type = json["content_type"] as! String
         self.id = json["id"] as! Int
        self.tag = json["tag"] as! String
         self.title = json["title"] as! String
        self.abstract = json["abstract"] as! String
        self.link = json["link"] as! String
        self.score = json["score"] as! Int
     }
    
    init(type: String, id:Int, tag: String, title: String, abstract: String, link: String, score: Int) {
        self.content_type = type
        self.id = id
        self.tag = tag
        self.title = title
        self.abstract = abstract
        self.link = link
        self.score = score
    }*/
}
