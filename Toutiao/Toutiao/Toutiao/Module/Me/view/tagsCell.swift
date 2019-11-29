//
//  tagsCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/13.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class tagsCell: UICollectionViewCell {

    var tag_id : Int = 0
    @IBOutlet weak var tag_name: UILabel!
    
    @IBOutlet weak var icon_label: UILabel!
    
    var is_selected = false {
        didSet{
            icon_label.text = is_selected ? "✅" : ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func show_hide_icon() {
        print("old tags:\(Tag_item.get_user_tags(user_name: User.get_user_name()))")
        is_selected = !is_selected
                
        print("\(self.tag_name.text) is selected:\(is_selected) now")
        
        if(is_selected){
            Tag_item.add_tag(tag_id: tag_id)
        } else{
            Tag_item.remove_tag(tag_id: tag_id)
        }

        print("new tags:\(Tag_item.get_user_tags(user_name: User.get_user_name()))")
        
        if(!User.is_logined()) {
            let alterVC = UIAlertController(title: nil, message: "建议您先登录", preferredStyle:.alert)
            let vc = self.getFirstViewController()
            vc!.present(alterVC, animated:true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                        alterVC.dismiss(animated: false, completion: nil);
                    }
        }


        
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width
                , height: 30)
        }
    }
}
