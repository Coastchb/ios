//
//  NewsViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class NewsViewController_2: UITableViewController{
    
    //@IBOutlet weak var newsTableView: UITableView!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;   // content, related and review
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("initialize")
        //print(indexPath.row)
        
        if indexPath.row == 0 {
            //print("initialize for 0")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsContentCell", for: indexPath)
            if let tableCell = cell as? NewsContentCell {
                tableCell.body.text = news_body
                tableCell.title.text = news_title
            }
            return cell
        } else if (indexPath.row == 1) {
            //print("initialize for 1")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsRelatedCell", for: indexPath)
            if let tableCell = cell as? NewsRelatedCell {
                tableCell.textLabel?.text = news_abstract
            }
            return cell
        } else {
            //print("initialize for 2")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsReviewCell", for: indexPath)
            if let tableCell = cell as? NewsReviewCell {
                tableCell.textLabel?.text = title
            }
            return cell
        }
        
    }
    

    
    var news_id : Int? {
        didSet {
            print(news_id)
        }
    }
    
    var news_title : String?
    var news_body : String?
    var news_abstract : String?
    
    
    override func viewDidLoad() {
        //print("In viewDidLoad,newsView")
        super.viewDidLoad()
        (news_id,news_title,news_abstract,news_body) = get_target_2(id: news_id!)
        
        //print("data loaded")
        
       tableView.register(UINib(nibName: "NewsContentCell", bundle: nil), forCellReuseIdentifier: "newsContentCell")
        tableView.register(UINib(nibName: "NewsRelatedCell", bundle: nil), forCellReuseIdentifier: "newsRelatedCell")
        tableView.register(UINib(nibName: "NewsReviewCell", bundle: nil), forCellReuseIdentifier: "newsReviewCell")
        
        
        /*
         loadViewIfNeeded()           // in storyboard mode, push from parent view to children view. without this, "unexpectedly found nil while unwrapping an Optional value" will occur at "newsView.text = InfoViewController.news[news_id ?? 0]"
         */
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

