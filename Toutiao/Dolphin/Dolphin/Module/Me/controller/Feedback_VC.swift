//
//  Feedback_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/28.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Feedback_VC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var feedback_textview: UITextView!
    var empty : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(feedback_textview.text!.count == 0) {
            init_textview()
        }
        
        feedback_textview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func init_textview() {
        empty = true
        feedback_textview.textColor = .gray
        feedback_textview.text = FEEDBACK_PLACEHOLDER
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if(empty) {
            feedback_textview.text = ""
        }
        feedback_textview.textColor = .black
        empty = false
        return true
    }
    
    // 点击空白处时，退出可编辑状态
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        feedback_textview.resignFirstResponder()
        if(feedback_textview.text.count == 0) {
            init_textview()
        }
    }
    
    @IBAction func commit(_ sender: Any) {
        let feedback_content = feedback_textview.get_text(default_str: FEEDBACK_PLACEHOLDER)
        if(feedback_content == FEEDBACK_PLACEHOLDER) {
            self.prompt("反馈内容不能为空", 1.0)
            return
        }
        var ret = Feedback(content: feedback_content)
        
        let alterVC = UIAlertController(title: ret ? "完成" : "失败", message: ret ? "再次感谢您的反馈!" : "反馈失败，请稍后重试。", preferredStyle:.alert)
        let ok_action = UIAlertAction(title: "好的", style: .destructive, handler: { action in
            if (ret) {
                self.feedback_textview.resignFirstResponder()
                self.init_textview()
            }
        })
        alterVC.addAction(ok_action)
        self.present(alterVC, animated:true)
        /*
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    alterVC.dismiss(animated: false, completion:{
                        self.feedback_textview.resignFirstResponder()
                        if(ret) {
                            self.init_textview()
                        }
                    });
                }*/
        
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
