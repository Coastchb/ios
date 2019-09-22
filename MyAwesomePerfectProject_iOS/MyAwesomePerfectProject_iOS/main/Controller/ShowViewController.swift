//
//  ShowViewController.swift
//  MyAwesomePerfectProject_iOS
//
//  Created by coastcao(操海兵) on 2019/9/21.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoLabel: UILabel!
    var all_users : [(Int, String)] = []
    
    @IBOutlet weak var showTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("tableView() 0")
        return all_users.count + 1; // it determines how many rows to show
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("tableView() 1")
        if indexPath.row == 0 {
            //print("initialize for 0")
            let cell = tableView.dequeueReusableCell(withIdentifier: "showHeaderCell", for: indexPath)
            //if let tableCell = cell as? showTableHeaderCell {
            //    tableCell.userIDLabel =
            //}
            return cell
        } else{
            //print("initialize for 1")
            let cell = tableView.dequeueReusableCell(withIdentifier: "showListCell", for: indexPath)
            if let tableCell = cell as? showTableListCell {
                let (id, name) = all_users[indexPath.row - 1]
                tableCell.userIDLabel.text = String(id)
                tableCell.userNameLabel.text = name
            }
            return cell
        }
    }
    

    @IBAction func show_user_count(_ sender: UIButton) {
        infoLabel.text = String(get_user_count())
        //print(show_all_users())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showTable.delegate = self
        showTable.dataSource = self
        all_users = show_all_users()

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
