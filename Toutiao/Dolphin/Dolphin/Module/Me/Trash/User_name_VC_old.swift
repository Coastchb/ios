//
//  User_name_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/9.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class User_name_VC_old: UIViewController {

    var user_name = ""
    @IBOutlet weak var user_name_textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改用户名"
                
        let item=UIBarButtonItem(title:"确定",style:.plain,target:self,action:Selector(("confirm_to_change")))
        navigationItem.rightBarButtonItem = item
        
        user_name_textfield.text = user_name
        user_name_textfield.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    @objc func confirm_to_change() {
        var ret = User.reset_user_name(new_user_name: user_name_textfield.text!)
        
        var message = ""
        var title = ""
        if (ret == 0) {
            title = ""
            message = "修改成功"
        } else if (ret == 1) {
            title = "修改失败"
            message = "原密码错误"
        } else {
            title = "修改失败"
            message = "未知错误"
        }
        
        let next_step = (ret == 0) ? "确定" : "放弃修改"
        let alert_vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel_action = UIAlertAction(title: "重新修改", style: .cancel, handler: nil)
        let next_action = UIAlertAction(title: next_step, style: .destructive, handler: {action in
            self.navigationController?.popViewController(animated: true)
        })
        
        if(ret != 0) {
            alert_vc.addAction(cancel_action)
        }
        alert_vc.addAction(next_action)
        self.present(alert_vc,animated: true)
        
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
