//
//  MeViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/2.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class MeViewController_old: UITableViewController {

    var logined : Bool = false
    var user_name : String? = ""
    override func viewDidLoad() {
        super.viewDidLoad();
        //print(')
        print("\(self.tableView.numberOfRows(inSection: 0))")

        self.tableView.register(UINib(nibName: "LoginCell", bundle: nil), forCellReuseIdentifier: "loginCell")
        //self.tableView.register(UINib(nibName: "LoginedCell", bundle: nil), forCellReuseIdentifier: "loginedCell")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        user_name = UserDefaults.standard.string(forKey: "User_name")
        if (user_name! != "") {
            print("OK!")
            logined = true
        }
    }
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 200
        } else {
            return 40
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let tableCell = self.tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath)
            if let cell = tableCell as? LoginCell {
                if logined {
                    cell.login_button.isHidden = true
                    cell.name_label?.text = "Welcome,\(user_name!)!"
                    cell.user_avatar?.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "dropdown_loading_03"))
                } else {
                    cell.name_label?.isHidden = true
                }
                return cell
            }
                return tableCell
            
        } else if (indexPath.row == 1) {
            return UITableViewCell()
        } else {
            return UITableViewCell()
        }

       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.present(LoginViewController(), animated: true)
        if (!logined) {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
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
