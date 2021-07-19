//
//  ViewController.swift
//  PageView
//
//  Created by coastcao(操海兵) on 2020/2/28.
//  Copyright © 2020 One-Zero. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var allViewControllers: [UIViewController] = [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "a"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "b"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "c")]
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                guard let viewControllerIndex = allViewControllers.firstIndex(of: viewController) else {
                return nil
            }
             
            let previousIndex = viewControllerIndex - 1
             
            guard previousIndex >= 0 else {
                return nil
            }
             
            guard allViewControllers.count > previousIndex else {
                return nil
            }
             
            return allViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.firstIndex(of:viewController) else {
            return nil
        }
         
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = allViewControllers.count
         
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
         
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
         
        return allViewControllers[nextIndex]
    }
    
         
        //页面加载完毕
        override func viewDidLoad() {
            super.viewDidLoad()
             

            //数据源设置
            dataSource = self
            delegate = self
             
            //设置首页
            self.setViewControllers([allViewControllers.first!], direction: .forward, animated: true, completion: nil)
 
        }
         

         
         

}

