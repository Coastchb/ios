//
//  Feedback_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/11/28.
//

import Foundation
import MySQLStORM

func write_feedback(user_id:String, content:String) -> Bool {
    print("write feedback to DB")
    let obj = FeedBacks()
    do {
        var target_id = 0
        
        try obj.findAll()
        var existed_ones = obj.rows()
        if (existed_ones.count > 0) {
            target_id = existed_ones.count
        }
        
        try obj.insert(cols: ["id","user_id","feedback"], params: [target_id, user_id,content ], idcolumn: "id")
    } catch {
        return false
    }
    
    return true
}
