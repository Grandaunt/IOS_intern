//
//  ZJLearnClassifyInfoProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnClassifyInfoProtocol: NSObject
{
    weak var controller:UIViewController!
    var model:ZJLearnHomeClassModel!
    var dataArray = [ZJLearnHomeCourseModel]()
}

extension ZJLearnClassifyInfoProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 40))
        headerView.backgroundColor = UIColor.white
        
        let btn = UIButton()
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e700}", size: 20, color: UIColor.color(hex: "#333333")), for: .normal)
        btn.setTitle(" " + self.model.categoryName!, for: .normal)
        btn.setTitleColor(UIColor.color(hex: "#333333"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.isEnabled = false
        headerView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJLearnClassifyInfoCell") as! ZJLearnClassifyInfoCell
        cell.model = self.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toVC = ZJLearnCourseInfoController()
        toVC.navTitle = "课程详情"
        toVC.model = self.dataArray[indexPath.row]
        self.controller.navigationController?.pushViewController(toVC, animated: true)
    }

}
