//
//  InfoViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/25.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentCollectionView: SGPageContentCollectionView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setupSGPagingView()
    }
    
    deinit {
        print("DynamicVC - - deinit")
    }
}

extension InfoViewController {
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let titles = ["精选", "电影", "电视剧", "综艺", "NBA", "娱乐", "动漫", "演唱会", "VIP会员"]
        let configure = SGPageTitleViewConfigure()
        configure.indicatorStyle = .Dynamic
        configure.titleAdditionalWidth = 35
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 44), delegate: self, titleNames: titles, configure: configure)
        view.addSubview(pageTitleView!)
        
        let oneVC = RecommendVC()
        /*let twoVC = ChildTwoVC()
         let threeVC = ChildThreeVC()
         let fourVC = ChildFourVC()
         let fiveVC = ChildFiveVC()
         let sixVC = ChildSixVC()
         let sevenVC = ChildSevenVC()
         let eightVC = ChildEightVC()
         let nineVC = ChildNineVC()
         */
        let childVCs = [oneVC] //, twoVC, threeVC, fourVC, fiveVC, sixVC, sevenVC, eightVC, nineVC]
        
        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentCollectionView?.delegateCollectionView = self
        view.addSubview(pageContentCollectionView!)
    }
}

extension InfoViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentCollectionView?.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
