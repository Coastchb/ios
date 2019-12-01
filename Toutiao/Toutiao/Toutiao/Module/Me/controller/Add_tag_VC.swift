//
//  Add_tag_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/30.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Add_tag_VC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var tag_name_label: UITextField!
    
    @IBOutlet weak var tag_abbre_label: UITextField!
    
    @IBOutlet weak var tag_descrip_label: UITextView!
    
    var descrip_empty : Bool = true
    
    func init_descrip() {
        descrip_empty = true
        tag_descrip_label.textColor = .gray
        tag_descrip_label.text = "请简单介绍新增标签，比如所属一级专业、二级专业等..."
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("start editing; empty:\(descrip_empty)")
        if(descrip_empty) {
            tag_descrip_label.text = ""
        }
        tag_descrip_label.textColor = .black
        descrip_empty = false
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tag_descrip_label.layer.borderColor = UIColor.gray.cgColor
        tag_descrip_label.layer.borderWidth = 1
        tag_descrip_label.delegate = self
        
        init_descrip()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func add_tag(_ sender: Any) {
        var description = descrip_empty ? "None" : tag_descrip_label.get_text(default_str: "None")
        var ret = add_user_added_tag_to_DB(tag_name: tag_name_label.get_text(default_str: "None"),tag_abb: tag_abbre_label.get_text(default_str: "None"), tag_descrip: description)
        
        let alter_VC = UIAlertController(title: nil, message: ret ? "添加标签成功！" : "添加标签失败!", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "知道了", style: .destructive, handler: { action in
            if (ret) {
                self.tag_name_label.text = ""
                self.tag_abbre_label.text = ""
                self.init_descrip()
            }
        })
        alter_VC.addAction(ok_action)
        self.present(alter_VC,animated: true)
    }
    @IBAction func go_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = UIApplication.shared.keyWindow?.perform(Selector(("firstResponder"))) {
              let first = view.takeRetainedValue() as? UIView
              first?.resignFirstResponder()
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
