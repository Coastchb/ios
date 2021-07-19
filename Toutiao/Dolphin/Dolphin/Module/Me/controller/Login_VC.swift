//
//  Login_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/27.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Login_VC: UIViewController {

    @IBOutlet weak var phone_num_label: UITextField!
    
    @IBOutlet weak var passwd_label: UITextField!
    
    @IBOutlet weak var message_label: UILabel!
    
    @IBAction func login_btn(_ sender: Any) {
        var phone_num = "\(phone_num_label.text!)"
        var user_passwd = "\(passwd_label.text!)"
        
        if (phone_num == "" || user_passwd == "") {
            message_label.isHidden = false
            message_label.text = "手机号和密码均不能为空"
            return
        }
        let login_ret = Toutiao.login(phone_num: phone_num, password: user_passwd)
        print(login_ret)
        if (login_ret[0] != "failed"){
            UserDefaults.standard.set(login_ret, forKey: USER_INFO_KEY)
            UserDefaults.standard.synchronize()
            
            get_user_avatar_from_server(vc: self, avatar_url_str:User.get_user_avatar_url()!)
        
            // method 1
            self.navigationController?.popViewController(animated: true)
                    
            // method 2
            // self.tabBarController?.selectedIndex = 0
            
            Tutorial_text.to_update = true
            InfoViewController.to_update = true
        } else {
            let alertController = UIAlertController(title: "登录失败",
                                                    message: "账号或密码错误", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "放弃登录", style: .cancel, handler: {action in
                print(UserDefaults.standard.value(forKey: USER_INFO_KEY))
                self.navigationController?.popViewController(animated: true)
            })
            let okAction = UIAlertAction(title: "重新登录", style: .default, handler: {action in
                self.phone_num_label.text = ""
                self.passwd_label.text = ""
                self.message_label.isHidden = true
                self.phone_num_label.becomeFirstResponder()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func register_btn(_ sender: Any) {
        let vc = Signup_VC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reset_passwd(_ sender: Any) {
        let vc = Signup_VC()
        vc.action_type = "reset_passwd"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        
        self.phone_num_label.placeholder = PHONE_NUM_PLACEHOLDER
        message_label.isHidden = true
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
