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

class News_2 : MySQLStORM {
    var id : Int = 0
    var title : String = ""
    var abstract : String = ""
    var body : String = ""
    
    override open func table() -> String {
        return "news_2"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.title = this.data["title"] as! String
        self.abstract = this.data["abstract"] as! String
        self.body = this.data["body"] as! String
    }
    
    func rows() -> [News_2] {
        var news = [News_2]()
        for i in 0..<self.results.rows.count {
            let row = News_2()
            row.to(self.results.rows[i])
            news.append(row)
            
        }
        return news
    }
}

class News_3 : MySQLStORM {
    var id : Int = 0
    var title : String = ""
    var abstract : String = ""
    var body : String = ""
    
    override open func table() -> String {
        return "news_3"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.title = this.data["title"] as! String
        self.abstract = this.data["abstract"] as! String
        self.body = this.data["body"] as! String
    }
    
    func rows() -> [News_3] {
        var news = [News_3]()
        for i in 0..<self.results.rows.count {
            let row = News_3()
            row.to(self.results.rows[i])
            news.append(row)
            
        }
        return news
    }
}

