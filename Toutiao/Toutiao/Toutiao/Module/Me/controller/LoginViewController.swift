//
//  LoginViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/13.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func login(_ sender: Any) {
        
       // UserDefaults.standard.setValue("Coast", forKey: "User_name")
        
        let login_ret = Toutiao.login(user_name: "coastcao", password: "520601")
        
        if (login_ret == "passed"){
            UserDefaults.standard.set("Coast", forKey: "User_name")
             // method 1
             self.navigationController?.popViewController(animated: true)
             
             // method 2
             // self.tabBarController?.selectedIndex = 0
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
