//
//  Tutorial_video.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/18.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Tutorial_video: UITableViewController {
    var all_vidoes = [(Int, String, String, String, String)]()
    var viewed_tutorial_id = [Int]()
    
    static var to_update = false
    var refresed_time = ""
    static var next_more_page = 1
    static var no_more = false
    
    func down_refresh_complete_handle(videos: [(Int, String, String, String, String)]) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            print("上拉刷新")
            self.tableView.mj_header?.endRefreshing()
            self.all_vidoes.insert(contentsOf: videos,at: 0)
            self.tableView.reloadData()
            if self.tableView.mj_header!.isRefreshing { self.tableView.mj_header!.endRefreshing() }
            self.tableView.mj_header!.pullingPercent = 0.0
            
        })
    }
    
    func up_refresh_complete_handle(videos: [(Int, String, String, String, String)]) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            print("上拉刷新")
            self.tableView.mj_footer?.endRefreshing()
            self.all_vidoes += videos
            self.tableView.reloadData()
            if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_header!.endRefreshing() }
            self.tableView.mj_footer!.pullingPercent = 0.0
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresed_time = currentTime("YYYY-MM-dd HH:mm:ss")
        //all_vidoes = get_all_videos(load_type: "init", time1: refresed_time, time2: "", page_no: Tutorial_video.next_more_page)
        //print(all_tutorials)
           tableView.register(UINib(nibName: "Tutorial_text_cell", bundle: nil), forCellReuseIdentifier: "tutorial_text_cell")
           
           // 顶部刷新控件
           tableView.mj_header = RefreshAutoGifHeader(refreshingBlock: { [weak self] in
               // 获取更新资讯
               var to_refresh_time = currentTime("YYYY-MM-dd HH:mm:ss")
               //get_all_videos(load_type: "refresh", time1: self!.refresed_time, time2: to_refresh_time, page_no: 1, complete_handle: self?.down_refresh_complete_handle)
               self!.refresed_time = to_refresh_time
           })
           tableView.mj_header?.isAutomaticallyChangeAlpha = true
           
           // 底部刷新控件
           tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
                  // 获取资讯列表数据，加载更多
               if(Tutorial_video.no_more) {
                   self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
               } else {
                   //get_all_videos(load_type: "more", time1: self!.refresed_time, time2: "", page_no: Tutorial_video.next_more_page, complete_handle: self?.up_refresh_complete_handle)
               }
              })
           tableView.mj_footer?.isAutomaticallyChangeAlpha = true
       }

       // MARK: - Table view data source

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           //print("all_tutorials.count:\(all_tutorials.count)")
           return all_vidoes.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let tableCell = tableView.dequeueReusableCell(withIdentifier: "tutorial_text_cell", for: indexPath)

           if let cell = tableCell as? Info_cell {
               //print("ok 0")
               //print("feed row at:\(indexPath.row)")
               let (id, tag, title, abstract, link) = all_vidoes[indexPath.row]

               //print("\(viewed_tutorial_id.index(after: id))")
               //print("\(viewed_tutorial_id)")
               if (viewed_tutorial_id.lastIndex(of: id) != nil) {
                   cell.newsTitleLabel.textColor = .gray
               }
            cell.item_type = "tutorial_video"
            cell.item_id = id
               cell.newsTitleLabel.text = title
               cell.newsAbstractLabel.text = abstract
               cell.tagLabel.text = tag
               //cell.newsPicture?.image = UIImage(imageLiteralResourceName: "tutorial_text_pic\(id)")
               //cell.newsPicture?.contentMode = .scaleAspectFit
               
            /*
               var score_text = "推荐指数:"
               for _ in 0..<score {
                   score_text += "⭐️"
               }
               cell.timeLabel.text = score_text
               */
               cell.selectionStyle = .none
               return cell
           } else {
               print("not ok")
           }
           //reloadInputViews()
           return tableCell
       }
       
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           var video_detail = all_vidoes[indexPath.row]
           print("\(video_detail.4)")
           var detail_vc = webVC()
           detail_vc.hidesBottomBarWhenPushed = true
           detail_vc.url_string = video_detail.4
           self.navigationController?.pushViewController(detail_vc, animated: true)
           
       }
       
    override func viewWillAppear(_ animated: Bool) {
        if (Tutorial_video.to_update) {
            //all_vidoes = get_all_videos(load_type: "init", time1: currentTime("YYYY-MM-dd HH:mm:ss"), time2: "", page_no: 1)

            tableView.reloadData()
            Tutorial_video.to_update = false
        }
           if(all_vidoes.count == 0) {
               let alter_vc = UIAlertController(title: "请设置您的标签", message: "", preferredStyle: .alert)
               let cancel_action = UIAlertAction(title: "暂不设置", style: .cancel, handler: nil)
               let add_action = UIAlertAction(title: "去设置", style: .destructive, handler: {action in
                   let tags_vc = UIStoryboard(name: "Toutiao", bundle: nil).instantiateViewController(withIdentifier: "tagsSelectionViewController")
                   
                   if let vc = tags_vc as? Tag_selection_VC {
                       self.navigationController?.pushViewController(vc, animated: true)
                   }
               })
               alter_vc.addAction(cancel_action)
               alter_vc.addAction(add_action)
               self.present(alter_vc, animated: true)
           }
       }
           
       override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           tableView.showsVerticalScrollIndicator = true
       }
       
       override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           tableView.showsVerticalScrollIndicator = false
       }


}
