//
//  ChildViewController.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var promptLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateIndexLabel()
    }
    
    private func updateIndexLabel() {
        if let index = (pageboyParent as? PageViewController)?.viewControllers.firstIndex(of: self) {
            label.text = "Page " + String(index + 1)
            
            let isFirstPage = index == 0
            
            var prompt = "(Index \(index))"
            if isFirstPage {
                prompt.append("\n\nswipe me >")
            }
            promptLabel.text = prompt
        }
    }
}
