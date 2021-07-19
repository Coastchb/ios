//
//  ChildThreeVC.swift
//  SGPagingViewExample
//
//  Created by kingsic on 2018/9/15.
//  Copyright © 2018年 kingsic. All rights reserved.
//

import UIKit

class ChildThreeVC: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChildThreeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = "ChildThreeVC - - \(indexPath.row)"
        cell?.selectionStyle = .none
        return cell!
    }
}
