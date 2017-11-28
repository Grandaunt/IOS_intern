//
//  ZJMyInternshipProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/13.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyInternshipProtocol: NSObject
{
    var dataArray:[[String:Any]]!
    weak var controller:UIViewController!
}

extension ZJMyInternshipProtocol:UITableViewDelegate,UITableViewDataSource
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
        return 15
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 49
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dict = self.dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJUserHomeOtherCell") as! ZJUserHomeOtherCell
        cell.imgView.image = UIImage(named: dict["icon"]! as! String)
        cell.titleLabel.text = dict["title"] as? String
        
        if self.dataArray.count - 1 == indexPath.row
        {
            cell.lineView.isHidden = true
        }
        else
        {
            cell.lineView.isHidden = false
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row
        {
            case 0:
                let toVC = ZJMyLogController()
                toVC.navTitle = "我的日志"
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            case 1:
                let toVC = ZJMyWeeklyJournalController()
                toVC.navTitle = "我的周报"
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            case 2:
                let toVC = ZJMyQuestionController()
                toVC.navTitle = "我的问答"
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            case 3:
                let toVC = ZJMyBusinessTripController()
                toVC.navTitle = "我的出差"
                toVC.isTrip = true
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            case 4:
                let toVC = ZJMyBusinessTripController()
                toVC.navTitle = "我的请假"
                toVC.isTrip = false
                self.controller.navigationController?.pushViewController(toVC, animated: true)

            
            default:
                break
        }
    }
}


