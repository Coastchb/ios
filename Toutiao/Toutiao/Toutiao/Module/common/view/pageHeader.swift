//
//  pageHeader.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/2.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class pageHeader: UIView {
        
    @IBOutlet weak var infoSearchBar: UISearchBar!
    
    @IBOutlet weak var searchBar_trailing: NSLayoutConstraint!
    
    @IBOutlet weak var cancel_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        //directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        //self.contentView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "national_day4.jpg"))
       // self.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        infoSearchBar.searchTextField.borderStyle = .roundedRect
        //infoSearchBar.showsCancelButton = false
        cancel_btn.isHidden = true
    }

    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            print("4:\(UIScreen.main.bounds.width)")
            super.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width
                , height: 44)
        }
    }
    
    override var directionalLayoutMargins: NSDirectionalEdgeInsets {
        didSet {
            super.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        }
    }
}
