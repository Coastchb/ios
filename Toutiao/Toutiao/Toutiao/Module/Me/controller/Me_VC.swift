//
//  MeViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/14.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

// mark 1: must be self.tableView not tableView!!!!

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var items = ["收藏",
                 "管理标签",
                 "反馈与建议",
                 "关于我们",
                 "退出登录"]
   /* var logined = false {
        didSet {
            print("logined:\(logined)")
            tableView.reloadData()
        }
    }*/
    var user_name : String?
    
    var tableView : UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return items.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:return 200
        default:return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if( indexPath.section == 0 && indexPath.row == 0) {
            // mark 1
            let tableCell = self.tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath)
            if let cell = tableCell as? LoginCell {
                if User.is_logined() {
                    cell.login_button.isHidden = true
                    cell.name_label?.isHidden = false
                    cell.name_label?.text = "Coast"
                    cell.user_avatar?.image = User.get_user_avatar()! //UIImage(imageLiteralResourceName: "dropdown_loading_03")
                } else {
                    cell.name_label?.isHidden = true
                    cell.login_button.isHidden = false
                    cell.user_avatar?.image = UIImage(imageLiteralResourceName: "avatar_moren")
                }
                cell.selectionStyle = .none
                return cell
            }
                return tableCell
            
        } else {
                let tableCell = tableView.dequeueReusableCell(withIdentifier: "otherCell")
                if let cell = tableCell as? meOtherCell {
                    var image_name = ""
                    switch indexPath.row {
                    case 0: image_name = "star"
                    case 1: image_name = "tag"
                    case 2: image_name = "feedback"
                    case 3: image_name = "about_us"
                    case 4: image_name = "log_out"
                    default:
                        break
                    }
                    cell.other_image?.image = UIImage(imageLiteralResourceName: image_name)
                    cell.other_label?.text = items[indexPath.row]
                    //print("\(items[indexPath.row])")
                    
                    if(indexPath.row == 4) {
                        cell.accessoryType = .none
                    }
                    cell.selectionStyle = .none
                    return cell

            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0 && indexPath.row == 0) {
            if(!User.is_logined()){
                print("to log in!")
                let login_vc = Login_VC()
                //login_vc.view.backgroundColor = .red
                login_vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(login_vc, animated: true)
            } else {
                let detail_vc = User_detail_VC()
                detail_vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detail_vc, animated: true)
            }
        } else if(indexPath.section == 1 && indexPath.row == 4 && User.is_logined()){
        // 退出登录            
            let alertController = UIAlertController(title: "您确定要离开了吗？",
                            message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "不", style: .cancel, handler: {
                action in
                print("取消退出登录")
            })
            let okAction = UIAlertAction(title: "是的", style: .destructive, handler: {
                action in
                print("点击了确定")
                User.logout()
                self.tableView.reloadData()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (indexPath.section == 1 && indexPath.row == 1) {
         // 管理标签
            //if(!logined) {
            //    print("请先登录或注册")
            //} else {
                let tags_vc = UIStoryboard(name: "Toutiao", bundle: nil).instantiateViewController(withIdentifier: "tagsSelectionViewController")
                
                if let vc = tags_vc as? tagSelectionViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
        } else if (indexPath.section == 1 && indexPath.row == 0) {
        // 收藏
            print("in me VC stared_items:\(UserDefaults.standard.value(forKey: STARED_TYPE_KEY))")
            let vc = StaredTutorialsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.section == 1 && indexPath.row == 2) {
            let vc = Feedback_VC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.section == 1 && indexPath.row == 3) {
            let vc = About_us_VC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "我", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        
        automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView (frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped);
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib (nibName: "LoginCell", bundle: nil), forCellReuseIdentifier: "loginCell")
        tableView.register(UINib (nibName: "meOtherCell", bundle: nil), forCellReuseIdentifier: "otherCell")
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 6
        tableView.tableHeaderView = UIView (frame: CGRect (x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
       // tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) //UIView(frame: CGRect.zero)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(tableView)
        tableView.separatorColor = UIColor (red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 10, right: 0)
        tableView.showsVerticalScrollIndicator = false
        
    }
    

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let _y = scrollView.contentOffset.y
            
    //        _topBgView.alpha = _y > 64 ? 1 : 0
        }
    
    override func viewWillAppear(_ animated: Bool) {
        print("logined?: \(User.is_logined())")
        self.tableView.reloadData()
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
