//
//  ZJRecruitHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJRecruitHomeProtocol: NSObject
{
    var recommendArray:[String]!
    
    weak var controller:UIViewController!
    
    fileprivate lazy var layout:HXTagCollectionViewFlowLayout = {
        let layout = HXTagCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    fileprivate lazy var attr:HXTagAttribute = {[weak self] in
        let attr = HXTagAttribute()
        attr.borderWidth = 1.0
        attr.borderColor = UIColor.color(hex: "#A8A7A8")
        attr.normalBackgroundColor = UIColor.white
        attr.textColor = UIColor.color(hex: "#A8A7A8")
        attr.cornerRadius = 2
        attr.titleSize = 13
        attr.selectedBackgroundColor = UIColor.white
        return attr
        }()
    }

extension ZJRecruitHomeProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 55))
        
        let maskView = UIView()
        maskView.backgroundColor = UIColor.white
        headerView.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(kHomeEdgeSpace)
        }
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.color(hex: "#333333")
        maskView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
        }
        
        if section == 0
        {
            label.text = "你可能在找"
        }
        else
        {
            label.text = "猜你喜欢"
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kCellLineColor
        headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return HXTagsCell.getHeightWithTags(self.recommendArray, layout: self.layout, tagAttribute: self.attr, width: kScreenViewWidth)
        }
        else
        {
            return 95
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: "tagCell") as? HXTagsCell
            if cell == nil
            {
                cell = HXTagsCell(style: .default, reuseIdentifier: "tagCell")
            }
            cell?.tags = self.recommendArray
            cell?.layout = self.layout
            cell?.tagAttribute = self.attr
            cell?.collectionView.backgroundColor = UIColor.white
            cell?.completion = {[weak self] (_,index) in
                let title = self?.recommendArray[index]
                let toVC = ZJRecruitSearchResultController()
                toVC.searchStr = title
                self?.controller.navigationController?.pushViewController(toVC, animated: true)

            }
            cell?.reloadData()
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeInternshipJobCell") as! ZJHomeInternshipJobCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1
        {
            let toVC = ZJHomeInternShipJobInfoController()
            toVC.navTitle = "职位详情"
            self.controller.navigationController?.pushViewController(toVC, animated: true)
        }
    }
}
