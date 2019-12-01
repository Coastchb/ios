//
//  Add_tutorial_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/30.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import Alamofire

class Add_tutorial_VC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tutorail_name: UITextField!
    
    @IBOutlet weak var tutorial_url: UITextField!
    
    @IBOutlet weak var tutorial_descrip: UITextView!
    
    var descrip_empty : Bool = true
    
    func init_descrip() {
        descrip_empty = true
        tutorial_descrip.textColor = .gray
        tutorial_descrip.text = "请简单介绍新增标签，比如所属一级专业、二级专业等..."
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("start editing; empty:\(descrip_empty)")
        if(descrip_empty) {
            tutorial_descrip.text = ""
        }
        tutorial_descrip.textColor = .black
        descrip_empty = false
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorial_descrip.layer.borderColor = UIColor.gray.cgColor
        tutorial_descrip.layer.borderWidth = 1
        tutorial_descrip.delegate = self
        
        init_descrip()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func add_tag(_ sender: Any) {
        var description = descrip_empty ? "None" : tutorial_descrip.get_text(default_str: "None")
        var ret = add_user_added_tutorial_to_DB(tutorial_name: tutorail_name.get_text(default_str: "None"),tutorial_url: tutorial_url.get_text(default_str: "None"), tutorial_descrip: description)
        add_tag_complete(ret_str: ret)
    }
    
    func add_tag_complete(ret_str:String) {
        var ret = ret_str == "OK"
        let alter_VC = UIAlertController(title: nil, message: ret ? "添加教程成功！" : "添加教程失败!", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "知道了", style: .destructive, handler: { action in
           if (ret) {
                self.tutorail_name.text = ""
                self.tutorial_url.text = ""
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
