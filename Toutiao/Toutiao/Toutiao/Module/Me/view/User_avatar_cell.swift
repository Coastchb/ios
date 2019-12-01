//
//  User_avatar_cell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/24.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class User_avatar_cell: UITableViewCell {

    @IBOutlet weak var avatar_image_view: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatar_image_view.layer.masksToBounds = true
        self.avatar_image_view.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
