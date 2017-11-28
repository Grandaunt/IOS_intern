//
//  ZJUserInfoProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/13.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJUserInfoProtocol: NSObject
{
    var titleArray:[[[String:Any]]]!
    weak var controller:UIViewController!
}

extension ZJUserInfoProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.titleArray.count   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.titleArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ZJUserInfoCell.cellWithTableView(tableView)
        
        let dict = self.titleArray[indexPath.section][indexPath.row]
        cell.titleLabel.text = dict["title"] as? String
        cell.textField.text = ""
        
        cell.manBtn.isUserInteractionEnabled = false
        cell.womanBtn.isUserInteractionEnabled = false
        cell.textField.isEnabled = false
        
        let type = dict["type"] as! UserInfoType
        
        if type == .radio
        {
            cell.textField.isHidden = true
            cell.textField.isUserInteractionEnabled = true
            cell.manBtn.isHidden = false
            cell.womanBtn.isHidden = false
            cell.accessoryType = .none

        }
        else if type == .select
        {
            cell.textField.isHidden = false
            cell.textField.isUserInteractionEnabled = false
            cell.manBtn.isHidden = true
            cell.womanBtn.isHidden = true
            cell.accessoryType = .disclosureIndicator
            cell.textField.placeholder = dict["placeHolder"] as? String
        }
        else
        {
            cell.textField.isHidden = false
            cell.textField.isUserInteractionEnabled = true
            cell.manBtn.isHidden = true
            cell.womanBtn.isHidden = true
            cell.accessoryType = .none
            cell.textField.placeholder = dict["placeHolder"] as? String
        }
        
        if UserInfo.isLogin()
        {
            if indexPath.section == 0
            {
                switch indexPath.row
                {
                case 0:
                    cell.textField.text = UserInfo.shard.trueName
                case 1:
                    if UserInfo.shard.male == "1"
                    {
                        cell.manBtn.isSelected = true
                    }
                    else
                    {
                        cell.womanBtn.isSelected = true
                    }
                case 2:
                    cell.textField.text = UserInfo.shard.nickName
                    cell.textField.isEnabled = true
                case 3:
                    cell.textField.text = UserInfo.shard.userBirth
                case 4:
                    cell.textField.text = UserInfo.shard.userIDCard
                default:
                    break
                    
                }
            }
            else
            {
                switch indexPath.row
                {
                    case 0:
                        cell.textField.text = UserInfo.shard.schoolName
                    case 1:
                        cell.textField.text = UserInfo.shard.intoSchool
                    case 2:
                        cell.textField.text = UserInfo.shard.departmentName
                    case 3:
                        cell.textField.text = UserInfo.shard.majorName
                    case 4:
                        cell.textField.text = UserInfo.shard.gradeName
                    case 5:
                        cell.textField.text = UserInfo.shard.userCode
                    case 6:
                        cell.textField.text = UserInfo.shard.leftSchool
                    default:
                        break
                    
                }
            }
            
        }
        
        return cell
    }
    
    
}
