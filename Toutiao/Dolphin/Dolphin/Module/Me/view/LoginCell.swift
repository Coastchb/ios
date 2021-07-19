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
        /*= {
    let view = UIImageView()
    view.image = UIImage(named: "imageName.png")
    view.layer.cornerRadius = 15

    view.clipsToBounds = true //A:调用控件的clipsToBounds为true即可
    return view
    }()*/
    
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var reputation_label: UILabel!
    

    override func awakeFromNib() {
        print("初始化 logincell")
        super.awakeFromNib()
        self.user_avatar.image = UIImage(imageLiteralResourceName: DEFAULT_USER_AVATAR)
        
        self.user_avatar.layer.masksToBounds = true
        self.user_avatar.layer.cornerRadius = CGFloat(AVATAR_CORNER_RADIUS)
        //self.user_avatar.layer.cornerRadius = user_avatar.frame.width / 2
        
    }

    @IBAction func login_btClicked(_ sender: Any) {

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
