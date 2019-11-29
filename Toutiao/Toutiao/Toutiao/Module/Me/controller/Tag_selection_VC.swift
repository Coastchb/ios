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
class tagSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell",
                                                      for: indexPath)
        print("here 0")
        if let tagCell = cell as? tagsCell {
            print("here 1")
            //let text = NSAttributedString(string: tags[indexPath.row].1, attributes: [.foregroundColor: UIColor.blue])
            //tagCell.tagLabel.attributedText = text
            tagCell.tag_name!.text = tags[indexPath.row].1
            var exists = user_tags.contains(where: {(id) in
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
            cell.is_selected = user_tags.contains(tags[indexPath.row].0)
            cell.tag_id = tags[indexPath.row].0
            cell.show_hide_icon()
            
            /* UserDefaults can store data and be persistent between app launches.
            print("before selecting:\((UserDefaults.standard.value(forKey: "Coast") as? String)!)")
            UserDefaults.standard.set(cell.tagLabel.text, forKey: "Coast")
            print("after selecting:\((UserDefaults.standard.value(forKey: "Coast") as? String)!)") */
 
        }
        
    }
        
    //lazy var tags = ["搞笑", "科技", "美食", "美女", "生活", "经济", "社会", "政治", "军事", "小说", "视频", "文化"]
    lazy var tags = [(Int,String)]()
    lazy var user_tags = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tags = Tag_item.get_all_tags()
        user_tags = Tag_item.get_user_tags(user_name: User.get_user_name())!
        
        self.tagsCollection.register(UINib(nibName: "tagsCell", bundle: nil), forCellWithReuseIdentifier: "tagCell")
        // Do any additional setup after loading the view.
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
