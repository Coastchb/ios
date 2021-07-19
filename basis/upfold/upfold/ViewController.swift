//
//  ViewController.swift
//  upfold
//
//  Created by coastcao(操海兵) on 2020/5/25.
//  Copyright © 2020 One-Zero. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?
    var sectionArray:NSMutableArray?
    var currentSection:NSInteger?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30));
        backBtn.setTitle("返回", for: .normal);
        backBtn.setTitleColor(UIColor.black, for: .normal);
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn);
        
        sectionArray = NSMutableArray.init();
        for i in 1...10 {
            let isOpen = false;
            sectionArray?.add(isOpen);
            print(i);
        }
        
        tableView = UITableView.init(frame: self.view.frame, style: .plain);
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.separatorStyle = .none;
        tableView?.estimatedSectionFooterHeight = 0;
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "sectionCell")
        self.view.addSubview(tableView!);
        
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (sectionArray?.count)!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView();
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 50));
        headView.backgroundColor = UIColor.lightGray;
        let btn = UIButton.init(frame: CGRect.init(x: 15, y: 0, width: self.view.frame.size.width - 30, height: 50));
        btn.setTitle("第\(section)组", for: .normal);
        btn.contentHorizontalAlignment = .left;
        btn.tag = section;
        btn.addTarget(self, action: #selector(reloadData(sender:)), for: .touchUpInside);
        headView.addSubview(btn);
        return headView;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isOpen = sectionArray![indexPath.section] as! Bool;
        if isOpen {
            return 50;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell");
        cell?.textLabel?.text = "第\(indexPath.section)组第\(indexPath.row)个";
        cell?.textLabel?.textColor = UIColor.lightGray;
        cell?.clipsToBounds = true;
        return cell!;
    }
    
    
    @objc func reloadData(sender:UIButton){
        let isOpen = sectionArray![sender.tag] as! Bool;
        sectionArray?.replaceObject(at: sender.tag, with: !isOpen);
        tableView?.reloadData();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

