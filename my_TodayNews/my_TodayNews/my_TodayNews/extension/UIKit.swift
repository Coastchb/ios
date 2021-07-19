//
//  UIKit.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/7.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit


protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    /// 提供 加载方法
    static func loadStoryboard() -> Self {
        print("ok 0:\(self)")
        let ns_ob = try? UIStoryboard(name: "myTodayNews", bundle: nil)
        print("ok 1")
        let vc = ns_ob?.instantiateViewController(withIdentifier: "\(self)")
        print("ok 2")
        return vc as! Self
    }
}
