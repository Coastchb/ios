//
//  NewsListCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/29.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Info_cell: UITableViewCell {

    var item_type : String?
    var item_id : Int?
    
    var stared = false {
        didSet {
            set_star_btn()
        }
    }
    
    @IBOutlet weak var icon_image: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAbstractLabel: UILabel!
    @IBOutlet weak var star_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.icon_image.layer.masksToBounds = true
        self.icon_image.layer.cornerRadius = CGFloat(LOGO_CORNER_RADIUS)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func get_btn_prompt(action: Bool, action_str: String) -> String {
        return action ? "已\(action_str)" : "\(action_str)"
    }
    
    func set_star_btn() {
        star_btn.setTitleColor(stared ? .gray : .black, for: .normal)
        var prompt_str = stared ? "已收藏" : "收藏"
        star_btn.setTitle("\(prompt_str)", for: .normal)
    }
    
    @IBAction func star(_ sender: Any) {
        if(!User.is_logined()) {
            self.prompt("请登录后操作", 1)
        } else {
            if (!check_network_available()) {
                self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                return
            }
            
            print("\n\(newsTitleLabel.text) is stared by \(User.get_user_name())")
            
            if (stared) {
                var star_info = get_related_info(info_type: "star", item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                
                if(star_info == (-1,-1)) {
                    self.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
                    return
                }
                
                if (star_info.1 >= 1) {
                    var ret = remove_star(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                    if (!ret) {
                        prompt("取消收藏失败", 1)
                        return
                    }
                }
                prompt("已取消收藏", 1)
            } else {
                // add this to recommendation table
                var ret = add_star(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                if (ret) {
                    prompt("已收藏", 1)
                } else {
                    prompt("收藏失败", 1)
                    return
                }
            }
            stared = !stared
        }
    }
}
