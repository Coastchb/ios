//
//  NewsCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/8.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class NewsListCell : UITableViewCell {
    
    //@IBOutlet weak
    var newsTitleInCell : UILabel?
    
    //@IBOutlet weak
    var newsAbstractInCell :  UILabel?
    
    //@IBOutlet weak
    var newsPictureInCell :  UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        print("cell initialized")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.newsTitleInCell = UILabel(frame: CGRect(x: 10.0, y: 10.0, width: 500, height: 10))
        self.newsTitleInCell?.font = UIFont.boldSystemFont(ofSize: 20)
        self.newsTitleInCell?.textColor = UIColor.blue
        self.newsAbstractInCell = UILabel(frame: CGRect(x: 10.0, y: 30.0, width: 500, height: 90))
        self.newsAbstractInCell?.font = UIFont.systemFont(ofSize: 16)
        self.newsPictureInCell = UILabel(frame: CGRect(x: 20.0, y: 50.0, width: 500, height: 10))
        
        self.contentView.addSubview(self.newsTitleInCell!)
        self.contentView.addSubview(self.newsAbstractInCell!)
        self.contentView.addSubview(self.newsPictureInCell!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
