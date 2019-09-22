//
//  User.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/20.
//

import StORM
import MySQLStORM

class User: MySQLStORM {
    var user_id : Int = 0
    var user_name : String = ""
    
    override open func table() -> String {
        return "users"
    }
    
    override func to(_ this: StORMRow) {
        //print("this.data[\"user_id\"]:\(this.data["user_id"])")
        user_id = Int(this.data["user_id"] as! Int32) // ?? 0
        //print("user_id:\(user_id)")
        user_name = this.data["user_name"] as? String ?? ""
    }
    
    func rows() -> [User] {
        var rows = [User]()
        for i in 0..<self.results.rows.count {
            let row = User()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        return rows
    }
}
