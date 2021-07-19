//
//  Signup_view_model.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import RxSwift
import RxCocoa
 
class SignupViewModel {
     
    //用户名验证结果
    let validatedUsername: Driver<ValidationResult>
     
    //密码验证结果
    let validatedPassword: Driver<ValidationResult>
     
    //再次输入密码验证结果
    let validatedPasswordRepeated: Driver<ValidationResult>
     
    //注册按钮是否可用
    let signupEnabled: Driver<Bool>
     
    //注册结果
    //let signupResult: Driver<Bool>
     
    //ViewModel初始化（根据输入实现对应的输出）
    init(
        input: (
        username: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<Void>
        ),
        dependency: (
        signup_service: SignupService,
        signup_network_service: Singup_network_service
        )) {
         
        //用户名验证
        validatedUsername = input.username
            .flatMapLatest { username in
                return dependency.signup_service.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器发生错误!"))
        }
         
        //用户名密码验证
        validatedPassword = input.password
            .map { password in
                return dependency.signup_service.validatePassword(password)
        }
         
        //重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(
            input.password,
            input.repeatedPassword,
            resultSelector: dependency.signup_service.validateRepeatedPassword)
         
        //注册按钮是否可用
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated
        ) { username, password, repeatPassword in
            username.isValid && password.isValid && repeatPassword.isValid
            }
            .distinctUntilChanged()
         
        
        /*
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            (username: $0, password: $1) }
         
        //注册按钮点击结果
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
                return dependency.signup_network_service.sign_up(user_name:pair.username,passwd: pair.password)
                    .asDriver(onErrorJustReturn: false)
        }*/
    }
}
