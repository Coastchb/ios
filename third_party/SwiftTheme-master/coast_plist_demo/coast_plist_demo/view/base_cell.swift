//
//  base_cell.swift
//  coast_plist_demo
//
//  Created by coastcao(操海兵) on 2019/10/4.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class base_cell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        print("ok 1")
        theme_backgroundColor = "Global.barTextColor"
        print("ok 2")
    }
}
