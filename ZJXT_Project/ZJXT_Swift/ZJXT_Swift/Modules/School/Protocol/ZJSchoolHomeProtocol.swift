//
//  ZJSchoolHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJSchoolHomeProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJCircleModel]()
}

extension ZJSchoolHomeProtocol:UITableViewDelegate,UITableViewDataSource
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
//        let headerView = UIView()
//        headerView.backgroundColor = kBackgroundColor
//
//        let timeLabel = UILabel()
//        timeLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//        timeLabel.textColor = UIColor.white
//        timeLabel.font = UIFont.systemFont(ofSize: 13)
//        timeLabel.text = "   2017年7月15日   "
//        timeLabel.layer.masksToBounds = true
//        timeLabel.layer.cornerRadius = 2
//        headerView.addSubview(timeLabel)
//        timeLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(25)
//        }
//
//        return headerView
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //约吧
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ZJMyCircleCallCell") as! ZJMyCircleCallCell
        //心情
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "ZJMyCircleTextCell") as! ZJMyCircleTextCell
        
        let model = self.dataArray[indexPath.row]
        //心情
        if model.categoryId == "1"
        {
            cell2.model = model
            return cell2
        }
        else  //约吧
        {
            cell1.model = model
            return cell1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArray[indexPath.row]
        
        let toVC = ZJSayInfoController()
        toVC.navTitle = "详情"
        toVC.model = model
        self.controller.navigationController?.pushViewController(toVC, animated: true)

    }
}
