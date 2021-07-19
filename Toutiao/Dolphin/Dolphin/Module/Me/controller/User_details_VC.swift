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
            vc.init_image = User.get_user_avatar(vc: self)!
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 4) {
            let vc = User_passwd_VC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 1) {
            let vc = User_name_VC()
            vc.user_name = User.get_user_name()!
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 3) {
            let vc = Signup_VC()
            vc.btn_title = "确定"
            vc.item_title = "修改手机号"
            vc.action_type = "change_phone_num"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 2) {
            let vc = User_gender_VC()
            vc.selected_gender = User.get_user_gender()!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
                    detail_cell.value_label!.text = User.get_user_name()!
                } else if (indexPath.row == 2) {
                    detail_cell.key_label!.text = "性别"
                    detail_cell.value_label!.text = User.get_user_gender()!
                } else if (indexPath.row == 4) {
                    detail_cell.key_label!.text = "修改密码"
                    detail_cell.value_label!.isHidden = true
                } else if (indexPath.row == 3) {
                    detail_cell.key_label!.text = "手机号"
                    detail_cell.value_label!.text = User.get_user_phone_num()!
                }
                
                detail_cell.selectionStyle = .none
                return detail_cell
            }
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "user_avatar_cell")
            if let avatar_cell = cell as? User_avatar_cell {
                avatar_cell.avatar_image_view.image = User.get_user_avatar(vc: self)!
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
