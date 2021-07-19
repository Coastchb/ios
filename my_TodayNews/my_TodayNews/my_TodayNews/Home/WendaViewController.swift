//
//  WendaViewController.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/2.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class WendaViewController: UIViewController {

    @IBOutlet weak var Rd1: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var rd1_width: NSLayoutConstraint!
    @IBOutlet weak var haha_leading: NSLayoutConstraint!
    
    @IBOutlet weak var answerButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBAction func a(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var hot = false
        if (!hot) {
            //print(rd1_width)
            rd1_width.constant = 0
            haha_leading.constant = 0
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
