//
//  InfoViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/25.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var all_blogs = [(Int, String, String, String, String, Int)]()
    var viewed_tutorial_id = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.title = "学术动态"
        
    

           tableView.register(UINib(nibName: "Tutorial_text_cell", bundle: nil), forCellReuseIdentifier: "tutorial_text_cell")
           
           // 顶部刷新控件
           tableView.mj_header = RefreshAutoGifHeader(refreshingBlock: { [weak self] in
               // 获取更新资讯
               /*DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                   self!.tableView.reloadData()
                   self!.tableView.mj_header?.endRefreshing()
               })*/
               
               var more = get_all_blogs()
               more.forEach { one in
                    self!.all_blogs.append(one)
                }
            if self!.tableView.mj_header!.isRefreshing { self!.tableView.mj_header!.endRefreshing() }
            self!.tableView.mj_header!.pullingPercent = 0.0
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
                            self!.all_tutorials.append(one)
                        }
                       if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
                       self!.tableView.mj_footer.pullingPercent = 0.0
                        self!.tableView.reloadData()
                   //self!.tableView.reloadData()
                   //self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
               })*/
    
               var more = get_all_blogs()
               more.forEach { one in
                    self!.all_blogs.append(one)
                }
            if self!.tableView.mj_footer!.isRefreshing { self!.tableView.mj_footer!.endRefreshing() }
            self!.tableView.mj_footer!.pullingPercent = 0.0
                self!.tableView.reloadData()
               //self!.tableView.mj_footer?.endRefreshingWithNoMoreData()
              })
        tableView.mj_footer!.isAutomaticallyChangeAlpha = true
       }

       // MARK: - Table view data source

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           //print("all_tutorials.count:\(all_tutorials.count)")
           return all_blogs.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let tableCell = tableView.dequeueReusableCell(withIdentifier: "tutorial_text_cell", for: indexPath)

           if let cell = tableCell as? Tutorial_text_cell {
               //print("ok 0")
               //print("feed row at:\(indexPath.row)")
               let (id, tag, title, abstract, link, score) = all_blogs[indexPath.row]

               //print("\(viewed_tutorial_id.index(after: id))")
               //print("\(viewed_tutorial_id)")
               if (viewed_tutorial_id.lastIndex(of: id) != nil) {
                   cell.newsTitleLabel.textColor = .gray
               }
            cell.item_type = "blog"
            cell.item_id = id
               cell.newsTitleLabel.text = title
               cell.newsAbstractLabel.text = abstract
               cell.tagLabel.text = tag
               cell.newsPicture?.image = UIImage(imageLiteralResourceName: "tutorial_text_pic\(id)")
               cell.newsPicture?.contentMode = .scaleAspectFit
               
               var score_text = "推荐指数:"
               for _ in 0..<score {
                   score_text += "⭐️"
               }
               cell.scoreLabel.text = score_text
               
               //cell.selectionStyle = .none
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
           self.navigationController?.pushViewController(detail_vc, animated: true)
           
       }
       
    override func viewWillAppear(_ animated: Bool) {
           all_blogs = get_all_blogs()
        /*
           if(all_blogs.count == 0) {
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
           tableView.reloadData()
       }
           
       func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           tableView.showsVerticalScrollIndicator = true
       }
       
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           tableView.showsVerticalScrollIndicator = false
       }

}


