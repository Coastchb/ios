//
//  User_name_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/11.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class User_name_VC: UIViewController {
    
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
        if (user_name == self.user_name_textfield.text!) {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if(!check_network_available()) {
            self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
            return
        }
        let ret = User.reset_user_name(new_user_name: user_name_textfield.text!)
        if (ret == 0) {
            self.navigationController?.popViewController(animated: true)
        } else {
            // alert
            let message = (ret == 1) ? "修改失败" : SERVER_CRASH_PROMPT
            var alter_vc = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let cancel_action = UIAlertAction(title: "重试", style: .cancel, handler: nil)
            let next_action = UIAlertAction(title: "放弃修改", style: .destructive, handler: {action in
                self.navigationController?.popViewController(animated: true)
            })
            
            alter_vc.addAction(cancel_action)
            alter_vc.addAction(next_action)
            self.present(alter_vc,animated: true)
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
