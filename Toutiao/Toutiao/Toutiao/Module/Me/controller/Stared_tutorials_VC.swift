//
//  StaredTutorialsVC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/16.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit

class StaredTutorialsVC: UITableViewController {
    var stared_items = Stared_item.get_all_stared_items()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("in stared VC stared_items:\(stared_items)")
        
        // to remove the extra cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationItem.title = "我的收藏"
        
        tableView.register(UINib(nibName: "Stared_cell", bundle: nil), forCellReuseIdentifier: "stared_cell")
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
        if let cell = tableCell as? Stared_cell {
            //print("ok 0")
            //print("feed row at:\(indexPath.row)")
            print("\(stared_items[indexPath.row].0)----\(stared_items[indexPath.row].1)")
            var id = -1
            var tag = ""
            var title = ""
            var abstract = ""
            var link = ""
            var score = -1
            if (stared_items[indexPath.row].0 == "tutorial_text") {
                (id, tag, title, abstract, link, score) = get_target_tutorial_text(id: stared_items[indexPath.row].1)
            } else if (stared_items[indexPath.row].0 == "blog") {
                (id, tag, title, abstract, link, score) = get_target_blog(id: stared_items[indexPath.row].1)
            } else if (stared_items[indexPath.row].0 == "tutorial_video") {
                (id, tag, title, abstract, link, score) = get_target_tutorial_video(id: stared_items[indexPath.row].1)
            }

            cell.tag_label.text = tag
            cell.title_label.text = title
            cell.abstract_label.text = abstract
            cell.image_view?.image = UIImage(imageLiteralResourceName: "tutorial_text_pic\(id)")
            cell.image_view?.contentMode = .scaleAspectFit
            
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
        detail_vc.url_string = get_stared_item_url(item: item)
        self.navigationController?.pushViewController(detail_vc, animated: true)
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "您确定要删除吗？",
                            message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "不", style: .cancel, handler: {
                action in
            })
            let okAction = UIAlertAction(title: "是的", style: .destructive, handler: {
                action in
                // Delete the row from the data source
                Stared_item.remove_stared_item(type: self.stared_items[indexPath.row].0, id: self.stared_items[indexPath.row].1)
                self.stared_items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
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
