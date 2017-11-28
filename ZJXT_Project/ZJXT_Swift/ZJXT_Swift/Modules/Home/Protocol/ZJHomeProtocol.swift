//
//  ZJHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJHomeProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJHomeListModel]()
    var textArray = [String]()
}

extension ZJHomeProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.dataArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.backgroundColor = kBackgroundColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 200
        }
        else if indexPath.section == 1
        {
            return 49
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeClassCell") as! ZJHomeClassCell
            
            cell.tapAction = {[weak self] (index) in
                switch index
                {
                    case 0:
                        
                        BaseViewModel().post(url: kGetPraticeInfoURL, param: ["UserId":UserInfo.shard.userId ?? ""], MBProgressHUD: false, success: { (resp) in
                            
                            let isHasUserPractice = resp?["entity"]["isHasUserPractice"].stringValue
                            let userInfo = UserInfo.shard
                            userInfo.isHasUserPractice = isHasUserPractice
                            UserInfo.saveUserInfo(user: userInfo)
                            if UserInfo.shard.isHasUserPractice == "NO"
                            {
                                let toVC = ZJHomeInternshipHomeController()
                                toVC.navTitle = "实习"
                                self?.controller.navigationController?.pushViewController(toVC, animated: true)
                            }
                            else if UserInfo.shard.isHasUserPractice == "YES"
                            {
                                let dict = resp?["entity"]["userPracticeInfo"].dictionaryObject
                                let model = ZJUserHasPracticeModel.mj_object(withKeyValues: dict)
                                
                                let toVC = ZJISAlreadyHomeController()
                                toVC.navTitle = "实习"
                                toVC.model = model
                                self?.controller.navigationController?.pushViewController(toVC, animated: true)
                            }
                            else
                            {
                                MBProgressHUD.show(error: "申请中...")
                                return
                            }
    
                            
                        }, noData: nil, failure: nil)
                    
                    case 1:
//                        let toVC = ZJRecruitHomeController()
//                        toVC.navTitle = "招聘"
//                        self?.controller.navigationController?.pushViewController(toVC, animated: true)
                        let toVC = ZJNewRecruitHomeController()
                        toVC.navTitle = "招聘"
                        self?.controller.navigationController?.pushViewController(toVC, animated: true)
                    case 2:
                        MBProgressHUD.show(error: "暂未开放")
                    case 3:
                        break;
                    case 4:
                        self?.controller.tabBarController?.selectedIndex = 1
                    case 5:
                        self?.controller.tabBarController?.selectedIndex = 2
                    default:
                        break
                }
            }
            
            return cell

        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeNoticeCell") as! ZJHomeNoticeCell
            cell.cycleView.titlesGroup = self.textArray
            return cell

        }
        else
        {
            let model = self.dataArray[indexPath.section - 2]
            
            //召集令
            if model.circleId != "0"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeCircleCell") as! ZJHomeCircleCell
                cell.model = model
                return cell
            }
            if model.noticeId != "0" && model.imageUrl != nil  //有图通知
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeRecruitCell") as! ZJHomeRecruitCell
                cell.model = model
                return cell

            }
            else   //无图通知
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeApplyCell") as! ZJHomeApplyCell
                cell.model = model
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section > 1
        {
            let model = self.dataArray[indexPath.section - 2]
            //召集令
            if model.circleId != "0"
            {
                let circleModel = ZJCircleModel()
                circleModel.circleId = model.circleId
                circleModel.categoryId = "2"
                circleModel.activityAddress = model.activityAddress
                circleModel.activityTime = model.activityTime
                circleModel.contentText = model.contentText
                circleModel.applyNumber = "0"
                circleModel.createTime = model.createTime
                circleModel.imageUrl1 = model.imageUrl
                circleModel.nickName = model.nickName
                
                let toVC = ZJSayInfoController()
                toVC.navTitle = "详情"
                toVC.model = circleModel
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            else
            {
                
                let toVC = ZJWebController()
                toVC.navTitle = "通知详情"
                toVC.urlStr = model.targetUrl
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
        }
        
    }
}
