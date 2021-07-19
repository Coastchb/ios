//
//  Users.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//
import StORM
import MySQLStORM
import Foundation

class Users : MySQLStORM {
    var user_id : Int = 0
    var name : String = ""
    var passwd : String = ""
    var gender : String = ""
    var phone_num : String = ""
    var avatar_url : String = ""

    override open func table() -> String {
        return "user"
    }
    
    override func to(_ this: StORMRow) {
        self.user_id = Int(this.data["user_id"] as! Int32)
        self.name = this.data["name"] as! String
        self.passwd = this.data["passwd"] as! String
        self.gender = this.data["gender"] as! String
        self.phone_num = this.data["phone_num"] as! String
        self.avatar_url = this.data["avatar_url"] as! String
    }
    
    func rows() -> [Users] {
        var users = [Users]()
        for i in 0..<self.results.rows.count {
            let row = Users()
            row.to(self.results.rows[i])
            users.append(row)
            
        }
        return users
    }
}

