//
//  ZJLearnCourseInfoProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnCourseInfoProtocol: NSObject
{
    weak var controller:UIViewController!
    weak var leftBtn:UIButton!
    weak var rightBtn:UIButton!
    
    var model:ZJLearnCourseInfoModel?
}

extension ZJLearnCourseInfoProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.leftBtn.isSelected
        {
            guard self.model == nil else
            {
                if self.model?.courseVideo == nil
                {
                    return 0
                }
                else
                {
                    return (self.model!.courseVideo?.count)!
                }
            }
            return 0
        }
        else
        {
            guard self.model == nil else
            {
                if self.model?.courseDescription == nil
                {
                    return 0
                }
                else
                {
                    return (self.model!.courseDescription?.count)!
                }
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 45))
        headerView.backgroundColor = UIColor.white
        
        headerView.addSubview(self.leftBtn)
        self.leftBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-kScreenViewWidth*0.25)
        }
        
        let portLineView = UIView()
        portLineView.backgroundColor = kCellLineColor
        headerView.addSubview(portLineView)
        portLineView.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        headerView.addSubview(self.rightBtn)
        self.rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(kScreenViewWidth*0.25)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kCellLineColor
        headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if self.rightBtn.isSelected
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJLearnCourseInfoCell") as! ZJLearnCourseInfoCell
            cell.model = self.model?.courseDescription?[indexPath.row]
            return cell

        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJLearnSearchResultCell") as! ZJLearnSearchResultCell
            cell.model = self.model?.courseVideo?[indexPath.row]
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if self.leftBtn.isSelected
        {
            let toVC = ZJLearnCoursePlayController()
            toVC.model = self.model?.courseVideo?[indexPath.row]
            toVC.models = self.model?.courseVideo
            self.controller.navigationController?.pushViewController(toVC, animated: true)
        }
        else
        {
            let toVC = ZJWebController()
            toVC.navTitle = "课程详情"
            let model = self.model?.courseDescription![indexPath.row]
            toVC.urlStr = model?.details
            self.controller.navigationController?.pushViewController(toVC, animated: true)
        }
    }
}
