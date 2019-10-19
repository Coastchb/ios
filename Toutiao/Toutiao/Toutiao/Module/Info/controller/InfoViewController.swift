//
//  InfoViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/25.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let titles = ["哥哥", "老公", "噩梦"]
    
    var show_tab_index = 0 {
        didSet {
            self.pagingViewController.select(index: show_tab_index)
        }
    }

    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "national_day4.jpg")) //color
    }
    
    let pagingViewController = PagingViewController<PagingIndexItem>()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setStatusBarBackgroundColor(color: .red)

        navigationItem.titleView = Bundle.main.loadNibNamed("pageHeader", owner: nil, options: nil)?.last as? UIView
        //navigationItem.titleView?.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        //self.navigationItem.titleView?.backgroundColor = .black

        //view.backgroundColor = UIColor.white
        //view.contentMode = .scaleToFill
        
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        
        // Add the paging view controller as a child view controller and
        // contrain it to all edges.
        addChild(pagingViewController)
        pagingViewController.menuHorizontalAlignment = .center
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        print("DynamicVC - - deinit")
    }
}


extension InfoViewController: PagingViewControllerDataSource {
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
    return PagingIndexItem(index: index, title: self.titles[index]) as! T
  }
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
    if(index == 0){
        return RecommendVC()
    } else if (index == 1) {
        return RecommendVC_2()
    } else {
        return RecommendVC_3()
    }

  }
  
  func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
    return self.titles.count
    
    }
  
}

extension InfoViewController: PagingViewControllerDelegate {
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
    guard let item = pagingItem as? PagingIndexItem else { return 0 }

    let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let size = CGSize(width: 375, height: pagingViewController.menuItemSize.height)
    let attributes = [NSAttributedString.Key.font: pagingViewController.font]
    
    let rect = item.title.boundingRect(with: size,
      options: .usesLineFragmentOrigin,
      attributes: attributes,
      context: nil)

    let width = ceil(rect.width) + insets.left + insets.right
    
    if isSelected {
      return width // * 1.5
    } else {
      return width
    }
  }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, didScrollToItem pagingItem: T, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        pagingViewController.select(pagingItem: pagingItem, animated: true)
    }
}
