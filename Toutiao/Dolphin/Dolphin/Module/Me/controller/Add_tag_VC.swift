//
//  Add_tag_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/30.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Add_tag_VC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var tag_name_textfield: UITextField!
    
    @IBOutlet weak var tag_fullname_textfield: UITextField!
    
    @IBOutlet weak var tag_descrip_textview: UITextView!
    
    var descrip_empty : Bool = true
    
    func init_descrip() {
        descrip_empty = true
        tag_descrip_textview.textColor = .gray
        tag_descrip_textview.text = TAG_DESCRIPTION_PLACEHOLDER
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("start editing; empty:\(descrip_empty)")
        if(descrip_empty) {
            tag_descrip_textview.text = ""
        }
        tag_descrip_textview.textColor = .black
        descrip_empty = false
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tag_descrip_textview.layer.borderColor = UIColor.gray.cgColor
        tag_descrip_textview.layer.borderWidth = 1
        tag_descrip_textview.delegate = self
        
        init_descrip()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func add_tag(_ sender: Any) {
        let tag_name = tag_name_textfield.get_text(default_str: "None")
        if(tag_name == "None") {
            self.prompt("标签简称不能为空", 1.0)
            return
        }
        let description = descrip_empty ? "None" : tag_descrip_textview.get_text(default_str: "None")
        let ret = add_user_added_tag_to_DB(tag_name: tag_name,tag_fullname: tag_fullname_textfield.get_text(default_str: "None"), tag_descrip: description)
        
        let alter_VC = UIAlertController(title: ret ? "完成" : "失败", message: ret ? "感谢添加！请等待审核。" : "添加失败，请稍后重试。", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "好的", style: .destructive, handler: { action in
            if (ret) {
                self.tag_name_textfield.text = ""
                self.tag_fullname_textfield.text = ""
                self.init_descrip()
                self.resign_all()
            }
        })
        alter_VC.addAction(ok_action)
        self.present(alter_VC,animated: true)
    }
    @IBAction func go_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resign_all()
        if(tag_descrip_textview.text.count == 0) {
            init_descrip()
        }
    }
    
    func resign_all() {
        tag_name_textfield.resignFirstResponder()
        tag_fullname_textfield.resignFirstResponder()
        tag_descrip_textview.resignFirstResponder()
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
