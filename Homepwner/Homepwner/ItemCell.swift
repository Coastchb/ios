//
//  ItemCell.swift
//  Homepwner
//
//  Created by 操海兵 on 2019/7/3.
//  Copyright © 2019 Coast. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    /* {
        willSet(newVal){
            if let t = newVal?.attributedText?.string, let v = Int(t)  {
                print(v)
                if(v < 50) {
                    valueLabel.textColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                } else {
                    valueLabel.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                }
            }
            print(newVal)
            print(newVal?.attributedText?.string)
            //print(Int(valueLabel?.attributedText?.string)!)
        }
        
        didSet{
            if let t = valueLabel?.attributedText?.string, let v = Int(t)  {
                print(v)
                if(v < 50) {
                    valueLabel.textColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                } else {
                    valueLabel.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                }
            }
            print(valueLabel)
            print(valueLabel?.attributedText?.string)
            //print(Int(valueLabel?.attributedText?.string)!)
        }
    }*/

    
    //editingAccessoryView.backgroundColor = [UIColor clearColor];

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
        
        /*print(Int(valueLabel.text!))
        */
        
    }
}
