//
//  RightTableViewCell.swift
//  hangge_2258
//
//  Created by hangge on 2019/1/8.
//  Copyright © 2019年 hangge. All rights reserved.
//

import UIKit

//右侧表格的自定义单元格
class RightTableViewCell: UITableViewCell {
    
    //标题文本标签
    var titleLabel = UILabel()
    //价格文本标签
    var priceLabel = UILabel()
    //产品图片视图
    var pictureView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        //初始化标题文本标签
        titleLabel.frame = CGRect(x: 80, y: 10, width: 200, height: 30)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.highlightedTextColor = .red
        contentView.addSubview(titleLabel)
        
        //初始化价格文本标签
        priceLabel.frame = CGRect(x: 80, y: 42, width: 200, height: 30)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor(232, 91, 77)
        contentView.addSubview(priceLabel)
        
        //初始化产品图片视图
        pictureView.frame = CGRect(x: 15, y: 15, width: 50, height: 50)
        contentView.addSubview(pictureView)
    }
    
    //设置数据
    func setData(_ model : RightTableModel) {
        titleLabel.text = model.name
        priceLabel.text = "￥\(model.price)"
        pictureView.image = UIImage(named: model.picture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
