//
//  ViewController.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/7.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rd1: UILabel!
    
    @IBOutlet weak var rd2: UILabel!
    
    //@IBOutlet weak var rd3: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        rd1.isHidden = false
        rd2.isHidden = true
        //rd3.isHidden = true
        
        // Do any additional setup after loading the view.
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
