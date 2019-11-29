//
//  News.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//
import StORM
import MySQLStORM
import Foundation

class Tutorial : MySQLStORM {
    var id : Int = 0
    var tag : String = ""
    var abstract : String = ""
    var link : String = ""
    var score : Int = 0
    var title : String = ""
    
    override open func table() -> String {
        return "tutorials"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.tag = this.data["tag"] as! String
        self.abstract = this.data["abstract"] as! String
        self.link = this.data["link"] as! String
        self.score = Int(this.data["score"] as! Int32)
        self.title = this.data["title"] as! String
    }
    
    func rows() -> [Tutorial] {
        var tutorials = [Tutorial]()
        for i in 0..<self.results.rows.count {
            let row = Tutorial()
            row.to(self.results.rows[i])
            tutorials.append(row)
        }
        return tutorials
    }
}

class Blog : MySQLStORM {
     var id : Int = 0
     var tag : String = ""
     var abstract : String = ""
     var link : String = ""
     var score : Int = 0
     var title : String = ""
     
     override open func table() -> String {
         return "blogs"
     }
     
     override func to(_ this: StORMRow) {
         self.id = Int(this.data["id"] as! Int32)
         self.tag = this.data["tag"] as! String
         self.abstract = this.data["abstract"] as! String
         self.link = this.data["link"] as! String
         self.score = Int(this.data["score"] as! Int32)
         self.title = this.data["title"] as! String
     }
     
     func rows() -> [Blog] {
         var blogs = [Blog]()
         for i in 0..<self.results.rows.count {
             let row = Blog()
             row.to(self.results.rows[i])
             blogs.append(row)
         }
         return blogs
     }
}

class Video : MySQLStORM {
     var id : Int = 0
     var tag : String = ""
     var abstract : String = ""
     var link : String = ""
     var score : Int = 0
     var title : String = ""
     
     override open func table() -> String {
         return "videos"
     }
     
     override func to(_ this: StORMRow) {
         self.id = Int(this.data["id"] as! Int32)
         self.tag = this.data["tag"] as! String
         self.abstract = this.data["abstract"] as! String
         self.link = this.data["link"] as! String
         self.score = Int(this.data["score"] as! Int32)
         self.title = this.data["title"] as! String
     }
     
     func rows() -> [Video] {
         var videos = [Video]()
         for i in 0..<self.results.rows.count {
             let row = Video()
             row.to(self.results.rows[i])
             videos.append(row)
         }
         return videos
     }
}

class Stared_items : MySQLStORM {
    var id : Int = -1
    var user_name : String = ""
    var item_type : String = ""
    var item_id : Int = -1
    
    override open func table() -> String {
        return "stared_items"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.user_name = this.data["user_name"] as! String
        self.item_type = this.data["item_type"] as! String
        self.item_id = Int(this.data["item_id"] as! Int32)
    }
    
    func rows() -> [Stared_items] {
        var items = [Stared_items]()
        for i in 0..<self.results.rows.count {
            let row = Stared_items()
            row.to(self.results.rows[i])
            items.append(row)
            
        }
        return items
    }
}



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
