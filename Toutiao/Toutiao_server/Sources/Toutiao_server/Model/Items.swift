//
//  News.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//
import StORM
import MySQLStORM
import Foundation

class Tutorial_text : MySQLStORM {
    var id : Int = 0
    var tag : String = ""
    var source : String = ""
    var link : String = ""
    var title : String = ""
    var published_date : String = ""
    
    override open func table() -> String {
        return "tutorials_text"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.tag = this.data["tag"] as! String
        self.source = this.data["source"] as! String
        self.link = this.data["link"] as! String
        self.title = this.data["title"] as! String
        self.published_date = this.data["published_date"] as! String
    }
    
    func rows() -> [Tutorial_text] {
        var tutorials = [Tutorial_text]()
        for i in 0..<self.results.rows.count {
            let row = Tutorial_text()
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
    var published_date : String = "" //Date = Date()
     
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
         self.published_date = this.data["published_date"] as! String
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
     var recommend_num : Int = 0
     var title : String = ""
    var published_date : String = "" //Date = Date()
    var star_num : Int = 0
    var thanks_num : Int = 0
     
     override open func table() -> String {
         return "videos"
     }
     
     override func to(_ this: StORMRow) {
         self.id = Int(this.data["id"] as! Int32)
         self.tag = this.data["tag"] as! String
         self.abstract = this.data["abstract"] as! String
         self.link = this.data["link"] as! String
         self.recommend_num = Int(this.data["recommend_num"] as! Int32)
         self.title = this.data["title"] as! String
        self.published_date = this.data["published_date"] as! String
        self.star_num = Int(this.data["star_num"] as! Int32)
        self.thanks_num = Int(this.data["thanks_num"] as! Int32)
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
    var user_id : Int = -1
    var item_type : String = ""
    var item_id : Int = -1
    var stared_date : String = ""
    
    override open func table() -> String {
        return "stared_items"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.user_id = Int(this.data["user_id"] as! Int32)
        self.item_type = this.data["item_type"] as! String
        self.item_id = Int(this.data["item_id"] as! Int32)
        self.stared_date = this.data["stared_date"] as! String
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

class Stared_item_info {
     var id : Int = -1
     var item_type : String = ""
     var item_id : Int = -1
     var stared_date : String = ""
     var item_title : String = ""
     var item_tag : String = ""
     var source : String = ""
     var link : String = ""
    
    init(id:Int, item_type:String, item_id:Int, stared_date:String, item_tag:String, item_title:String, source:String, link:String) {
        self.id = id
        self.item_id = item_id
        self.item_type = item_type
        self.stared_date = stared_date
        self.item_tag = item_tag
        self.item_title = item_title
        self.source = source
        self.link = link
    }
}

class Recommended_items : MySQLStORM {
    var id : Int = -1
    var item_type : String = ""
    var item_id : Int = -1
    var user_id : Int = -1
    
    override open func table() -> String {
        return "recommended_items"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.user_id = Int(this.data["user_id"] as! Int32)
        self.item_type = this.data["item_type"] as! String
        self.item_id = Int(this.data["item_id"] as! Int32)
    }
    
    func rows() -> [Recommended_items] {
        var items = [Recommended_items]()
        for i in 0..<self.results.rows.count {
            let row = Recommended_items()
            row.to(self.results.rows[i])
            items.append(row)
        }
        return items
    }
}

class Thank_publisher : MySQLStORM {
    var id : Int = -1
    var item_type : String = ""
    var item_id : Int = -1
    var user_id : Int = -1
    
    override open func table() -> String {
        return "thank_publisher"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.user_id = Int(this.data["user_id"] as! Int32)
        self.item_type = this.data["item_type"] as! String
        self.item_id = Int(this.data["item_id"] as! Int32)
    }
    
    func rows() -> [Thank_publisher] {
        var items = [Thank_publisher]()
        for i in 0..<self.results.rows.count {
            let row = Thank_publisher()
            row.to(self.results.rows[i])
            items.append(row)
        }
        return items
    }
}

class Tutorials_text_publisher : MySQLStORM {
    var id : Int = -1
    var item_type : String = ""
    var item_id : Int = -1
    var publisher_id : Int = -1
    
    override open func table() -> String {
        return "tutorials_text_publisher"
    }
    
    override func to(_ this: StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.publisher_id = Int(this.data["publisher_id"] as! Int32)
        self.item_type = this.data["item_type"] as! String
        self.item_id = Int(this.data["item_id"] as! Int32)
    }
    
    func rows() -> [Tutorials_text_publisher] {
        var items = [Tutorials_text_publisher]()
        for i in 0..<self.results.rows.count {
            let row = Tutorials_text_publisher()
            row.to(self.results.rows[i])
            items.append(row)
        }
        return items
    }
}


class User_added_tutorial : MySQLStORM {
    var id : Int = 0
    var tutorial_name : String = ""
    var tutorial_url : String = ""
    var tutorial_descrip : String = ""
    var user_id : Int = -1
    
    override open func table() -> String {
        return "user_added_tutorials"
    }
    
    override func to(_ this : StORMRow) {
        self.id = Int(this.data["id"] as! Int32)
        self.tutorial_name = this.data["tutorial_name"] as! String
        self.tutorial_url = this.data["tutorial_url"] as! String
        self.tutorial_descrip = this.data["tutorial_descrip"] as! String
        self.user_id = Int(this.data["user_id"] as! Int32)
    }
    
    func rows() -> [User_added_tutorial] {
        var tutorials = [User_added_tutorial]()
        for i in 0..<self.results.rows.count {
            let row = User_added_tutorial()
            row.to(self.results.rows[i])
            tutorials.append(row)
        }
        return tutorials
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
