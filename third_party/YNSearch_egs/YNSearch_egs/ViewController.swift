//
//  ViewController.swift
//  YNSearch_egs
//
//  Created by coastcao(操海兵) on 2019/10/29.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ViewController: YNSearchViewController, YNSearchDelegate {
    func ynCategoryButtonClicked(text: String) {
        push_VC(text: text)
        print("category button clicked")
    }
    
    func ynSearchHistoryButtonClicked(text: String) {
        push_VC(text: text)
        print("search history button clicked")
    }
    
    func ynSearchListViewClicked(key: String) {
        push_VC(text: key)
        print("search list button clicked")
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ynSearchView.ynSearchListView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel {
            cell.searchLabel.text = ynmodel.key
        }
        return cell
    }
    

    class YNDropDownMenu: YNSearchModel {
        var starCount = 512
        var description = "Awesome Dropdown menu for iOS with Swift 3"
        var version = "2.3.0"
        var url = "https://github.com/younatics/YNDropDownMenu"
    }

    class YNSearchData: YNSearchModel {
        var title = "YNSearch"
        var starCount = 271
        var description = "Awesome fully customize search view like Pinterest written in Swift 3"
        var version = "0.3.1"
        var url = "https://github.com/younatics/YNSearch"
    }

    class YNExpandableCell: YNSearchModel {
        var title = "YNExpandableCell"
        var starCount = 191
        var description = "Awesome expandable, collapsible tableview cell for iOS written in Swift 3"
        var version = "1.1.0"
        var url = "https://github.com/younatics/YNExpandableCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let categories = ["Java", "C", "C++", "PHP", "Javascript", "HTML", "OC", "Swift", "GO"]
        let search_histories = ["OC", "Swift"]
        
        let yn_search = YNSearch()
        yn_search.setCategories(value: categories)
        yn_search.setSearchHistories(value: search_histories)
        
        self.ynSearchinit()
        
        self.delegate = self
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let database1 = YNDropDownMenu(key: "YNDropDownMenu")
        let database2 = YNSearchData(key: "YNSearchData")
        let database3 = YNExpandableCell(key: "YNExpandableCell")
        let demoDatabase = [database1, database2, database3]
        
        self.initData(database: demoDatabase)
        self.setYNCategoryButtonType(type: .colorful)
    }
    
    func push_VC(text: String) {
        var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detail") as! DetailVC
        vc.text = text
        
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

