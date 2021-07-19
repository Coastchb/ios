//
//  StaticVC.swift
//  SGPagingViewExample
//
//  Created by kingsic on 2018/9/15.
//  Copyright © 2018年 kingsic. All rights reserved.
//

import UIKit

class StaticVC: UIViewController {

    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentScrollView: SGPageContentScrollView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupSGPagingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("StaticVC - - deinit")
    }
}

extension StaticVC {
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let titles = ["精选", "请等待2s", "QQGroup", "429899752","精选", "请等待2s", "QQGroup", "429899752"]
        let configure = SGPageTitleViewConfigure()
        configure.indicatorScrollStyle = .Default
        configure.indicatorStyle = .Default
        configure.indicatorHeight = 5
        configure.indicatorCornerRadius = 5
        configure.indicatorToBottomDistance = 5
        configure.titleFont = UIFont.systemFont(ofSize: 12)
        configure.titleSelectedFont = UIFont.systemFont(ofSize: 16)
        configure.bottomSeparatorColor = UIColor.red

        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 44), delegate: self, titleNames: titles, configure: configure)
        pageTitleView?.index = 1
        view.addSubview(pageTitleView!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.pageTitleView?.resetTitle(title: "等待已结束", index: 1)
        }
        
        let oneVC = ChildOneVC()
        let twoVC = ChildTwoVC()
        let threeVC = ChildThreeVC()
        let fourVC = ChildFourVC()
        let childVCs = [oneVC, twoVC, threeVC, fourVC, oneVC, twoVC, threeVC, fourVC]

        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentScrollView = SGPageContentScrollView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentScrollView?.delegateScrollView = self
        view.addSubview(pageContentScrollView!)
    }
}

extension StaticVC: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentScrollView?.setPageContentScrollView(index: index)
    }
    
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        print("scrolled content view from \(originalIndex) to \(targetIndex)")
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, index: Int) {
        /// 说明：在此获取标题or当前子控制器下标值
        print("index - - %ld", index)
    }
}


