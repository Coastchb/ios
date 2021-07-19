//
//  DetailVC.swift
//  YNSearch_egs
//
//  Created by coastcao(操海兵) on 2019/10/29.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var text : String?
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel?.text = text
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
