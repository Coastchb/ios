//
//  add_tag_btn.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/29.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class add_tag_btn: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func add_tag(_ sender: Any) {
        print("to add")
    }
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 20, width: 130
                , height: 20)
        }
    }

}
