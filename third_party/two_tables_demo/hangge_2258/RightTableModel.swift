//
//  TableModel.swift
//  hangge_2258
//
//  Created by hangge on 2019/1/8.
//  Copyright © 2019年 hangge. All rights reserved.
//

import UIKit

//右侧表格数据模型（分类下的商品）
class RightTableModel: NSObject {
    
    //商品名称
    var name : String
    //商品图片
    var picture : String
    //商品价格
    var price : Float
    
    init(name: String, picture: String, price: Float) {
        self.name = name
        self.picture = picture
        self.price = price
    }
}

