//
//  ViewController.swift
//  hangge_2258
//
//  Created by hangge on 2019/1/8.
//  Copyright © 2019年 hangge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //左侧表格
    lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: 0, width: 80,
                                     height: UIScreen.main.bounds.height)
        leftTableView.rowHeight = 55
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.separatorColor = UIColor.clear
        leftTableView.register(LeftTableViewCell.self,
                               forCellReuseIdentifier: "leftTableViewCell")
        return leftTableView
    }()
    
    //右侧表格
    lazy var rightTableView : UITableView = {
        let rightTableView = UITableView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: 80, y: 64,
                                      width: UIScreen.main.bounds.width - 80,
                                      height: UIScreen.main.bounds.height - 64)
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.register(RightTableViewCell.self,
                                forCellReuseIdentifier: "rightTableViewCell")
        return rightTableView
    }()
    
    //左侧表格数据
    var leftTableData = ["前端","后端","数据库","移动端"]//[String]()
    //右侧表格数据
    var rightTableData_raw = ["前端":["HTML","CSS","Bootstrap"], "后端":["C","C++","Python","C#","Java"],"数据库":["SQL","MySQL"],"移动端":["Swift","OC","uni-app"]]
    var rightTableData = [String : [RightTableModel]]()
    
    //右侧表格当前是否正在向下滚动（即true表示手指向上滑动，查看下面内容）
    var rightTableIsScrollDown = true
    //右侧表格垂直偏移量
    var rightTableLastOffsetY : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("000")
        //初始化左侧表格数据
        
        
        //初始化右侧表格数据
        for leftItem in leftTableData {
            var models = [RightTableModel]()
            var c = rightTableData_raw[leftItem]?.count
            for i in 0..<c! {
                models.append(RightTableModel(name: "\(rightTableData_raw[leftItem]![i])",
                    picture: "image", price: Float(i)))
            }
            self.rightTableData[leftItem] = models
        }
        
        print("111")
        //将表格添加到页面上
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        print("222")
        
        //左侧表格默认选中第一项
        //selected_left_row = 0
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true,
                                scrollPosition: .none)
        
        self.rightTableView.tableFooterView = UIView(frame: CGRect.zero)

        print("101010")
        
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    //表格分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        print("\(tableView)")
        print("333")
        return 1
    }
    
    //分区下单元格数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(tableView)")
        print("444")
        if leftTableView == tableView {
            return leftTableData.count
        } else {
            return rightTableData[leftTableData[leftTableView.indexPathForSelectedRow!.row]]!.count //rightTableData[leftTableData[]].count
        }
    }
    
    //返回自定义单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            print("555")
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "leftTableViewCell",
                                                     for: indexPath) as! LeftTableViewCell
            cell.titleLabel.text = leftTableData[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightTableViewCell",
                                                     for: indexPath) as! RightTableViewCell
            let model = (rightTableData[leftTableData[leftTableView.indexPathForSelectedRow!.row]]!)[indexPath.row]
            cell.setData(model)
            return cell
        }
    }
    
    //单元格选中时调用
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击的是左侧单元格时
        print("666")
        if leftTableView == tableView {
            //右侧表格自动滚动到对应的分区
            //rightTableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row),
            //                           at: .top, animated: true)
            //左侧表格将该单元格滚动到顶部
            //leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0),
            //                          at: .top, animated: true)
            
            //selected_left_row = indexPath.row
            
            print("777")
            rightTableView.reloadData()
            print("888")
        }
    }

    /*
    //表格滚动时触发（主要用于记录当前右侧表格时向上还是向下滚动）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("999")
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            rightTableIsScrollDown = rightTableLastOffsetY < scrollView.contentOffset.y
            rightTableLastOffsetY = scrollView.contentOffset.y
        }
    }*/
    
}

