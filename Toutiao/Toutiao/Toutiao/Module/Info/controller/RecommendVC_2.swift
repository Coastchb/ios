//
//  RecommendVC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/8.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class RecommendVC_2: UITableViewController {
    
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
            
            var more = get_all_2()
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
 
            var more = get_all_2()
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

        if let cell = tableCell as? NewsListCell {
            //print("ok 0")
            //print("feed row at:\(indexPath.row)")
            let (id, title, abstract, body) = all_news[indexPath.row]

            //print("\(viewed_news_id.index(after: id))")
            //print("\(viewed_news_id)")
            if (viewed_news_id.lastIndex(of: id) != nil) {
                cell.newsTitleLabel.textColor = .gray
            }
            cell.newsTitleLabel.text = title
            cell.newsAbstractLabel.text = abstract
            cell.newsPicture?.image = UIImage(imageLiteralResourceName: "news1_pic_\(id)")
            cell.newsPicture?.contentMode = .scaleAspectFit
            //cell.newsAbstractInCell?.text = abstract
            //print("ok 1")
            
            //cell.selectionStyle = .none
            return cell
        } else {
            print("not ok")
        }
        //reloadInputViews()
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsViewController_2()
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

    var all_news = get_all_2()
}
