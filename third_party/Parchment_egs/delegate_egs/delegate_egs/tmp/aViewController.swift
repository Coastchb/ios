//
//  aViewController.swift
//  delegate_egs
//
//  Created by coastcao(操海兵) on 2019/10/11.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class aViewController: UIViewController {

    @IBAction func jump(_ sender: Any) {
        var nextResponder : UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            //print("\(nextResponder)")
            
            if let responder = nextResponder as? UITabBarController {
                print("got it!")
                //print("\(responder.children.first)")
                var navigation_VC = responder.children.first
                //print("\(navigation_VC?.children.first)")
                
                if let vc = navigation_VC?.children.first as? my_delegate_egs.ViewController {
                    print("ok!")
            
                    vc.selected_index = 2
                    
                }
            }
        } while nextResponder != nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    init(title : String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
