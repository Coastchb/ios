//
//  InfoViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/2.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

// mark 1: make sure that table height is not bigger than that of visible eara
// mark 2: two ways to custom table cell

import UIKit

//@IBDesignable
class RecommendVC_old: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /*
    private lazy var newsTableView: UITableView = {
        // mark 1
        let tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height - 197.0 ), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    */
    
    @IBOutlet weak var newsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(all_news.count)")
        return all_news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "newsListCell", for: indexPath)

        if let cell = tableCell as? Tutorial_text_cell {
            //print("ok")
            let (id, title, abstract, body) = all_news[indexPath.row]

            cell.newsTitleLabel.text = title
            cell.newsAbstractLabel.text = abstract
            //cell.newsAbstractInCell?.text = abstract
            
            return cell
        } else {
            print("not ok")
        }
        //reloadInputViews()
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let vc = NewsViewController()
        vc.news_id = 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        newsTableView.rowHeight = 120
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        loadViewIfNeeded()
        print("\(newsTableView)")

        awakeFromNib()
        
        // mark 2
        newsTableView.register(UINib(nibName: "NewsListCell", bundle: nil), forCellReuseIdentifier: "newsListCell")
        
        // of course, we can write custom cell in code
        // newsTableView.register(NewsListCell_in_code.self, forCellReuseIdentifier: "newsListCell")
        
        //view.addSubview(newsTableView)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewWillLayoutSubviews() {
        newsTableView.rowHeight = 120
    }
    
    var all_news = get_all()
    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier, identifier == "showNews" {
            if let cell = sender as? UITableViewCell, let indexPath = newsTableView.indexPath(for: cell) {
                if let newsViewController = segue.destination as? NewsViewController {
                    //newsViewController.viewDidLoad()
                    newsViewController.news_id = all_news[indexPath.row].0
                }
            }
        }
    }*/
    

    
    
}
