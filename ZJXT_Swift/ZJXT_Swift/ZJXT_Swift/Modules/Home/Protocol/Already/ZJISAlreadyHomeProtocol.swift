//
//  ZJISAlreadyHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJISAlreadyHomeProtocol: NSObject
{
    var dataArray:[[[String:Any]]]!
    var model:ZJUserHasPracticeModel!
    weak var controller:UIViewController!
}

extension ZJISAlreadyHomeProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10
    }
    
    //适配ios11 不然会多出来一块
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    //适配ios11 不然会多出来一块
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard indexPath.section == 0 else {
            return 49
        }
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJISAlreadyHomeCompanyCell") as! ZJISAlreadyHomeCompanyCell
            cell.model = self.model
            return cell
        default:
            let dict = self.dataArray[indexPath.section][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJUserHomeOtherCell") as! ZJUserHomeOtherCell
            cell.imgView.image = UIImage(named: dict["icon"] as! String)
            cell.titleLabel.text = dict["title"] as? String
            
            if self.dataArray[indexPath.section].count - 1 == indexPath.row
            {
                cell.lineView.isHidden = true
            }
            else
            {
                cell.lineView.isHidden = false
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
//            let toVC = ZJISAlreadyCompanyInfoController()
//            toVC.navTitle = "公司详情"
//            self.controller.navigationController?.pushViewController(toVC, animated: true)
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                let toVC = ZJISAlreadySignInController()
                toVC.navTitle = "签到"
                toVC.model = self.model
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            else if indexPath.row == 1
            {
                let toVC = ZJISAlreadyJournalController()
                toVC.navTitle = "日志"
                toVC.model = self.model
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            else
            {
                let toVC = ZJISAlreadyWeeklyController()
                toVC.navTitle = "周报"
                toVC.model = self.model
                self.controller.navigationController?.pushViewController(toVC, animated: true)

            }
        }
        else if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                let toVC = ZJISAlreadyLeaveController()
                toVC.navTitle = "请假"
                toVC.type = .leave
                toVC.model = self.model
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            else if indexPath.row == 1
            {
                let toVC = ZJISAlreadyLeaveController()
                toVC.navTitle = "出差"
                toVC.type = .trip
                toVC.model = self.model
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            else
            {
                let toVC = ZJISAlreadyQuestionController()
                toVC.navTitle = "问答"
                self.controller.navigationController?.pushViewController(toVC, animated: true)

            }
        }
        else
        {
            NetworkRequest.sharedInstance.POST(URL: kGetDimissionURL, param: ["userPracticeId":self.model.userPracticeId ?? ""], success: { (response) in
                
                if response!["code"].stringValue == "200"
                {
                    MBProgressHUD.show(info: "申请成功，等待审核")
                }
                else if response!["code"].stringValue == "502"
                {
                    MBProgressHUD.show(error: "不能重复申请")
                    return
                }
                
            }) { (error) in
                let nsError = error! as NSError
                if nsError.code == NSURLErrorNotConnectedToInternet
                {
                    MBProgressHUD.show(error: "请先连接网络")
                    
                }
                else if nsError.code == NSURLErrorTimedOut
                {
                    MBProgressHUD.show(error: "网络请求超时")
                }
                else
                {
                    MBProgressHUD.show(error: "网络请求错误")
                }
            }
        }
    }
}
