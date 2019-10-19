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
    var name : String = ""
    var passwd : String = ""

    override open func table() -> String {
        return "user"
    }
    
    override func to(_ this: StORMRow) {
        self.name = this.data["name"] as! String
        self.passwd = this.data["passwd"] as! String
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

