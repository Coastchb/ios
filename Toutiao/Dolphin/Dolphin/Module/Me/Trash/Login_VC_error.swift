//
//  LoginViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/13.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class LoginViewController_error: UIViewController {
    
    @IBOutlet weak var userName_input: UITextField!
    
    @IBOutlet weak var passwd_input: UITextField!
    
    @IBAction func login(_ sender: Any) {
           
        var userName = "\(userName_input.text!)"
        var user_passwd = "\(passwd_input.text!)"

       
        let login_ret = Toutiao.login(phone_num: userName, password: user_passwd)
        
        if (login_ret[0] != "failed"){
             // method 1
             self.navigationController?.popViewController(animated: true)
             
             // method 2
             // self.tabBarController?.selectedIndex = 0
            
           // NotificationCenter.default.addObserver(self, selector: #selector(tmp), name: NSNotification.Name(rawValue: "tmp_obs"), object: nil)
        } else {
             let alertController = UIAlertController(title: "登录失败",
                                       message: "账号或密码错误", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "放弃登录", style: .cancel, handler: {action in
                self.navigationController?.popViewController(animated: true)
            })
             let okAction = UIAlertAction(title: "重新登录", style: .default, handler: {action in
                self.userName_input.text = ""
                self.passwd_input.text = ""
                
                
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }

    }

    override func viewDidLoad() {
        print("logging")
        super.viewDidLoad()

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
