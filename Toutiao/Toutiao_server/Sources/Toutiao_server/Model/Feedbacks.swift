//
//  Feedbacks.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/11/28.
//

import Foundation
import MySQLStORM
import StORM


class FeedBacks : MySQLStORM {
    var id : Int = 0
    var user_id : Int = -1
    var feedback : String = ""
    
    
    override open func table() -> String {
        return "feedbacks"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.user_id = Int(this.data["user_id"] as! Int32)
        self.feedback = this.data["feedback"] as! String
    }
    
    func rows() -> [FeedBacks] {
        var feedbacks = [FeedBacks]()
        for i in 0..<self.results.rows.count {
            let row = FeedBacks()
            row.to(self.results.rows[i])
            feedbacks.append(row)
        }
        return feedbacks
    }
}
