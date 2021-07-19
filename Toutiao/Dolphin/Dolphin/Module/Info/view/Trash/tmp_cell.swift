//
//  tmp_cell.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/28.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class tmp_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBOutlet weak var jump_button: UIButton!
    
    @IBAction func jump(_ sender: Any) {
        var nextResponder: UIResponder? = self
        var target : InfoViewController?
        repeat {
                nextResponder = nextResponder?.next
                //print("\(nextResponder)")
                if let viewController = nextResponder as? InfoViewController {
                    target = viewController
                    break
                }
                
            } while nextResponder != nil

        /*
        var info_VC = InfoViewController()
        info_VC.show_tab_index = 3
        //target?.pushViewController(info_VC, animated: true)
        target?.setViewControllers([info_VC], animated: true)
        print("all VCs: \(target?.viewControllers)") */
        //target?.show_tab_index = 3
        
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
