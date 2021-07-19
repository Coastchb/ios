//
//  Tutorial_text_cell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2020/1/5.
//  Copyright © 2020 coastcao(操海兵). All rights reserved.
//

import UIKit

class Tutorial_text_cell: UITableViewCell {
    var item_type : String?
    var item_id : Int?
    
    var recommend_num = 10 // get recommend num from recommendation table based on item_type and item_id
    var star_num = 10
    var thanks_num = 10
    
    var recommended = false { // get recommend status from recommendation table
        didSet {
            set_recomend_btn(btn: self.recommend_btn, action: self.recommended, action_str: "推荐", num: recommend_num)
        }
    }
    
    var stared = false {
        didSet {
            set_btn(btn: self.star_btn, action: self.stared, action_str: "收藏", num: star_num)
        }
    }
    
    var thanked = false {
        didSet {
            set_btn(btn: thanks_btn, action: self.thanked, action_str: "感谢", num: thanks_num)
        }
    }
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tutorialTitleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var icon_image: UIImageView!
    
    @IBOutlet weak var recommend_btn: UIButton!
    @IBOutlet weak var star_btn: UIButton!
    @IBOutlet weak var thanks_btn: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var unfoldSign: UIButton!
    
    func get_btn_prompt(action: Bool, action_str: String) -> String {
        return action ? "已\(action_str)" : "\(action_str)"
    }
    
    func set_btn(btn: UIButton, action: Bool, action_str: String, num: Int) {
        thanks_btn.isEnabled = !self.thanked

        btn.setTitleColor(action ? .gray : .black, for: .normal)
        btn.setTitle("\(get_btn_prompt(action: action, action_str: action_str))", for: .normal)
    }
    
    func set_recomend_btn(btn: UIButton, action: Bool, action_str: String, num: Int) {
        btn.setTitleColor(action ? .gray : .black, for: .normal)
        btn.setTitle("\(get_btn_prompt(action: action, action_str: action_str))(\(num))", for: .normal)
    }

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

    @IBAction func recommend(_ sender: Any) {
        if(!User.is_logined()) {
            self.prompt("请登录后操作", 1)
        } else {
            if (!check_network_available()) {
                self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                return
            }
            if(SERVER_CRASHED) {
                self.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
                return
            }
           // get_recommendation_info(item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
            print("\n\(tutorialTitleLabel.text) is recommended by \(User.get_user_name())")
            print("before:\(recommended)--\(recommend_num)")
            
            if (recommended) {
                // remove this to recommendation table
                var ret = remove_recommendation(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                if (ret) {
                    prompt("已取消推荐", 1)
                    recommend_num -= 1
                } else {
                    prompt("取消推荐失败", 1)
                    return
                }
            } else {
                // add this to recommendation table
                var ret = add_recommendation(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                if (ret) {
                    prompt("已推荐", 1)
                    recommend_num += 1
                } else {
                    prompt("推荐失败", 1)
                    return
                }
            }
            recommended = !recommended
            print("after:\(recommended)--\(recommend_num)")
        }
    }

    @IBAction func star(_ sender: Any) {
        if(!User.is_logined()) {
            self.prompt("请登录后操作", 1)
        } else {
            if (!check_network_available()) {
                self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                return
            }
            if(SERVER_CRASHED) {
                self.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
                return
            }
           // get_recommendation_info(item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
            print("\n\(tutorialTitleLabel.text) is stared by \(User.get_user_name())")
            print("before:\(stared)--\(star_num)")
            
            if (stared) {
                var star_info = get_related_info(info_type: "star", item_type: self.item_type!, item_id: self.item_id!, user_id: User.get_user_id() ?? "-1")

                if(star_info == (-1,-1)) {
                    self.prompt(SERVER_CRASH_PROMPT, SERVER_CRASH_PROMPT_DELAY)
                    return
                }
                
                if (star_info.1 >= 1) {
                    var ret = remove_star(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                    if (!ret) {
                        self.prompt("取消收藏失败", 1)
                        return
                    }
                }
                star_num -= 1
                self.prompt("已取消收藏", 1)
            } else {
                // add this to recommendation table
                var ret = add_star(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id()!)
                if (ret) {
                    self.prompt("已收藏", 1)
                    star_num += 1
                } else {
                    self.prompt("收藏失败", 1)
                    return
                }
            }
            stared = !stared
            print("after:\(stared)--\(star_num)")
        }
    }

    @IBAction func thanks(_ sender: Any) {
        print("before thanks, \(thanked) -- \(thanks_btn.isEnabled)")
        if (!User.is_logined()) {
            self.prompt("请登录后操作", 1)
        } else {
            if (!check_network_available()) {
                self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                return
            }
            print("you are thanked by \(User.get_user_name())")
            var ret = add_thanks(tableCell: self, item_type: item_type!, item_id: item_id!, user_id: User.get_user_id() ?? "-1")
            if(ret) {
                self.prompt("已感谢上传者", 1)
                thanked = !thanked
            } else {
                self.prompt("感谢上传者失败", 1)
            }
        }
    }
}
