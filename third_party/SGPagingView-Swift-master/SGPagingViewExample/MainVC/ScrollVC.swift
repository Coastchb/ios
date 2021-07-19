//
//  ScrollVC.swift
//  SGPagingViewExample
//
//  Created by kingsic on 2018/9/15.
//  Copyright © 2018年 kingsic. All rights reserved.
//

import UIKit

class ScrollVC: UIViewController {
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentScrollView: SGPageContentScrollView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setupSGPagingView()
    }
    
    deinit {
        print("ScrollVC - - deinit")
    }
}

extension ScrollVC {
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let titles = ["精选", "电影", "电视剧", "综艺", "NBA", "娱乐", "动漫", "演唱会", "VIP会员","精选", "电影", "电视剧", "综艺", "NBA", "娱乐", "动漫", "演唱会", "VIP会员"]
        let configure = SGPageTitleViewConfigure()
        configure.indicatorAdditionalWidth = 10 // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
        configure.titleGradientEffect = true
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 44), delegate: self, titleNames: titles, configure: configure)
        view.addSubview(pageTitleView!)
        pageTitleView?.addBadge(index: 1)
        pageTitleView?.addBadge(index: 5)
        
        let oneVC = ChildOneVC()
        let twoVC = ChildTwoVC()
        let threeVC = ChildThreeVC()
        let fourVC = ChildFourVC()
        let fiveVC = ChildFiveVC()
        let sixVC = ChildSixVC()
        let sevenVC = ChildSevenVC()
        let eightVC = ChildEightVC()
        let nineVC = ChildNineVC()

        let childVCs = [oneVC, twoVC, threeVC, fourVC, fiveVC, sixVC, sevenVC, eightVC, nineVC,oneVC, twoVC, threeVC, fourVC, fiveVC, sixVC, sevenVC, eightVC, nineVC]
        
        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentScrollView = SGPageContentScrollView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentScrollView?.delegateScrollView = self
        view.addSubview(pageContentScrollView!)
    }
}

extension ScrollVC: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentScrollView?.setPageContentScrollView(index: index)
    }
    
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, index: Int) {
        if index == 1 || index == 5 {
            pageTitleView?.removeBadge(index: index)
        }
    }
}


