//
//  presentController.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/7.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class presentController: UIViewController, StoryboardLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
