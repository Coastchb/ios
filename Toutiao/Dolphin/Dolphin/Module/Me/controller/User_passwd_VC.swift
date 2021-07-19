//
//  User_passwd_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/27.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class User_passwd_VC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var old_passwd_textfield: UITextField!
    
    @IBOutlet weak var new_passwd_textfield: UITextField!
    
    @IBOutlet weak var repeat_passwd_textfield: UITextField!
    
    @IBOutlet weak var message_label: UILabel!
    @IBOutlet weak var old_passwd_label: UILabel!
    
    var title_str = "修改密码"
    var action_type = "change_passwd"
    var phone_num = ""
    
    @IBAction func change_passwd_btn(_ sender: Any) {
        if(!check_network_available()) {
            self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
            return
        }
        if (new_passwd_textfield!.text != repeat_passwd_textfield!.text) {
            message_label.isHidden = false
            message_label.text = "两次输入的新密码不一致"
            return
        } else if (new_passwd_textfield.text!.count < PASSWD_MIN_LEN) {
            message_label.isHidden = false
            message_label.text = "密码长度不能小于\(PASSWD_MIN_LEN)位"
            return 
        } else if (action_type == "change_passwd") {
            if(new_passwd_textfield.text! == old_passwd_textfield.text!) {
            message_label.isHidden = false
            message_label.text = "新密码不能和旧密码一样"
            return
            }
            if (old_passwd_textfield.text == "" || new_passwd_textfield.text == "") {
            message_label.isHidden = false
            message_label.text = "密码不能为空"
            return
            }
        }
        
        var old_passwd = (action_type == "reset_passwd") ? "" : old_passwd_textfield!.text!
        
        if(User.is_logined()) {
            phone_num = User.get_user_phone_num()!
        }
        let ret = User.reset_user_passwd(phone_num: phone_num, old_passwd: old_passwd, new_passwd: new_passwd_textfield!.text!)
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
        
        let next_step = (ret == 0) ? "前往登录" : "放弃修改"
        let alert_vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel_action = UIAlertAction(title: "重新修改", style: .cancel, handler: nil)
        let next_action = UIAlertAction(title: next_step, style: .destructive, handler: {action in
            if (ret == 0) {
                User.logout()
                //self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
                self.navigationController?.popToRootViewController(animated: true)
                //self.navigationController?.pushViewController(Login_VC(), animated: true)
            } else {
                self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
            }
        })
        
        if(ret != 0) {
            alert_vc.addAction(cancel_action)
        }
        alert_vc.addAction(next_action)
        self.present(alert_vc,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message_label.isHidden = true
        
        self.navigationItem.title = title_str
        
        self.old_passwd_textfield.delegate = self
        self.new_passwd_textfield.delegate = self
        self.repeat_passwd_textfield.delegate = self
        
        if(action_type == "reset_passwd") {
            self.old_passwd_label.isHidden = true
            self.old_passwd_textfield.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.message_label.isHidden = true
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        old_passwd_textfield.resignFirstResponder()
        new_passwd_textfield.resignFirstResponder()
        repeat_passwd_textfield.resignFirstResponder()
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
