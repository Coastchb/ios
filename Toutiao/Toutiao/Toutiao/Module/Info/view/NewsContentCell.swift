//
//  NewsContentCell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/8.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class NewsContentCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        // Configure the view for the selected state
    }
        
}
