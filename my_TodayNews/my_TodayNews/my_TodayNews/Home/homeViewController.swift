//
//  homeViewController.swift
//  my_TodayNews
//
//  Created by coastcao(操海兵) on 2019/10/2.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSGPagingView()
        // Do any additional setup after loading the view.
    }
    
    private var pageTitleView : SGPageTitleView?
    private var pageContentCollectionView : SGPageContentCollectionView?


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension homeViewController {
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let titles = ["问答", "电影", "电视剧", "综艺", "NBA", "娱乐", "动漫", "演唱会", "VIP会员"]
        let configure = SGPageTitleViewConfigure()
        configure.titleColor = .black
        configure.titleSelectedColor = .red
        configure.indicatorColor = .clear
        configure.indicatorStyle = .Dynamic
        //configure.titleAdditionalWidth = 35
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: screenWidth - newsTitleHeight, height: newsTitleHeight), delegate: self, titleNames: titles, configure: configure)
        self.pageTitleView?.backgroundColor = .clear
        view.addSubview(pageTitleView!)
        
        let wenda_VC = WendaViewController()
        let two_VC = tmpHomeViewController()
        
        /*
         let threeVC = ChildThreeVC()
         let fourVC = ChildFourVC()
         let fiveVC = ChildFiveVC()
         let sixVC = ChildSixVC()
         let sevenVC = ChildSevenVC()
         let eightVC = ChildEightVC()
         let nineVC = ChildNineVC()
         */
        let childVCs = [two_VC, wenda_VC]
        
        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentCollectionView?.delegateCollectionView = self
        view.addSubview(pageContentCollectionView!)
        
    }
}

extension homeViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentCollectionView?.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
