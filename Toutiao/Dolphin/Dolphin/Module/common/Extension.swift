//
//  extension.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/19.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation


//扩展String
extension String {
    //字符串的url地址转义
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

extension Date{
    func isThisYear() -> Bool {
        let calendar = Calendar.current

        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
}

extension UIViewController {
    func prompt(_ str: String,_ delay: Double) {
        let alterVC = UIAlertController(title: nil, message: str, preferredStyle:.alert)
        self.present(alterVC, animated:true)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            alterVC.dismiss(animated: false, completion: nil);
        }
    }
}

extension UIView {
    func prompt(_ str: String, _ delay: Double) {
        let alterVC = UIAlertController(title: nil, message: str, preferredStyle:.alert)
        let vc = self.getFirstViewController()
        vc!.present(alterVC, animated:true)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            alterVC.dismiss(animated: false, completion: nil);
        }
    }
}
