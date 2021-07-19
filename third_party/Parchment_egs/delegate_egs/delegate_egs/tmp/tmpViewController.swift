//
//  tmpViewController.swift
//  delegate_egs
//
//  Created by coastcao(操海兵) on 2019/10/11.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class tmpViewController: UIViewController {

    @IBAction func a(_ sender: Any) {
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
                        vc.selected_index = 3
                        //self.present(navigation_VC!,animated: true)
                        //self.dismiss(animated: true, completion: nil)
                       // self.transition(from: self, to: navigation_VC!, duration: 0.1, options: UIView.AnimationOptions(), animations: nil, completion: nil)
                        //show(vc, sender: nil)
                        break
                        
                    }
                }
            } while nextResponder != nil

    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
