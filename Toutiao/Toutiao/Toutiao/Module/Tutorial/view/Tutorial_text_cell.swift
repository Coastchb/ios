//
//  NewsListCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/29.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Tutorial_text_cell: UITableViewCell {

    var item_type : String?
    var item_id : Int?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAbstractLabel: UILabel!
    @IBOutlet weak var newsPicture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.newsTitleLabel.numberOfLines = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func unfold(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil,
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let starAction = UIAlertAction(title: "收藏", style: .destructive) { action in
            
            /*
            var stared_items = [Content_item]()
            print("ok -1")
            if let stared_list =  UserDefaults.standard.array(forKey: "stared_items") as? [Content_item] {
                stared_list.forEach { item in
                    stared_items.append(item)
                }
            }
            if(!stared_items.contains(self.content_item!)) {
                stared_items.append(self.content_item!)
            }
            print("ok 0")
            
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: stared_items)
            UserDefaults.standard.setValue(encodedObject, forKey: "stared_items")
            UserDefaults.standard.synchronize() */
            
            print("ook 0")
            var ret = ""
            if(Stared_item.add_stared_item(type: self.item_type!, id: self.item_id!)) {
                ret = "已收藏"
            }else {
                ret = "收藏失败"
            }
            
            print("ook 1")
            let promptController = UIAlertController(title: nil, message: ret,
                                                     preferredStyle: .alert)
            let vc = self.getFirstViewController()
            vc!.present(promptController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                        promptController.dismiss(animated: false, completion: nil);
                    }

            
        }
        //let scoreAction = UIAlertAction(title: "打分", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(starAction)
        //alertController.addAction(scoreAction)
        let vc = self.getFirstViewController()
        vc!.present(alertController, animated: true, completion: nil)
   
    }
}

/*
extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRectMake(0, 0, reSize.width, reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? <#default value#>;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
     
    /**
     *  等比率缩放
     */0
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}*/
