//
//  StaredTutorialsVC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/16.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class Stared_items_VC: UITableViewController {
    var stared_items : [(String,Int,String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ret = get_stared_items()
        if(ret.0 == -1) {
            self.prompt(UNKNOWN_ERROR_PROMPT, UNKNOWN_ERROR_PROMPT_DELAY)
        } else if(ret.0 == -2) {
            self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
        } else {
            stared_items = ret.1
        }
        print("in stared VC stared_items:\(stared_items)")
        
        // to remove the extra cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationItem.title = "我的收藏"
        
        tableView.register(UINib(nibName: "Tutorial_text_cell", bundle: nil), forCellReuseIdentifier: "stared_cell")
        //self.tableView.register(UINib(nibName: "staredCell", bundle: nil), forCellReuseIdentifier: "StaredCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stared_items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "stared_cell", for: indexPath)
        if let cell = tableCell as? Tutorial_text_cell {
            //print("ok 0")
            //print("feed row at:\(indexPath.row)")
            print("\(stared_items[indexPath.row].0)----\(stared_items[indexPath.row].1)")
            var id = -1
            var tag = ""
            var title = ""
            var source = ""
            var link = ""
            var recommend_num = -1
            if (stared_items[indexPath.row].0 == "tutorial_text") {
                (id, tag, title, source, link) = get_target_tutorial_text(id: stared_items[indexPath.row].1)
            } else if (stared_items[indexPath.row].0 == "blog") {
                (id, tag, title, _, link, recommend_num) = get_target_blog(id: stared_items[indexPath.row].1)
                //print("link:\(link)")
                source = get_domain_name(link: link)
            } else if (stared_items[indexPath.row].0 == "tutorial_video") {
                (id, tag, title, source, link) = get_target_tutorial_video(id: stared_items[indexPath.row].1)
            }

            cell.tagLabel.text = tag
            cell.tutorialTitleLabel.text = title
            cell.sourceLabel.text = "\(source)"
            //cell.image_view?.image = UIImage(imageLiteralResourceName: "tutorial_text_pic\(id)")
            //cell.image_view?.contentMode = .scaleAspectFit
            //cell.scoreLabel.text = currentDate()
            //cell.unfoldSign.isHidden = true
            cell.icon_image.image = get_website_logo(link: link) //UIImage(imageLiteralResourceName: "runoob")
            cell.timeLabel.text = convert_date(stared_items[indexPath.row].2, "yyyy-MM-dd HH:mm:ss")

            cell.recommend_btn.isHidden = true
            cell.star_btn.isHidden = true
            cell.thanks_btn.isHidden = true

            //cell.selectionStyle = .none
            return cell
        } else {
            print("not ok")
        }
        //reloadInputViews()
        return tableCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = stared_items[indexPath.row]
        var detail_vc = webVC()
        var target_url = get_stared_item_url(item: (item.0,item.1))
        if(target_url == "") {
            self.prompt(UNKNOWN_ERROR_PROMPT, UNKNOWN_ERROR_PROMPT_DELAY)
        }else {
            detail_vc.url_string = target_url
            self.navigationController?.pushViewController(detail_vc, animated: true)
        }
        
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (!check_network_available()) {
                self.tableView.cellForRow(at: indexPath)!.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                return
            }
            let alertController = UIAlertController(title: "您确定要删除吗？",
                            message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "不", style: .cancel, handler: {
                action in
            })
            let okAction = UIAlertAction(title: "是的", style: .destructive, handler: {
                action in
                // Delete the row from the data source
                //Stared_item.remove_stared_item(type: self.stared_items[indexPath.row].0, id: self.stared_items[indexPath.row].1)
                var ret = remove_star(tableCell: self.tableView.cellForRow(at: indexPath) as! UITableViewCell,item_type: self.stared_items[indexPath.row].0, item_id: self.stared_items[indexPath.row].1, user_id: User.get_user_id() ?? "-1")
                //if (ret) {
                    print("已经被成功删除")
                    self.stared_items.remove(at: indexPath.row)
                    print("从列表中删除")
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    print("修正table view")
                //} else {
                 //   self.prompt(UNKNOWN_ERROR_PROMPT, UNKNOWN_ERROR_PROMPT_DELAY)
                //}
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
