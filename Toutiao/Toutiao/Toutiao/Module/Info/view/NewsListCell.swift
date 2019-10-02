//
//  NewsListCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/29.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class NewsListCell: UITableViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAbstractLabel: UILabel!
    @IBOutlet weak var newsPicture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
