//
//  User_gender_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/10.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class User_gender_VC: UIViewController {
    @IBOutlet weak var male_btn: RadioButton!
    @IBOutlet weak var female_btn: RadioButton!
    
    var gender_btns : [RadioButton]?
    var genders = ["男", "女"]
    var selected_gender = "男"
    var previous_gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改性别"

        let item=UIBarButtonItem(title:"确定",style:.plain,target:self,action:Selector(("confirm_to_change")))
        navigationItem.rightBarButtonItem = item
        
        gender_btns = [male_btn, female_btn]
        if(selected_gender == "男") {
            male_btn.isSelected = true
        } else {
            female_btn.isSelected = true
        }
        
        previous_gender = selected_gender
        // Do any additional setup after loading the view.
    }

    @IBAction func select_gender(_ sender: RadioButton) {
        gender_btns?.forEach({$0.isSelected = false})
        sender.isSelected = true
        if let selected_idx = gender_btns?.firstIndex(of: sender) {
            print("性别是:\(genders[selected_idx])")
            selected_gender = genders[selected_idx]
        }
    }
    
    
    @objc func confirm_to_change() {
        if(selected_gender == previous_gender) {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if(!check_network_available()) {
            self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
            return
        }
        
        let ret = User.reset_gender(gender:selected_gender)
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
