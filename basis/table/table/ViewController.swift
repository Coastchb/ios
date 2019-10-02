//
//  ViewController.swift
//  table
//
//  Created by coastcao(操海兵) on 2019/9/25.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class MineCenterCell: UITableViewCell {
    
    var TitleString:String?
    var iconImageName:String?
    
    var TitleLabel:UILabel?
    var iconImageView:UIImageView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.iconImageView=UIImageView()
        
        self.contentView.addSubview(self.iconImageView!)
        
        self.TitleLabel=UILabel()
        
        self.contentView.addSubview(self.TitleLabel!)
        
        setUpviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setUpviews() {
        
        if self.iconImageName != nil {
            
            self.iconImageView?.image=UIImage(named: iconImageName!)
            
            self.TitleLabel?.text=self.TitleString
            
        }
        
        self.iconImageView?.snp_makeConstraints(closure: { (make) in
            
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(5)
            make.width.equalTo(self.iconImageView!.snp_height)
            
        })
        
        
        self.TitleLabel?.snp_makeConstraints(closure: { (make) in
            
            make.left.equalTo(self.iconImageView!.snp_right).offset(10)
            make.centerY.equalTo(self.iconImageView!.snp_centerY)
            
        })
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpviews()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    if indexPath.section == 0 {
        let cell = MineInfoCell.cellWithTableView(tableView)
        cell.delegate=self
        return cell
    }
    
    let indentifier = "MineCenterCell"
    
    var cell:MineCenterCell! = tableView.dequeueReusableCellWithIdentifier(indentifier) as? MineCenterCell
    
    if cell == nil {
        
        cell=MineCenterCell(style: .Default, reuseIdentifier: indentifier)
    }
    
    let images = [["ji-fen"],["ZB建议书","ZB投保单","ZB自修营"],["ZB团队管理","ZB业绩管理","ZB考勤"],["ZBAPPShare","ZBSetting"]]
    
    let titles = [["我的积分：\(USERINFO.sharedInstance.getpoint())"],["我的建议书","我的投保单","自修营"],["团队管理","业绩管理","我的考勤"],["分享App","设置"]]
    
    if indexPath.section == 1 {
        cell?.accessoryType = .DisclosureIndicator
    }
    
    cell?.iconImageName=images[indexPath.section - 1][indexPath.row]
    
    cell.TitleString=titles[indexPath.section - 1][indexPath.row]
    
    return cell!
}

