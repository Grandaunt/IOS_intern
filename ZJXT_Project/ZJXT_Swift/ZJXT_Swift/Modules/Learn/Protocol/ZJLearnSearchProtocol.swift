//
//  ZJLearnSearchProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnSearchProtocol: NSObject
{
    var clearSearchHistoryAction:(()->Void)?
    var historyArray:[String]!
    var hotArray:[String]!
    var controller:UIViewController!
    
    fileprivate lazy var layout:HXTagCollectionViewFlowLayout = {
        let layout = HXTagCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    fileprivate lazy var attr:HXTagAttribute = {[weak self] in
       let attr = HXTagAttribute()
        attr.borderWidth = 0.0
        attr.normalBackgroundColor = UIColor.white
        attr.textColor = UIColor.color(hex: "#727272")
        attr.cornerRadius = (self?.layout.itemSize.height)!/2
        attr.titleSize = 13
        return attr
    }()
    
    @objc fileprivate func clearSearchHistory()
    {
        if self.clearSearchHistoryAction != nil
        {
            self.clearSearchHistoryAction!()
        }
    }
}

extension ZJLearnSearchProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 40))
        headerView.backgroundColor = kBackgroundColor
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.color(hex: "#929292")
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
        }

        if section == 0
        {
            label.text = "搜索历史"
            
            let icon = UIButton()
            icon.setBackgroundImage(IconFontUtils.imageSquare(code: "\u{e6b4}", size: 15, color: UIColor.gray), for: .normal)
            icon.addTarget(self, action: #selector(clearSearchHistory), for: .touchUpInside)
            headerView.addSubview(icon)
            icon.snp.makeConstraints { (m) in
                m.centerY.equalTo(label)
                m.right.equalTo(-kHomeEdgeSpace)
                m.height.width.equalTo(17)
            }
        }
        else
        {
            label.text = "热门搜索"
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return HXTagsCell.getHeightWithTags(self.historyArray, layout: self.layout, tagAttribute: self.attr, width: kScreenViewWidth)
        }
        else
        {
            return HXTagsCell.getHeightWithTags(self.hotArray, layout: self.layout, tagAttribute: self.attr, width: kScreenViewWidth)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = HXTagsCell(style: .default, reuseIdentifier: "tagCell")
//            cell.layout = self.layout
            cell.tagAttribute = self.attr
            cell.tags = self.historyArray
            cell.completion = {(selectTags,index) in
                
                let str = self.historyArray[index]
                
                let toVC = ZJLearnSearchResultController()
                toVC.searchStr = str
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            return cell
        }
        else
        {
            let cell = HXTagsCell(style: .default, reuseIdentifier: "tagCell1")
//            cell.layout = self.layout
            cell.tagAttribute = self.attr
            cell.tags = self.hotArray
            cell.completion = {(selectTags,index) in
                
                let str = self.hotArray[index]
                let toVC = ZJLearnSearchResultController()
                toVC.searchStr = str
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }

            return cell
        }
    }
}
