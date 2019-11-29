//
//  RecommendVC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/8.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class RecommendVC: UITableViewController {
    
    var viewed_news_id = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(all_news)
        tableView.register(UINib(nibName: "NewsListCell", bundle: nil), forCellReuseIdentifier: "newsListCell")
        
        // 顶部刷新控件
        tableView.mj_header = RefreshAutoGifHeader(refreshingBlock: { [weak self] in
            // 获取更新资讯
            /*DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                self!.tableView.reloadData()
                self!.tableView.mj_header?.endRefreshing()
            })*/
            
            var more = get_all()
            more.forEach { one in
                 self!.all_news.append(one)
             }
            if self!.tableView.mj_header.isRefreshing { self!.tableView.mj_header.endRefreshing() }
            self!.tableView.mj_header.pullingPercent = 0.0
            self!.tableView.reloadData()
            
        })
        tableView.mj_header?.isAutomaticallyChangeAlpha = true
        
        // 底部刷新控件
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
               // 获取资讯列表数据，加载更多
            
            /*
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    print("footer refreshing...")
                     var more = get_all()
                     more.forEach { one in
                         self!.all_news.append(one)
                     }
                    if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
                    self!.tableView.mj_footer.pullingPercent = 0.0
                     self!.tableView.reloadData()
                //self!.tableView.reloadData()
                //self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
            })*/
 
            var more = get_all()
            more.forEach { one in
                 self!.all_news.append(one)
             }
            if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
            self!.tableView.mj_footer.pullingPercent = 0.0
             self!.tableView.reloadData()
            //self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
           })
           tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("all_news.count:\(all_news.count)")
        return all_news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "newsListCell", for: indexPath)

        if let cell = tableCell as? Tutorial_text_cell {
            //print("ok 0")
            //print("feed row at:\(indexPath.row)")
            let (id, title, abstract, body) = all_news[indexPath.row]

            print("news_id:\(id)")
            //print("\(viewed_news_id.index(after: id))")
            //print("\(viewed_news_id)")
            if (viewed_news_id.lastIndex(of: id) != nil) {
                cell.newsTitleLabel.textColor = .gray
            }
            cell.newsTitleLabel.text = title
            cell.newsAbstractLabel.text = abstract
            //cell.newsPicture?.image = UIImage(imageLiteralResourceName: "news_pic\(indexPath.row)")
            
            /*
            // local image
            var cell_image = Image(imageLiteralResourceName: "news_pic\(indexPath.row)")
            let image_width = cell_image.size.width
            let image_height = cell_image.size.height
            let imageView_width = (cell.newsPicture?.bounds.width)!
            let imageView_height = (cell.newsPicture?.bounds.height)!
            let raw_ratio = image_width / image_height
            print("before scaling:\(cell_image.size)")
            if raw_ratio > (imageView_width / imageView_height) {
                print("\((image_height / imageView_height))")
                if (image_height > imageView_height) {
                    cell_image = cell_image.kf.scaled(to: (image_height / imageView_height))
                }
            } else {
                if (image_width > imageView_width){
                    cell_image = cell_image.kf.scaled(to: (image_width / imageView_width))
                }
            }
            print("after scaling:\(cell_image.size)")
            //image.kf.scaled(to: 0.5)
            cell.newsPicture?.image = cell_image
           */
            
            // remote image
            var cell_image = Image()
            let url = URL.init(string: "File:///Users/coastcao/Desktop/ios/Toutiao/Toutiao/resources/news/news_pic\(indexPath.row).png")
            cell.newsPicture?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil){
                image, error, cacheType, imageURL in
                cell_image = cell.newsPicture!.image!
                print(cell_image)

                let image_width = cell_image.size.width
                let image_height = cell_image.size.height
                let imageView_width = (cell.newsPicture?.bounds.width)!
                let imageView_height = (cell.newsPicture?.bounds.height)!
                let raw_ratio = image_width / image_height
                print("before scaling:\(cell_image.size)")
                if raw_ratio > (imageView_width / imageView_height) {
                    print("\((image_height / imageView_height))")
                    if (image_height > imageView_height) {
                        cell_image = cell_image.kf.scaled(to: (image_height / imageView_height))
                    }
                } else {
                    if (image_width > imageView_width){
                        cell_image = cell_image.kf.scaled(to: (image_width / imageView_width))
                    }
                }
                print("after scaling:\(cell_image.size)")
                cell.newsPicture?.image = cell_image
            }

            //cell.selectionStyle = .none
            return cell
        } else {
            print("not ok")
        }
        //reloadInputViews()
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsViewController()
        var news_id : Int
        (news_id,_,_,_) = all_news[indexPath.row]
        vc.news_id = news_id
        navigationController?.pushViewController(vc, animated: true)
        viewed_news_id.append(all_news[indexPath.row].0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
        
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.showsVerticalScrollIndicator = true
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tableView.showsVerticalScrollIndicator = false
    }

    var all_news = get_all()
}
