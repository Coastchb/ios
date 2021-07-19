//
//  ViewController.swift
//  SGPagingViewExample
//
//  Created by kingsic on 2018/9/15.
//  Copyright © 2018年 kingsic. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let titles = ["静止样式", "滚动样式", "文字渐变效果", "文字缩放效果", "指示器固定样式", "指示器动态样式"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let staticVC = StaticVC()
            navigationController?.pushViewController(staticVC, animated: true)
        } else if indexPath.row == 1 {
            let scrollVC = ScrollVC()
            navigationController?.pushViewController(scrollVC, animated: true)
        } else if indexPath.row == 2 {
            let gradientEffectVC = GradientEffectVC()
            navigationController?.pushViewController(gradientEffectVC, animated: true)
        } else if indexPath.row == 3 {
            let zoomVC = ZoomVC()
            navigationController?.pushViewController(zoomVC, animated: true)
        } else if indexPath.row == 4 {
            let fixedVC = FixedVC()
            navigationController?.pushViewController(fixedVC, animated: true)
        } else {
            let dynamicVC = DynamicVC()
            navigationController?.pushViewController(dynamicVC, animated: true)
        }
    }
}

