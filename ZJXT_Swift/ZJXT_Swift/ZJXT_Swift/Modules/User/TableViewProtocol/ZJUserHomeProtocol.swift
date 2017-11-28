//
//  ZJUserHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/11.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJUserHomeProtocol: NSObject
{
    var dataArray:[[[String:Any]]]!
    weak var controller:UIViewController!
}

extension ZJUserHomeProtocol:UITableViewDelegate,UITableViewDataSource
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
        guard section == 0 else {
            return kHomeEdgeSpace*1.5
        }
        return 0.01
    }
    
    //适配ios11 不然会多出来一块
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        guard section == self.dataArray.count - 1 else {
            return 0.01
        }
        return 50
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
        return 126
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            if !UserInfo.isLogin()
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJUserHomeUserNotLoginCell") as! ZJUserHomeUserNotLoginCell
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJUserHomeUserLoginCell") as! ZJUserHomeUserLoginCell
                cell.nameLabel.text = UserInfo.shard.trueName
                
                if UserInfo.shard.logo?.trimAfterCount() == 0 || UserInfo.shard.logo == nil
                {
                    cell.iconImgView.image = kUserLogoPlaceHolder
                }
                else
                {
                    
                    cell.iconImgView.af_setImage(withURL: URL(string: UserInfo.shard.logo!)!, placeholderImage: kUserLogoPlaceHolder)
                }
                return cell
            }
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
        
        if !UserInfo.isLogin()
        {
            let toVC = ZJLoginController()
            toVC.navTitle = "登录"
            self.controller.navigationController?.pushViewController(toVC, animated: true)
        }
        else
        {
            switch indexPath.section
            {
                case 0:
                    let toVC = ZJUserInfoController()
                    toVC.navTitle = "个人基本信息"
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                case 1:
                    if indexPath.row == 0
                    {
                        let toVC = ZJVCHomeController()
                        toVC.navTitle = "我的简历"
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                    }
                    else if indexPath.row == 1
                    {
                        let toVC = ZJMyApplyHomeController()
                        toVC.navTitle = "我的申请"
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                    }
                    else
                    {
                        let toVC = ZJMyCollectController()
                        toVC.navTitle = "我的收藏"
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                    }
                case 2:
                    if indexPath.row == 0
                    {
                        if UserInfo.shard.isHasUserPractice == "NO"
                        {
                            MBProgressHUD.show(error: "请先申请实习")
                            return
                        }
                        else if UserInfo.shard.isHasUserPractice == "Auditing"
                        {
                            MBProgressHUD.show(error: "实习申请审核中")
                            return
                        }
                        let toVC = ZJMyInternshipController()
                        toVC.navTitle = "我的实习"
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                    }
                    else if indexPath.row == 1
                    {
                        let toVC = ZJMyCircleController()
                        toVC.navTitle = "我的圈子"
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                        
                    }
                    else
                    {
                    }
                case 3:
                    let toVC = ZJMySettingController()
                    toVC.navTitle = "设置"
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                
                default:
                    break
            }
        }
    }
}
