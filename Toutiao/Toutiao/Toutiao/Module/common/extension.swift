//
//  extension.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/19.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation


extension UITextField {
    func get_text(default_str: String) -> String {
        if self.text! == "" {
            return default_str
        } else {
            return self.text!
        }
    }
}

extension UITextView {
    func get_text(default_str: String) -> String {
        if self.text! == "" {
            return default_str
        } else {
            return self.text!
        }
    }
}
