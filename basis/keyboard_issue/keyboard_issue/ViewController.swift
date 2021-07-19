//
//  ViewController.swift
//  keyboard_issue
//
//  Created by coastcao(操海兵) on 2020/3/14.
//  Copyright © 2020 One-Zero. All rights reserved.
//

import UIKit
 
class my_vc:  UIViewController {
 
    @IBOutlet weak var b: UITextField!
    @IBOutlet weak var a: UITextField!
    @IBOutlet weak var etWifi: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    //   @IBOutlet weak var etWifi: UITextField!
 //   @IBOutlet weak var etPassword: UITextField!
    
    //记录 self.view 的原始 origin.y
    private var originY: CGFloat = 0
    //正在输入的UITextField
    private var editingText: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etWifi.delegate = self
        etPassword.delegate = self
        a.delegate = self
        b.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(handle(keyboardShowNotification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
       
        if let userInfo = notification.userInfo,
            // 3
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            print(keyboardRectangle.height)
            let rect = self.editingText!.convert(self.editingText!.bounds, to: self.view)

            let y = self.view.bounds.height - rect.origin.y - self.editingText!.bounds.height - keyboardRectangle.height
            if ( y < 0 ) {
                self.view.frame.origin.y =  y
            }
        }
        
    }
    
    //键盘落下
    @objc func keyboardWillDisappear(notification:NSNotification){
        //软键盘收起的时候恢复原始偏移
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
    }
    
}
 
extension my_vc: UITextFieldDelegate {
    //设置点击软键盘return键隐藏软键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //获得正在输入的UITextField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingText = textField
    }
}
