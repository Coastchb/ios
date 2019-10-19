//
//  ViewController.swift
//  xib_layout
//
//  Created by coastcao(操海兵) on 2019/9/29.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var table_cell = tableView.dequeueReusableCell(withIdentifier: "my_cell", for: indexPath)
        
        if let cell = table_cell as? tableViewCell {
            cell.title.text = "aaaa"
            return cell
        }
        
        return table_cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "tableViewCell", bundle: nil), forCellReuseIdentifier: "my_cell")
        // Do any additional setup after loading the view.
    }

    

}

