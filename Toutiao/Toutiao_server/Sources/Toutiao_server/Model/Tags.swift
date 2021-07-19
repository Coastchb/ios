//
//  tags.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/11/24.
//

import StORM
import Foundation
import MySQLStORM

class Tags : MySQLStORM{
    var tag_id : Int = 0
    var tag_name : String = ""
    
    override open func table() -> String {
        return "tags"
    }
    
    override func to(_ this: StORMRow) {
        self.tag_id = Int(this.data["tag_id"] as! Int32)
        self.tag_name = this.data["tag_name"] as! String
    }
    
    func rows() -> [Tags] {
        var tags = [Tags]()
        for i in 0..<self.results.rows.count {
            let row = Tags()
            row.to(self.results.rows[i])
            tags.append(row)
        }
        return tags
    }
}

class User_tags : MySQLStORM{
    var id : Int = 0
    var tag_id : Int = 0
    var user_id : Int = 0
    
    override open func table() -> String {
        return "user_tags"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.tag_id = Int(this.data["tag_id"] as! Int32)
        self.user_id = Int(this.data["user_id"] as! Int32)
    }
    
    func rows() -> [User_tags] {
        var user_tags = [User_tags]()
        for i in 0..<self.results.rows.count {
            let row = User_tags()
            row.to(self.results.rows[i])
            user_tags.append(row)
        }
        return user_tags
    }
}

class User_added_tags : MySQLStORM{
    var id : Int = 0
    var user_id : Int = 0
    var tag_name : String = ""
    var tag_fullname : String = ""
    var tag_descrip : String = ""
    
    override open func table() -> String {
        return "user_added_tags"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.user_id = Int(this.data["user_id"] as! Int32)
        self.tag_name = this.data["tag_name"] as! String
        self.tag_fullname = this.data["tag_fullname"] as! String
        self.tag_descrip = this.data["tag_descrip"] as! String
    }
    
    func rows() -> [User_added_tags] {
        var tags = [User_added_tags]()
        for i in 0..<self.results.rows.count {
            let row = User_added_tags()
            row.to(self.results.rows[i])
            tags.append(row)
        }
        return tags
    }
}
