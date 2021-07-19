//
//  Validation_result.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
 
//验证结果和信息的枚举
enum ValidationResult {
    case validating  //正在验证中s
    case empty  //输入为空
    case ok(message: String) //验证通过
    case failed(message: String)  //验证失败
}
 
//扩展ValidationResult，对应不同的验证结果返回验证是成功还是失败
extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
 
//扩展ValidationResult，对应不同的验证结果返回不同的文字描述
extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .validating:
            return "正在验证..."
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
}
 
//扩展ValidationResult，对应不同的验证结果返回不同的文字颜色
extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed:
            return UIColor.red
        }
    }
}


enum Validatation_ret_for_channge_passwd {
    case ok
    case wrong_old_passwd
    case other_error
    
    
}

extension Validatation_ret_for_channge_passwd {
    var message: String {
        switch self {
        case .ok:
            return "修改成功!"
        case .wrong_old_passwd:
            return "原密码错误!"
        case .other_error:
            return "未知错误!"
        }
        
    }
}
