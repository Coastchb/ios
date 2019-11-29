//
//  User_detail.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/24.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation
import UIKit

class User_detail_VC: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            let vc = User_avatar_VC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 3) {
            let vc = User_passwd_VC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 100
        }
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row != 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "user_detail_cell")
            if let detail_cell = cell as? User_detail_cell {
                var user_info = User.get_user_info()
                if (indexPath.row == 1) {
                    detail_cell.key_label!.text =  "用户名"
                    detail_cell.value_label!.text = user_info![0]
                } else if (indexPath.row == 2) {
                    detail_cell.key_label!.text = "性别"
                } else if (indexPath.row == 3) {
                    detail_cell.key_label!.text = "修改密码"
                    detail_cell.value_label!.isHidden = true
                }
                
                detail_cell.selectionStyle = .none
                return detail_cell
            }
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "user_avatar_cell")
            if let avatar_cell = cell as? User_avatar_cell {
                avatar_cell.avatar_image_view.image = User.get_user_avatar()!
                avatar_cell.selectionStyle = .none
                return avatar_cell
            }
        }
        return UITableViewCell()
    }
        
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib(nibName: "User_detail_cell", bundle: nil), forCellReuseIdentifier: "user_detail_cell")
        tableView.register(UINib(nibName: "User_avatar_cell", bundle: nil), forCellReuseIdentifier: "user_avatar_cell")
        
        let item = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}
