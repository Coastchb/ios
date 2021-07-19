//
//  RecommendVC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/8.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import WebKit

class Tutorial_text: UITableViewController {
    var item_type = "tutorial_text"
    
    var all_tutorials = [(Int, String, String, String, String, String)]()
    var viewed_tutorial_id = [Int]()
    
    static var to_update = false
    var latest_time = ""
    static var next_more_page = 1
    static var no_more = false
    
    var user_tags = [Int]()
    
    func down_refresh_complete_handle(tutorials: [(Int, String, String, String, String, String)]) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            print("下拉刷新")
            self.tableView.mj_header?.endRefreshing()
            
            if(tutorials.count != 0) {
                self.all_tutorials = tutorials
                self.update_latest_time(tutorials: self.all_tutorials)
            }
            //self.all_tutorials.insert(contentsOf: tutorials,at: 0)
            self.tableView.reloadData()
            if self.tableView.mj_header!.isRefreshing { self.tableView.mj_header!.endRefreshing() }
            self.tableView.mj_footer!.resetNoMoreData()
            self.tableView.mj_header!.pullingPercent = 0.0
        })
    }
    
    func up_refresh_complete_handle(tutorials: [(Int, String, String, String, String, String)]) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            print("上拉刷新")
            self.tableView.mj_footer?.endRefreshing()
            self.all_tutorials += tutorials
            self.tableView.reloadData()
            if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_header!.endRefreshing() }
            self.tableView.mj_footer!.pullingPercent = 0.0
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.user_tags = Tag_item.get_user_tags()
        
        if(self.user_tags.count == 0) {
            let alert_vc = UIAlertController(title: "", message: "您还没有选择标签", preferredStyle: .alert)
            let cancel_action = UIAlertAction(title: "暂不设置", style: .cancel, handler: nil)
            let set_action = UIAlertAction(title: "去设置", style: .destructive, handler: {action in
                let tags_vc = UIStoryboard(name: "Toutiao", bundle: nil).instantiateViewController(withIdentifier: "tagsSelectionViewController")
                if let vc = tags_vc as? Tag_selection_VC {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            alert_vc.addAction(cancel_action)
            alert_vc.addAction(set_action)
            self.present(alert_vc, animated: true, completion: nil)
        } else {
            all_tutorials = init_tutorials_with_cache(vc: self)!
        }

        update_latest_time(tutorials: all_tutorials)
        
        tableView.register(UINib(nibName: "Tutorial_text_cell", bundle: nil), forCellReuseIdentifier: "tutorial_text_cell")

        // 顶部刷新控件
        tableView.mj_header = RefreshAutoGifHeader(refreshingBlock: { [weak self] in
            // 获取更新资讯
            //var to_refresh_time = currentTime("YYYY-MM-dd HH:mm:ss")
            get_all_tutorials(vc:self, load_type: "refresh",latest_time: self!.latest_time , page_no: 1, complete_handle: self?.down_refresh_complete_handle)
            //self!.refresed_time = to_refresh_time
        })
        tableView.mj_header?.isAutomaticallyChangeAlpha = true
        
        // 底部刷新控件
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
               // 获取资讯列表数据，加载更多
            if(Tutorial_text.no_more) {
                self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                get_all_tutorials(vc: self, load_type: "more", latest_time: self!.latest_time, page_no: Tutorial_text.next_more_page, complete_handle: self?.up_refresh_complete_handle)
            }
           })
        tableView.mj_footer?.isAutomaticallyChangeAlpha = true
        
        self.tableView.mj_header?.beginRefreshing()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("all_tutorials.count:\(all_tutorials.count)")
        return all_tutorials.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tutorial_text_cell", for: indexPath)

        if let cell = tableCell as? Tutorial_text_cell {
            //print("ok 0")
            //print("feed row at:\(indexPath.row)")
            // remove (recommend_num, star_num, thanks_num) fields from tutorial table
            let (id, tag, title, source, link, _) = all_tutorials[indexPath.row]

            //print("\(viewed_tutorial_id.index(after: id))")
            //print("\(viewed_tutorial_id)")
            if (viewed_tutorial_id.lastIndex(of: id) != nil) {
                cell.tutorialTitleLabel.textColor = .gray
            }
            cell.item_type = item_type
            cell.item_id = id
            cell.tutorialTitleLabel.text = title
            cell.sourceLabel.text = "\(source)"
            cell.tagLabel.text = tag
            cell.icon_image.image = get_website_logo(link: link) //UIImage(imageLiteralResourceName: "runoob")
            cell.timeLabel.isHidden = true
            
            var recommendation_total_num = 0
            var recommended = false
            var stared = false
            var thanked = false
            
            if (!SERVER_CRASHED) {
                let recommendation_info = get_related_info(info_type: "recommendation", item_type: item_type, item_id: id, user_id: User.get_user_id() ?? "-1")
                if(recommendation_info.0 != -1) {
                    let star_info = get_related_info(info_type: "star", item_type: item_type, item_id: id, user_id: User.get_user_id() ?? "-1")
                    let thanks_info = get_related_info(info_type: "thanks", item_type: item_type, item_id: id, user_id: User.get_user_id() ?? "-1")
                    
                    recommendation_total_num = recommendation_info.0
                    recommended = (recommendation_info.1 >= 1)
                    stared = (star_info.1 >= 1)
                    thanked = (thanks_info.1 >= 1)
                } else {
                    SERVER_CRASHED = true
                }
            }

            
            cell.recommend_num = recommendation_total_num
            cell.recommended = recommended
            cell.stared = stared
            cell.thanked = thanked
            
            cell.selectionStyle = .none
            return cell
        } else {
            print("not ok")
        }
        //reloadInputViews()
        return tableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var tutorial_detail = all_tutorials[indexPath.row]
        print("\(tutorial_detail.4)")
        var detail_vc = webVC()
        detail_vc.hidesBottomBarWhenPushed = true
        detail_vc.url_string = tutorial_detail.4
        self.navigationController?.pushViewController(detail_vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        if(Tutorial_text.to_update) {
            Tutorial_text.next_more_page = 1
            Tutorial_text.no_more = false
            self.user_tags = Tag_item.get_user_tags()
            self.tableView.mj_header?.beginRefreshing()
            tableView.reloadData()
            Tutorial_text.to_update = false
            
            // 底部刷新控件
            tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
                   // 获取资讯列表数据，加载更多
                if(Tutorial_text.no_more) {
                    self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    get_all_tutorials(vc:self, load_type: "more", latest_time: self!.latest_time, page_no: Tutorial_text.next_more_page, complete_handle: self?.up_refresh_complete_handle)
                }
               })
            tableView.mj_footer?.isAutomaticallyChangeAlpha = true
        }
        /*
        if(all_tutorials.count == 0) {
            let alter_vc = UIAlertController(title: "请设置您的标签", message: "", preferredStyle: .alert)
            let cancel_action = UIAlertAction(title: "暂不设置", style: .cancel, handler: nil)
            let add_action = UIAlertAction(title: "去设置", style: .destructive, handler: {action in
                let tags_vc = UIStoryboard(name: "Toutiao", bundle: nil).instantiateViewController(withIdentifier: "tagsSelectionViewController")
                
                if let vc = tags_vc as? tagSelectionViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            alter_vc.addAction(cancel_action)
            alter_vc.addAction(add_action)
            self.present(alter_vc, animated: true)
        }*/
    }
        
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.showsVerticalScrollIndicator = true
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tableView.showsVerticalScrollIndicator = false
    }

    
    func update_latest_time(tutorials:[(Int, String, String, String, String, String)]? ) {
        if (tutorials != nil) && (tutorials!.count != 0) {
            self.latest_time = (tutorials?.first!.5)!
        } else {
            self.latest_time = currentTime("YYYY-MM-dd HH:mm:ss")
        }
        
    }
    
}
