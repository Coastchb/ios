//
//  InfoViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/25.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var item_type = "blog"
    
    var all_blogs = [(Int, String, String, String, String, Int, String)]()
    var viewed_tutorial_id = [Int]()
        
    static var to_update = false
    var latest_time = ""
    static var next_more_page = 1
    static var no_more = false
    
    var user_tags = [Int]()

    @IBOutlet weak var tableView: UITableView!
    
    func down_refresh_complete_handle(blogs: [(Int, String, String, String, String, Int, String)]) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            print("下拉刷新")
            self.tableView.mj_header?.endRefreshing()

            if(blogs.count != 0) {
                //var new_blogs = self.remove_duplicated_blogs(new_blogs: blogs, old_blogs: self.all_blogs)
                //self.all_blogs.insert(contentsOf: new_blogs,at: 0)
                self.all_blogs = blogs
                self.update_latest_time(blogs: self.all_blogs)
            }
            self.tableView.reloadData()
            if self.tableView.mj_header!.isRefreshing { self.tableView.mj_header!.endRefreshing() }
            self.tableView.mj_footer!.resetNoMoreData()
            self.tableView.mj_header!.pullingPercent = 0.0
          })
      }
      
      func up_refresh_complete_handle(blogs: [(Int, String, String, String, String, Int, String)]) {
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
              print("上拉刷新")
              self.tableView.mj_footer?.endRefreshing()
              self.all_blogs += blogs
              self.tableView.reloadData()
              if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_footer!.endRefreshing() }
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
            all_blogs = init_blogs_with_cache(vc: self)!
        }
        update_latest_time(blogs: all_blogs)
        print("latest_time:\(latest_time)")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.title = "最新动态"
        
        tableView.register(UINib(nibName: "Info_cell", bundle: nil), forCellReuseIdentifier: "info_cell")
        
        // 顶部刷新控件
        tableView.mj_header = RefreshAutoGifHeader(refreshingBlock: { [weak self] in
            // 获取更新资讯
            get_all_blogs(vc: self, load_type: "refresh", latest_time: self!.latest_time, page_no: 1, complete_handle: self?.down_refresh_complete_handle)
        })
        tableView.mj_header?.isAutomaticallyChangeAlpha = true
        
        // 底部刷新控件
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
            // 获取资讯列表数据，加载更多
            if(InfoViewController.no_more) {
                self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                get_all_blogs(vc: self, load_type: "more", latest_time:self!.latest_time, page_no: InfoViewController.next_more_page, complete_handle: self?.up_refresh_complete_handle)
            }
        })
        tableView.mj_footer!.isAutomaticallyChangeAlpha = true
        
        self.tableView.mj_header?.beginRefreshing()
    }

       // MARK: - Table view data source

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           //print("all_tutorials.count:\(all_tutorials.count)")
           return all_blogs.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let tableCell = tableView.dequeueReusableCell(withIdentifier: "info_cell", for: indexPath)

           if let cell = tableCell as? Info_cell {
               //print("ok 0")
               //print("feed row at:\(indexPath.row)")
               let (id, tag, title, abstract, link, score, published_date) = all_blogs[indexPath.row]

               //print("\(viewed_tutorial_id.index(after: id))")
               //print("\(viewed_tutorial_id)")
               if (viewed_tutorial_id.lastIndex(of: id) != nil) {
                   cell.newsTitleLabel.textColor = .gray
               }
            cell.item_type = item_type
            cell.item_id = id
            cell.newsTitleLabel.text = title
            cell.newsAbstractLabel.text = abstract
            cell.tagLabel.text = tag
            cell.timeLabel.text = convert_date(published_date,"yyyy-MM-dd HH:mm:ss") //"2020/1/24"
            
            var stared = false
            
            if(!SERVER_CRASHED) {
                var star_info = get_related_info(info_type: "star",item_type: item_type, item_id: id, user_id: User.get_user_id() ?? "-1")
                if(star_info.0 != -1) {
                    stared = (star_info.1 >= 1)
                } else {
                    SERVER_CRASHED = true
                }
            }

            cell.stared = stared
            cell.icon_image.image = get_website_logo(link: link)//UIImage(imageLiteralResourceName: "SegmentFault")

            
            cell.selectionStyle = .none
            
            return cell
           } else {
               print("not ok")
           }
           //reloadInputViews()
           return tableCell
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           var blog_detail = all_blogs[indexPath.row]
           print("\(blog_detail.4)")
           var detail_vc = webVC()
           detail_vc.url_string = blog_detail.4
           detail_vc.hidesBottomBarWhenPushed = true
           self.navigationController?.pushViewController(detail_vc, animated: true)
           
       }
       
    override func viewWillAppear(_ animated: Bool) {
        print("InfoViewController.to_update:\(InfoViewController.to_update)")
        if (InfoViewController.to_update) {
            InfoViewController.next_more_page = 1
            InfoViewController.no_more = false
            self.user_tags = Tag_item.get_user_tags()
            print("user_tags:\(self.user_tags)")
            self.tableView.mj_header?.beginRefreshing()
            tableView.reloadData()
            InfoViewController.to_update = false
            
            // 底部刷新控件
            tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
                     // 获取资讯列表数据，加载更多
                   if(InfoViewController.no_more) {
                       self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
                   } else {
                    get_all_blogs(vc: self, load_type: "more", latest_time: self!.latest_time, page_no: InfoViewController.next_more_page, complete_handle: self?.up_refresh_complete_handle)
                   }
               })
             tableView.mj_footer!.isAutomaticallyChangeAlpha = true
        }
       }
           
       func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           tableView.showsVerticalScrollIndicator = true
       }
       
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           tableView.showsVerticalScrollIndicator = false
       }
    
    func remove_duplicated_blogs(new_blogs: [(Int, String, String, String, String, Int, String)], old_blogs: [(Int, String, String, String, String, Int, String)]) -> [(Int, String, String, String, String, Int, String)] {
        return new_blogs.filter( { new_blog -> Bool in
            return !(old_blogs.contains(where: { old_blog -> Bool in
                new_blog.0 == old_blog.0
            }))
        })
    }
    
    func update_latest_time(blogs:[(Int, String, String, String, String, Int, String)]? ) {
        if (blogs != nil) && (blogs!.count != 0) {
            self.latest_time = (blogs?.first!.6)!
        } else {
            self.latest_time = currentTime("YYYY-MM-dd HH:mm:ss")
        }
        
    }

}


