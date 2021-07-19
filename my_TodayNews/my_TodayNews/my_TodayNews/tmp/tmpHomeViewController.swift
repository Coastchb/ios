//
//  tmpHomeViewController.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/7.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class tmpHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func present(_ sender: Any) {
        print("ok 0")
        let present_vc = presentController.loadStoryboard()
        
        present(present_vc, animated: true, completion: nil)
    }
    
    @IBAction func push(_ sender: Any) {
        let push_vc = pushViewController.loadStoryboard()
        navigationController?.pushViewController(push_vc, animated: true)
    }
    
    //override func awakeFromNib() {
    //    super.awakeFromNib()
    //}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
