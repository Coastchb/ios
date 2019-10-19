//
//  NoLoginCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/13.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class LoginCell: UITableViewCell {

    @IBOutlet weak var user_avatar: UIImageView!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var name_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.user_avatar.image = UIImage(imageLiteralResourceName: "avatar_moren")
        // Initialization code
    }

    @IBAction func login_btClicked(_ sender: Any) {

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
