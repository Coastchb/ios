//
//  myNavigationController.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/2.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class myNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("nivagation loaded...")

        // Do any additional setup after loading the view.
    }
    
    
    
    //拦截push操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //print("view controllers count:\(self.viewControllers.count)")
        if(self.viewControllers.count > 1) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
        
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
