//
//  ZJRecruitSearchResultProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJRecruitSearchResultProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJInternshipJobModel]()
}

extension ZJRecruitSearchResultProtocol:YZPullDownMenuDataSource,UITableViewDelegate,UITableViewDataSource
{
    //MAKR: - YZPullDownMenuDataSource
    func numberOfCols(in pullDownMenu: YZPullDownMenu!) -> Int
    {
        return 3
    }
    
    func pullDownMenu(_ pullDownMenu: YZPullDownMenu!, buttonForColAt index: Int) -> UIButton! {
        let btn = YZMenuButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.color(hex: "#929292"), for: .normal)
        btn.setTitleColor(kTabbarBlueColor, for: .selected)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e79b}", size: 15, color: UIColor.color(hex: "#929292")), for: .normal)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e79c}", size: 15, color: kTabbarBlueColor), for: .selected)
        
        if index == 0
        {
            btn.setTitle("城市筛选", for: .normal)
        }
        else if index == 1
        {
            btn.setTitle("职位筛选", for: .normal)
        }
        else
        {
            btn.setTitle("公司筛选", for: .normal)
        }
        
        return btn
    }
    
    func pullDownMenu(_ pullDownMenu: YZPullDownMenu!, viewControllerForColAt index: Int) -> UIViewController!
    {
        return self.controller.childViewControllers[index]
    }
    
    func pullDownMenu(_ pullDownMenu: YZPullDownMenu!, heightForColAt index: Int) -> CGFloat
    {
        return 280
    }
    
    //MARK: - UITableViewDelegate && UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeInternshipJobCell") as! ZJHomeInternshipJobCell
        cell.model = self.dataArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toVC = ZJHomeInternShipJobInfoController()
        toVC.navTitle = "职位详情"
        self.controller.navigationController?.pushViewController(toVC, animated: true)
    }
}
