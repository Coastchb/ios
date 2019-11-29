//
//  Login_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/27.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Login_VC: UIViewController {

    @IBOutlet weak var user_name_label: UITextField!
    
    @IBOutlet weak var passwd_label: UITextField!
    
    @IBAction func login_btn(_ sender: Any) {
        
               var userName = "\(user_name_label.text!)"
               var user_passwd = "\(passwd_label.text!)"

              
               let login_ret = Toutiao.login(user_name: userName, password: user_passwd)
               
               if (login_ret == "passed"){
                    get_user_avatar_from_server()
                
                    // method 1
                    self.navigationController?.popViewController(animated: true)
                    
                    // method 2
                    // self.tabBarController?.selectedIndex = 0
               } else {
                    let alertController = UIAlertController(title: "登录失败",
                                              message: "账号或密码错误", preferredStyle: .alert)
                   let cancelAction = UIAlertAction(title: "放弃登录", style: .cancel, handler: {action in
                       self.navigationController?.popViewController(animated: true)
                   })
                    let okAction = UIAlertAction(title: "重新登录", style: .default, handler: {action in
                       self.user_name_label.text = ""
                       self.passwd_label.text = ""
                       
                       
                   })
                   alertController.addAction(cancelAction)
                   alertController.addAction(okAction)
                   self.present(alertController, animated: true, completion: nil)
               }
    }
    override func viewDidLoad() {
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
