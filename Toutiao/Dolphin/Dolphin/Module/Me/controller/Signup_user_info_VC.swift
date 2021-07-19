//
//  Register_user_info_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Signup_user_info_VC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var user_avatar_view: UIImageView!
    
    @IBOutlet weak var user_passwd_textfield: UITextField!
    @IBOutlet weak var passwd_validation_label: UILabel!
    
    @IBOutlet weak var user_passwd_confirm_textfield: UITextField!
    @IBOutlet weak var passwd_confirm_validation_label: UILabel!
    
    @IBOutlet weak var user_name_textfield: UITextField!
    @IBOutlet weak var username_validation_label: UILabel!

    @IBOutlet weak var signup_btn: UIButton!
    
    @IBOutlet weak var male_btn: RadioButton!
    @IBOutlet weak var female_btn: RadioButton!
    var gender_btns : [RadioButton]?
    var genders = ["男", "女"]
    var selected_gender = "男"
    
    var default_username = ""
    var phone_num = ""
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册新用户"
        
        user_avatar_view.image = UIImage(imageLiteralResourceName: DEFAULT_USER_AVATAR)
        
        self.user_name_textfield.text = default_username
        
        user_name_textfield.delegate = self
        // Do any additional setup after loading the view.
        
        //初始化ViewModel
        let viewModel = SignupViewModel(
            input: (
                username: user_name_textfield.rx.text.orEmpty.asDriver(),
                password: user_passwd_textfield.rx.text.orEmpty.asDriver(),
                repeatedPassword: user_passwd_confirm_textfield.rx.text.orEmpty.asDriver(),
                loginTaps: signup_btn.rx.tap.asSignal()
            ), dependency: (
                signup_service:SignupService(),
                signup_network_service: Singup_network_service()
            )

        )
         
        //用户名验证结果绑定
        viewModel.validatedUsername
            .drive(username_validation_label.rx.validationResult)
            .disposed(by: disposeBag)
         
        //密码验证结果绑定
        viewModel.validatedPassword
            .drive(passwd_validation_label.rx.validationResult)
            .disposed(by: disposeBag)
         
        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated
            .drive(passwd_confirm_validation_label.rx.validationResult)
            .disposed(by: disposeBag)
         
        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.signup_btn.isEnabled = valid
                self?.signup_btn.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)
         
        /*
        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { [unowned self] result in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
            })
            .disposed(by: disposeBag)
        */
        
        gender_btns = [male_btn, female_btn]
        male_btn.isSelected = true
    }


    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        // method 1
       /* for VC in (self.navigationController?.viewControllers)! {
            if VC is Login_VC { // AccountSafetyCtl  是你要返回的控制器（页面）
                self.navigationController?.popToViewController(VC, animated: true)
            }
        }*/
        let signup_ret = Singup_network_service.sign_up(phone_num: phone_num, user_name: user_name_textfield.text!, passwd: user_passwd_textfield.text!, gender: selected_gender, avatar: user_avatar_view.image!)
        
        let alert_message = signup_ret ? "注册成功" : "注册失败"
        let next_message = signup_ret ? "前去登录" : "放弃注册"
        let next_vc_idx = signup_ret ? 1 : 0
        var alert_vc = UIAlertController(title: "", message: alert_message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "重新注册", style: .cancel, handler: nil)
        let next = UIAlertAction(title: next_message, style: .destructive, handler: { action in
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[next_vc_idx])!, animated: true)
        })
        
        if(!signup_ret) {
            alert_vc.addAction(cancel)
        }
        alert_vc.addAction(next)
        self.present(alert_vc, animated: true, completion: nil)
    }
    
    @IBAction func select_avatar(_ sender: Any) {
        let vc = User_avatar_VC()

        vc.init_image = self.user_avatar_view.image!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func select_gender(_ sender: RadioButton) {
        gender_btns?.forEach({$0.isSelected = false})
        sender.isSelected = true
        if let selected_idx = gender_btns?.firstIndex(of: sender) as? Int {
            print("性别是:\(genders[selected_idx])")
            selected_gender = genders[selected_idx]
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.user_avatar_view.layer.masksToBounds = true
        self.user_avatar_view.layer.cornerRadius = CGFloat(AVATAR_CORNER_RADIUS)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    // 点击空白处时，退出可编辑状态
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("end edit")
        user_name_textfield.resignFirstResponder()
        user_passwd_textfield.resignFirstResponder()
        user_passwd_confirm_textfield.resignFirstResponder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("new user avatar path:\(UserDefaults.standard.value(forKey: ANONYMOUS_USER_AVATAR_KEY))")
        if let selected_image_path = UserDefaults.standard.value(forKey: ANONYMOUS_USER_AVATAR_KEY) as? String {
            print(selected_image_path)
            self.user_avatar_view.image = UIImage(imageLiteralResourceName: selected_image_path)
        }
        
        UserDefaults.standard.removeObject(forKey: ANONYMOUS_USER_AVATAR_KEY)
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
