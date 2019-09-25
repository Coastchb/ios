//
//  News.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//
import StORM
import MySQLStORM
import Foundation

class News : MySQLStORM {
    var news_id : Int = 0
    var news_title : String = ""
    var news_abstract : String = ""
    var news_body : String = ""
    
    override open func table() -> String {
        return "news"
    }
    
    override func to(_ this: StORMRow) {
        self.news_id = Int(this.data["news_id"] as! Int32)
        self.news_title = this.data["news_title"] as! String
        self.news_abstract = this.data["news_abstract"] as! String
        self.news_body = this.data["news_body"] as! String
    }
    
    func rows() -> [News] {
        var news = [News]()
        for i in 0..<self.results.rows.count {
            let row = News()
            row.to(self.results.rows[i])
            news.append(row)
            
        }
        return news
    }
}
