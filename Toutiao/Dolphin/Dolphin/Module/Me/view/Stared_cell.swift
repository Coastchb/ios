//
//  staredCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/16.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Stared_cell: UITableViewCell {

    @IBOutlet weak var tag_label: UILabel!

    @IBOutlet weak var title_label: UILabel!
    
    @IBOutlet weak var abstract_label: UILabel!
    
    @IBOutlet weak var image_view: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
