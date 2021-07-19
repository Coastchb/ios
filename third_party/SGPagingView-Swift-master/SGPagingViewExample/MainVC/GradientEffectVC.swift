//
//  GradientEffectVC.swift
//  SGPagingViewExample
//
//  Created by kingsic on 2018/9/15.
//  Copyright © 2018年 kingsic. All rights reserved.
//

import UIKit

class GradientEffectVC: UIViewController {
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentCollectionView: SGPageContentCollectionView? = nil
    
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
        print("GradientEffectVC - - deinit")
    }
}

extension GradientEffectVC {
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let titles = ["精选", "电影", "电视剧", "综艺"]
        let configure = SGPageTitleViewConfigure()
        configure.titleColor = UIColor.lightGray
        configure.titleSelectedColor = UIColor.black
        configure.indicatorColor = UIColor.black
        configure.indicatorAdditionalWidth = 80
        configure.titleGradientEffect = true
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 44), delegate: self, titleNames: titles, configure: configure)
        view.addSubview(pageTitleView!)
        
        let oneVC = ChildOneVC()
        let twoVC = ChildTwoVC()
        let threeVC = ChildThreeVC()
        let fourVC = ChildFourVC()
        let childVCs = [oneVC, twoVC, threeVC, fourVC]
        
        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentCollectionView?.delegateCollectionView = self
        view.addSubview(pageContentCollectionView!)
    }
}

extension GradientEffectVC: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentCollectionView?.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}

