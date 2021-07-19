//
//  ViewController.swift
//  SMSSDK
//
//  Created by coastcao(操海兵) on 2019/12/5.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phone_num: UITextField!
    
    @IBOutlet weak var get_code_btn: UIButton!
    
    @IBOutlet weak var code_label: UITextField!
    private var countdownTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    @IBAction func get_code(_ sender: Any) {
        SMSSDK.getVerificationCode(by: .SMS, phoneNumber: phone_num.text!, zone: "86", template: "", result: {ret in
            print(ret)
            if(ret != nil) {
                print("ERROR!")
            } else {
                print("OK!")
                //self.countDown(timeOut: 60)
                //self.isCounting = true
            }
        })
    }
    
    @IBAction func commit_code(_ sender: Any) {
        SMSSDK.commitVerificationCode(code_label.text!, phoneNumber: phone_num.text!, zone: "86", result: {ret in
            if(ret != nil) {
                print("verification failed!")
            } else {
                print("verification passed!")
                
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
    
}

