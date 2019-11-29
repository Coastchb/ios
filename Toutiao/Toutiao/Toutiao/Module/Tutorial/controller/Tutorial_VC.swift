//
//  VideoViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/2.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentCollectionView: SGPageContentCollectionView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "优质教程"
        setupSGPagingView()
    }
      
    override func viewDidAppear(_ animated: Bool) {

    }
    deinit {
        print("DynamicVC - - deinit")
    }
}



  extension TutorialViewController {
      private func setupSGPagingView() {
          let statusHeight = UIApplication.shared.statusBarFrame.height
          var pageTitleViewY: CGFloat = 0.0
        
          if statusHeight == 20 {
              pageTitleViewY = 64
          } else {
              pageTitleViewY = 88
          }
        
        var titles = ["图文", "视频"]
          let configure = SGPageTitleViewConfigure()
          configure.indicatorStyle = .Dynamic
          configure.titleAdditionalWidth = 35
          
          self.pageTitleView = SGPageTitleView(frame: CGRect(x: view.frame.size.width/4, y: pageTitleViewY, width: view.frame.size.width/2, height: 44), delegate: self, titleNames: titles, configure: configure)
          //view.addSubview(pageTitleView!)
        self.navigationItem.titleView = pageTitleView
          
        let tutorial_text_VC = Tutorial_text()
        let tutorial_video_VC = Tutorial_video()


          
          let childVCs = [tutorial_text_VC, tutorial_video_VC]
          
          let contentViewHeight = view.frame.size.height //- self.pageTitleView!.frame.maxY
          let contentRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: contentViewHeight)
          self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
          pageContentCollectionView?.delegateCollectionView = self
          view.addSubview(pageContentCollectionView!)
      }
  }

  extension TutorialViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
      func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
          pageContentCollectionView?.setPageContentCollectionView(index: index)
      }
      
      func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
          pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
      }
  }



