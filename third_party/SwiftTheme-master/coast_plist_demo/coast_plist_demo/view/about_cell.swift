//
//  about_cell.swift
//  coast_plist_demo
//
//  Created by coastcao(操海兵) on 2019/10/4.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class about_cell : base_cell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("ok 3")
        theme_backgroundColor = "Global.barTextColor"
        //label.theme_textColor = "Global.textColor"
       // label.theme_textColor = "Global.textColor"
        //label.theme_textColor = "Global.barTextColor"
        //theme_backgroundColor = "Global.backgroundColor"
    }
    
}
