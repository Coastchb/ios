//
//  CollectionViewController.swift
//  hangge_1592
//
//  Created by hangge on 2017/3/11.
//  Copyright © 2017年 hangge.com. All rights reserved.
//

import UIKit

//每月书籍
struct BookPreview {
    var title:String
    var images:[String]
}

class CollectionViewController: UICollectionViewController {
    
    //所有书籍数据
    let books = [
        BookPreview(title: "五月新书", images: ["0.jpg", "1.jpg","2.jpg", "3.jpg",
                                               "4.jpg","5.jpg","6.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg", "9.jpg"]),
        BookPreview(title: "七月新书", images: ["10.jpg", "11.jpg", "12.jpg", "13.jpg"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //获取分区数
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return books.count
    }
    
    //获取每个分区里单元格数量
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return books[section].images.count
    }
    
    //分区的header与footer
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:UICollectionReusableView!
        
        //分区头
        if kind == UICollectionElementKindSectionHeader{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                        withReuseIdentifier: "HeaderView", for: indexPath)
            //设置头部标题
            let label = reusableview.viewWithTag(1) as! UILabel
            label.text = books[indexPath.section].title
        }
        //分区尾
        else if kind == UICollectionElementKindSectionFooter{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                        withReuseIdentifier: "FooterView", for: indexPath)
            
        }
        return reusableview
    }
    
    //返回每个单元格视图
    override func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取单元格
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell",
                                                      for: indexPath)
        //设置单元格中的图片
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: books[indexPath.section].images[indexPath.item])
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
