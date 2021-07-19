//
//  TagSelectionViewController.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/3.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import Foundation

//@IBDesignable
class Tag_selection_VC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell",
                                                      for: indexPath)
        if let tagCell = cell as? tagsCell {
            //let text = NSAttributedString(string: tags[indexPath.row].1, attributes: [.foregroundColor: UIColor.blue])
            //tagCell.tagLabel.attributedText = text
            tagCell.tag_name!.text = tags[indexPath.row].1
            var exists = self.user_tags.contains(where: {(id) in
                return id == tags[indexPath.row].0
            })
            tagCell.icon_label!.text = exists ? "✅" : ""
        }
        return cell

    }
    

    @IBOutlet weak var tagsCollection: UICollectionView! {
        didSet {
            tagsCollection.delegate = self
            tagsCollection.dataSource = self
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let selectedView = UIView(frame: tagsCollection.bounds)
        //selectedView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //tagsCollection.cellForItem(at: indexPath)?.selectedBackgroundView = selectedView
        
        if let cell = collectionView.cellForItem(at: indexPath) as? tagsCell {
            cell.is_selected = self.user_tags.contains(tags[indexPath.row].0)
            cell.tag_id = tags[indexPath.row].0
            if(cell.show_hide_icon(vc:self)) {
                if(!cell.is_selected) {
                    self.user_tags.remove(at:self.user_tags.firstIndex(of: tags[indexPath.row].0)!)
                } else {
                    self.user_tags.append(tags[indexPath.row].0)
                }
            }
        }
    }
        
    lazy var tags = [(Int,String)]()
    var user_tags = [Int]()
    
    @objc func add_tag() {
        print("to add")
        let add_tag_vc = Add_tag_VC()
        self.present(add_tag_vc,animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tags = Tag_item.get_all_tags(vc: self)
        self.user_tags = Tag_item.get_user_tags()
        self.tagsCollection.register(UINib(nibName: "tagsCell", bundle: nil), forCellWithReuseIdentifier: "tagCell")
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "选择标签"

        let item=UIBarButtonItem(title:"创建",style:.plain,target:self,action:Selector(("add_tag")))
        navigationItem.rightBarButtonItem = item
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
