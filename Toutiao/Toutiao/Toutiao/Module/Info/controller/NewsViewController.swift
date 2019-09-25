//
//  NewsViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController{
    
    //@IBOutlet weak var newsTableView: UITableView!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;   // content, related and review
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("initialize")
        //print(indexPath.row)
        let (id, title, abstract, body) = get_target(id: news_id ?? 0)
        
        if indexPath.row == 0 {
            //print("initialize for 0")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsContentCell", for: indexPath)
            if let tableCell = cell as? NewsContentCell {
                tableCell.textLabel?.text = body
            }
            return cell
        } else if (indexPath.row == 1) {
            //print("initialize for 1")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsRelatedCell", for: indexPath)
            if let tableCell = cell as? NewsRelatedCell {
                tableCell.textLabel?.text = abstract
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
           // print(news_id ?? 0)
        }
    }
    
    override func viewDidLoad() {
        //print("In viewDidLoad,newsView")
        super.viewDidLoad()
        loadViewIfNeeded()           // without this, "unexpectedly found nil while unwrapping an Optional value" will occur at "newsView.text = InfoViewController.news[news_id ?? 0]"
        
       // tableView(tableView, cellForRowAt: IndexPath(index: 0))
       // tableView(tableView, cellForRowAt: IndexPath(index: 1))
       // tableView(tableView, cellForRowAt: IndexPath(index: 2))
        // Do any additional setup after loading the view.
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

