//
//  child_one.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/28.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//


import UIKit

class child_0ne: UITableViewController{
    
    var ids = [1,2,3,4,5,6,7,8,9,10,11,12,13,15,1345,34,534,63,46,3456,45,6456,45,343,34,534,32]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ids.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        tableCell.textLabel!.text = "\(ids[indexPath.row])"
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        tableView.register(UINib(nibName: "tmp_cell", bundle: nil), forCellReuseIdentifier: "cell")
        
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
