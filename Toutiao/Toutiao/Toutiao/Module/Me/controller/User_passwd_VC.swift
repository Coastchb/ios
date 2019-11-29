//
//  User_passwd_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/27.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class User_passwd_VC: UIViewController {

    @IBOutlet weak var old_passwd_label: UITextField!
    
    @IBOutlet weak var new_passwd_label: UITextField!
    
    @IBOutlet weak var repeat_passwd_label: UITextField!
    
    @IBAction func change_passwd_btn(_ sender: Any) {
        if (new_passwd_label!.text != repeat_passwd_label!.text) {
            print("两处输入的新密码不一致！")
        }
        
        var ret = User.change_user_passwd(name: User.get_user_name()!, old_passwd: old_passwd_label!.text!, new_passwd: new_passwd_label!.text!)
        print("change passwd ret:\(ret)")
        
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
