//
//  refreshView.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/9.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

//import MJRefresh

class RefreshAutoGifHeader: MJRefreshGifHeader{
     /// 初始化
        override func prepare() {
            super.prepare()
            // 图片数组
            var images = [UIImage]()
            // 遍历
            for index in 1..<4 {
                let image = UIImage(named: "dropdown_loading_0\(index)")
                images.append(image!)
            }
            // 设置空闲状态的图片
            setImages(images, for: .idle)
            // 设置刷新状态的图片
            setImages(images, for: .refreshing)
            setTitle("下拉推荐", for: .idle)
            setTitle("松开推荐", for: .pulling)
            setTitle("推荐中", for: .refreshing)
            self.lastUpdatedTimeLabel!.isHidden = true
        }
        
        override func placeSubviews() {
            super.placeSubviews()
            gifView!.contentMode = .center
            gifView!.frame = CGRect(x: 0, y: 4, width: mj_w, height: 25)
            stateLabel!.font = UIFont.systemFont(ofSize: 12)
            stateLabel!.frame = CGRect(x: 0, y: 35, width: mj_w, height: 14)
        }
        
}

    class RefreshAutoGifFooter: MJRefreshAutoGifFooter {
        
        /// 初始化
        override func prepare() {
            super.prepare()
            // 设置控件的高度
            mj_h = 50
            // 图片数组
            var images = [UIImage]()
            // 遍历
            for index in 1..<4 {
                let image = UIImage(named: "dropdown_loading_0\(index)")
                images.append(image!)
            }
            // 设置空闲状态的图片
            setImages(images, for: .idle)
            // 设置刷新状态的图片
            setImages(images, for: .refreshing)
            setTitle("上拉加载数据", for: .idle)
            setTitle("正在努力加载", for: .pulling)
            setTitle("正在努力加载", for: .refreshing)
            setTitle("没有更多数据啦", for: .noMoreData)
        }
        
        override func placeSubviews() {
            super.placeSubviews()
            //gifView.x = 135
            //gifView.centerY = stateLabel.centerY
        }
        
}
