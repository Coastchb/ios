//
//  Register_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Signup_VC: UIViewController, UITextFieldDelegate {

    var btn_title = "验证"
    var item_title = "验证手机号"
    var action_type = "signup" // "signup", "change_phone_num", "reset_passwd"
    var placeholder = ""
    var phone_num_valid = false
    
    @IBOutlet weak var phone_num_textfield: UITextField!
    
    @IBOutlet weak var code_textfield: UITextField!
    
    @IBOutlet weak var get_code_btn: UIButton!
    @IBOutlet weak var ok_btn: UIButton!
    @IBOutlet weak var message_label: UILabel!
    var phone_num_textfield_is_empty = true
    private var countdownTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = item_title
        setupUI()
        message_label.isHidden = true
        
        //init_textview()
        phone_num_textfield.delegate = self
        code_textfield.delegate = self
        
        self.ok_btn.setTitle(btn_title, for: .normal)
        
        self.placeholder = (action_type == "change_phone_num") ? NEW_PHONE_NUM_PLACEHOLDER : PHONE_NUM_PLACEHOLDER
        
        self.phone_num_textfield.placeholder = self.placeholder
        
        // Do any additional setup after loading the view.
    }

    func validate_phone_num(phone_num: String) -> Bool {
        if(phone_num == self.placeholder) {
            self.message_label.isHidden = false
            self.message_label.text = "手机号不能为空"
            return false
        }
        if(action_type != "reset_passwd" && is_phone_num_existed(phone_num: phone_num)) {
            self.message_label.isHidden = false
            self.message_label.text = "该手机号已被注册"
            return false
        }
        return true
    }
    
    @IBAction func get_code(_ sender: Any) {
        var phone_num = phone_num_textfield.get_text(default_str: self.placeholder)
        phone_num_valid = validate_phone_num(phone_num: phone_num)
        if(!phone_num_valid) {
            return
        }
        
        SMSSDK.getVerificationCode(by: .SMS, phoneNumber: phone_num, zone: "86", template: "", result: {ret in
            if(ret != nil) {
                self.message_label.isHidden = false
                self.message_label.text = "获取验证码失败，请检查手机号"
            } else {
                print("OK!")
            }
            self.phone_num_textfield.resignFirstResponder()
        })
    }
    
    func call_back(ret:Int) {
        print(ret)
        
        var message = ""
        var title = ""
        if (ret == 0) {
            title = ""
            message = "修改成功"
        } else if (ret == 1) {
            title = "修改失败"
            message = "服务器端错误，请等待修复"
        } else {
            title = "修改失败"
            message = "未知错误"
        }
        
        let next_step = (ret == 0) ? "确定" : "放弃修改"
        let alert_vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel_action = UIAlertAction(title: "重新修改", style: .cancel, handler: nil)
        let next_action = UIAlertAction(title: next_step, style: .destructive, handler: {action in
            self.navigationController?.popViewController(animated: true)
        })
        
        if(ret != 0) {
            alert_vc.addAction(cancel_action)
        }
        alert_vc.addAction(next_action)
        self.present(alert_vc,animated: true)
    }
    
    @IBAction func commit_code(_ sender: Any) {
        print("to verify")
            SMSSDK.commitVerificationCode(code_textfield.text!, phoneNumber: phone_num_textfield.text!, zone: "86", result: {ret in
                if(ret != nil) {
                    print("verification failed!")
                    self.message_label.isHidden = false
                    self.message_label.text = "验证码错误"
                } else {
                    print("verification passed!")
                    if(self.action_type == "signup") {
                        let vc = Signup_user_info_VC()
                        vc.default_username = "用户_\(self.phone_num_textfield.text!)"
                        vc.phone_num = self.phone_num_textfield.text!
                        self.navigationController?.pushViewController(vc, animated: true)
                        self.code_textfield.resignFirstResponder()
                    } else if (self.action_type == "change_phone_num") { // change phone num
                        if(!check_network_available()) {
                            self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                            return
                        }
                        User.reset_phone_num(new_phone_num: self.phone_num_textfield.text!,complete_handle: self.call_back)
                    } else if (self.action_type == "reset_passwd") {
                        let vc = User_passwd_VC()
                        vc.action_type = "reset_passwd"
                        vc.title_str = "重设密码"
                        vc.phone_num = self.phone_num_textfield.text!
                        self.navigationController?.pushViewController(vc, animated: true)
                    }

                }
            })
    }
    
        // 向外部提供可点击接口
        // 声明闭包,在外面使用时监听按钮的点击事件
        typealias ClickedClosure = (_ sender: UIButton) -> Void
        // 作为此类的属性
        var clickedBlock: ClickedClosure?
        
        
        /// 计时器
        //private var countdownTimer: Timer?
        /// 计时器是否开启(定时器开启的时机)
        var isCounting = false {
            
            willSet {
                  // newValue 为true表示可以计时
                if newValue {
                    countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                    
                } else {
                    // 定时器停止时，定时器关闭时(销毁定时器)
                    countdownTimer?.invalidate()
                    countdownTimer = nil
               }
                
                // 判断按钮的禁用状态 有新值 按钮禁用 无新值按钮不禁用
                 get_code_btn.isEnabled = !newValue
                
            }
        }
        
        /// 剩余多少秒
        var remainingSeconds: Int = 5 {
            
            willSet {
                get_code_btn.setTitleColor(.gray, for: .normal)
                get_code_btn.setTitle("\(newValue)s后重新获取", for: .normal)
                if newValue <= 0 {
                    get_code_btn.setTitleColor(.blue, for: .normal)
                    get_code_btn.setTitle("重新获取", for: .normal)
                    isCounting = false
                }
            }
        }
        
    @objc func sendButtonClick(_ btn:UIButton) {
        if(!phone_num_valid) {
            return
        }
         // 开启计时器
         self.isCounting = true
        // 设置重新获取秒数
       self.remainingSeconds = 60
        
         // 调用闭包
        if clickedBlock != nil {
            self.clickedBlock!(btn)
        }
       
     }
    // 开启定时器走的方法
        @objc func updateTime(_ btn:UIButton) {
            remainingSeconds -= 1
        }
    
    func setupUI() -> Void {
        get_code_btn.setTitle(" 获取验证码 ", for:.normal)
        get_code_btn.setTitleColor(.blue, for: .normal)
        get_code_btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        get_code_btn.backgroundColor = UIColor.white
        get_code_btn.layer.cornerRadius = 12
        get_code_btn.layer.masksToBounds = true
        get_code_btn.layer.borderWidth = 1.0
        get_code_btn.layer.borderColor = UIColor.black.cgColor
        get_code_btn.addTarget(self, action: #selector(sendButtonClick(_:)), for: .touchUpInside)
    }
    
    func init_textview() {
        phone_num_textfield_is_empty = true
        phone_num_textfield.textColor = .gray
        phone_num_textfield.text = PHONE_NUM_PLACEHOLDER
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("to edit:\(phone_num_textfield_is_empty)")
        code_textfield.text = ""
        message_label.isHidden = true

        //phone_num_textfield.textColor = .black
        //phone_num_textfield_is_empty = false
        return true
    }
    
    // 点击空白处时，退出可编辑状态
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("end edit")
        phone_num_textfield.resignFirstResponder()
        code_textfield.resignFirstResponder()
        /*if(phone_num_textfield.text!.count == 0) {
            init_textview()
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
