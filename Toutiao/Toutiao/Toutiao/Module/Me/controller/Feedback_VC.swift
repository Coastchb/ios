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
        feedback_textview.text = "请写下您的宝贵意见..."
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
        var ret = Feedback(content: feedback_textview.text!)
        
        let alterVC = UIAlertController(title: nil, message: ret, preferredStyle:.alert)
        self.present(alterVC, animated:true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    alterVC.dismiss(animated: false, completion:{
                        self.feedback_textview.resignFirstResponder()
                        if(ret == "再次感谢您的反馈！") {
                            self.init_textview()
                        }
                    });
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
