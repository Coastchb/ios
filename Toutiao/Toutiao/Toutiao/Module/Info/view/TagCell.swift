//
//  TagCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/7.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class TagCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var iconLabel: UILabel!
    
    var is_selected = false
    func show_hide_icon() {
        iconLabel.text = is_selected ? "" : "✅"
        is_selected = !is_selected
    }
    }
