//
//  Add_tutorial_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/30.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import Alamofire

class Add_tutorial_VC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tutorial_name_textfield: UITextField!
    
    @IBOutlet weak var tutorial_url_textfield: UITextField!
    
    @IBOutlet weak var tutorial_descrip_textfield: UITextView!
    
    var descrip_empty : Bool = true
    
    func init_descrip() {
        descrip_empty = true
        tutorial_descrip_textfield.textColor = .gray
        tutorial_descrip_textfield.text = TUTORIAL_DESCRIPTION_PLACEHOLDER
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("start editing; empty:\(descrip_empty)")
        if(descrip_empty) {
            tutorial_descrip_textfield.text = ""
        }
        tutorial_descrip_textfield.textColor = .black
        descrip_empty = false
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorial_descrip_textfield.layer.borderColor = UIColor.gray.cgColor
        tutorial_descrip_textfield.layer.borderWidth = 1
        tutorial_descrip_textfield.delegate = self
        tutorial_name_textfield.delegate = self
        tutorial_url_textfield.delegate = self
        
        init_descrip()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func add_tutorial(_ sender: Any) {
        var tutorial_name = tutorial_name_textfield.get_text(default_str: "None")
        var tutorial_url = tutorial_url_textfield.get_text(default_str: "None")
        var description = descrip_empty ? "None" : tutorial_descrip_textfield.get_text(default_str: "None")
        
        if(!check_network_available()) {
            self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
            return
        }
        
        if(tutorial_url == "None"){
            self.prompt("网络地址不能为空", 1.0)
        } else {
            var ret = add_user_added_tutorial_to_DB(vc: self, tutorial_name: tutorial_name,tutorial_url: tutorial_url, tutorial_descrip: description)
            add_tutorial_complete(ret: ret)
        }
    }
    
    func add_tutorial_complete(ret:Bool) {
        let alter_VC = UIAlertController(title: ret ? "完成" : "失败", message: ret ? "感谢发布！请等待审核。" : "发布失败，请稍后重试。", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "好的", style: .destructive, handler: { action in
           if (ret) {
                self.resign_all()
                self.tutorial_name_textfield.text = ""
                self.tutorial_url_textfield.text = ""
                self.init_descrip()
            }
        })
        alter_VC.addAction(ok_action)
        self.present(alter_VC,animated: true)
    }
    
    @IBAction func go_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    }
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resign_all()
        if(tutorial_descrip_textfield.text.count == 0) {
            init_descrip()
        }
    }
    
    func resign_all() {
        tutorial_url_textfield.resignFirstResponder()
        tutorial_name_textfield.resignFirstResponder()
        tutorial_descrip_textfield.resignFirstResponder()
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
