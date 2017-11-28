//
//  ZJVCHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/13.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJVCHomeProtocol: NSObject
{
    var editUserInfoAction:((ZJVCResumeInfoModel)->Void)?

    
    var titleArray:[[String:Any]]!
    
    weak var controller:UIViewController!
    
    var infoModel:ZJVCHomeModel?
    
    var imgTapAction:((ZJVCUserLogoCell)->Void)?
    
    weak var logoCell:ZJVCUserLogoCell?
    
    var selectImg:UIImage?

}

extension ZJVCHomeProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.infoModel == nil
        {
            return 1
        }
        else
        {
            switch section
            {
                case 2:
                    guard (self.infoModel?.experiencePracticeList?.count)! == 0 else
                    {
                        return (self.infoModel?.experiencePracticeList?.count)!
                    }
                    return 1
                case 3:
                    guard (self.infoModel?.experienceworkList?.count)! == 0 else
                    {
                        return (self.infoModel?.experienceworkList?.count)!
                    }
                    return 1
                case 4:
                    guard (self.infoModel?.experienceEducationList?.count)! == 0 else
                    {
                        return (self.infoModel?.experienceEducationList?.count)!
                    }
                    return 1
                case 5:
                    guard (self.infoModel?.experienceProjectList?.count)! == 0 else
                    {
                        return (self.infoModel?.experienceProjectList?.count)!
                    }
                    return 1

                default:
                    return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let dict = self.titleArray[section]
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 55))
        
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = dict["title"] as? String
        titleLabel.textColor = UIColor.color(hex: "#666666")
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview()
        }
        
        let mustLabel = UILabel()
        mustLabel.textColor = UIColor.color(hex: "#FF715E")
        mustLabel.text = "  必填  "
        mustLabel.font = UIFont.systemFont(ofSize: 13)
        mustLabel.layer.masksToBounds = true
        mustLabel.layer.cornerRadius = 10
        mustLabel.layer.borderWidth = 0.5
        mustLabel.layer.borderColor = UIColor.color(hex: "#FF715E").cgColor
        headerView.addSubview(mustLabel)
        mustLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(kHomeEdgeSpace)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        if dict["isMust"] as! Bool
        {
            mustLabel.isHidden = false
        }
        else
        {
            mustLabel.isHidden = true
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 125
        }
        else if indexPath.section == 1
        {
            return 260
        }
        else
        {
            if self.infoModel != nil
            {
                //经历为空或者自我描述为空
//                if (self.infoModel?.experiencePracticeList?.count)! == 0 || (self.infoModel?.experienceEducationList?.count)! == 0 || (self.infoModel?.experienceworkList?.count)! == 0 || (self.infoModel?.experienceProjectList?.count)! == 0 || (self.infoModel?.resumeinfo?.resumeSelfDes == nil || self.infoModel?.resumeinfo?.resumeSelfDes?.trimAfterCount() == 0)
//                {
//                    return 100
//                }
                
                return UITableViewAutomaticDimension
            }
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJVCUserLogoCell") as! ZJVCUserLogoCell
            if self.infoModel == nil || self.infoModel?.resumeinfo?.resumeUserIcon == nil
            {
                cell.logoImgView.image = kUserLogoPlaceHolder
            }
            else
            {
                let url = URL(string: (self.infoModel?.resumeinfo?.resumeUserIcon)!)
                if url == nil
                {
                    cell.logoImgView.image = kUserLogoPlaceHolder
                }
                else
                {
                    cell.logoImgView.af_setImage(withURL: url!, placeholderImage: kUserLogoPlaceHolder)

                }
            }
            
            if self.selectImg != nil
            {
                cell.logoImgView.image = self.selectImg
            }
            
            weak var weakCell = cell
            cell.imgTapAction = {
                if self.imgTapAction != nil
                {
                    self.imgTapAction!(weakCell!)
                }
            }
            
            self.logoCell = cell
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJVCUserInfoCell") as! ZJVCUserInfoCell
            cell.model = self.infoModel?.resumeinfo
            cell.editUserInfoAction = {[weak self] model in
                if self?.editUserInfoAction != nil
                {
                    model.resumeId = self?.infoModel?.resumeinfo?.resumeId
                    model.resumeSelfDes = self?.infoModel?.resumeinfo?.resumeSelfDes
                    self?.editUserInfoAction!(model)
                }
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJVCAddExperienceCell") as! ZJVCAddExperienceCell
            let dict = self.titleArray[indexPath.section]
            
            cell.addBtn.setTitle(dict["btnTitle"] as? String, for: .normal)
            cell.infoLabel.text = dict["labelTitle"] as? String

            let cell1 = tableView.dequeueReusableCell(withIdentifier: "ZJVCHomeWorkExperienceCell") as! ZJVCHomeWorkExperienceCell
            if indexPath.row == 0
            {
                cell1.editBtn.isHidden = false
                cell1.topLineView.isHidden = true
            }
            else
            {
                cell1.editBtn.isHidden = true
                cell1.topLineView.isHidden = false
            }
            
            if self.infoModel == nil
            {
                return cell
            }
            else
            {
                switch indexPath.section
                {
                case 2:
                    guard (self.infoModel?.experiencePracticeList?.count)! > 0 else
                    {
                        return cell
                    }
                    
                    let model = self.infoModel?.experiencePracticeList![indexPath.row]
                    cell1.dateLabel.text = (model?.practiceStartTime)! + "-" + (model?.practiceEndTime)!
                    cell1.companyLabel.text = model?.companyName
                    cell1.infoLabel.attributedText = Utils.getAttributeStringWithString((model?.practiceDes)!, lineSpace: 3)
                    
                    cell1.editAciton = {
                        let toVC = ZJWorkExperienceListController()
                        toVC.navTitle = "实习经历"
                        toVC.experienceType = .practice
                        self.controller.navigationController?.pushViewController(toVC, animated: true)

                    }
                    
                    return cell1
                case 3:
                    guard (self.infoModel?.experienceworkList?.count)! > 0 else
                    {
                        return cell
                    }
                    
                    let model = self.infoModel?.experienceworkList![indexPath.row]
                    cell1.dateLabel.text = (model?.workStartTime)! + "-" + (model?.workEndTime)!
                    cell1.companyLabel.text = model?.companyName
                    cell1.infoLabel.attributedText = Utils.getAttributeStringWithString((model?.workDes)!, lineSpace: 3)
                    cell1.editAciton = {
                        let toVC = ZJWorkExperienceListController()
                        toVC.navTitle = "工作经历"
                        toVC.experienceType = .work
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                        
                    }

                    return cell1
                case 4:
                    guard (self.infoModel?.experienceEducationList?.count)! > 0 else
                    {
                        return cell
                    }
                    
                    let model = self.infoModel?.experienceEducationList![indexPath.row]
                    cell1.dateLabel.text = (model?.educationStartTime)! + "-" + (model?.educationEndTime)!
                    cell1.companyLabel.text = model?.schoolName
                    cell1.infoLabel.attributedText = Utils.getAttributeStringWithString((model?.educationMajor ?? "") + " | " + (model?.educationDes ?? ""), lineSpace: 3)
                    cell1.editAciton = {
                        let toVC = ZJWorkExperienceListController()
                        toVC.navTitle = "教育经历"
                        toVC.experienceType = .edu
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                        
                    }
                    return cell1

                case 5:
                    guard (self.infoModel?.experienceProjectList?.count)! > 0 else
                    {
                        return cell
                    }
                    
                    let model = self.infoModel?.experienceProjectList![indexPath.row]
                    cell1.dateLabel.text = (model?.projectStartTime)! + "-" + (model?.projectEndTime)!
                    cell1.companyLabel.text = model?.projectName
                    cell1.infoLabel.attributedText = Utils.getAttributeStringWithString((model?.projectDes)!, lineSpace: 3)
                    cell1.editAciton = {
                        let toVC = ZJWorkExperienceListController()
                        toVC.navTitle = "项目经历"
                        toVC.experienceType = .project
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                        
                    }

                    return cell1
                case 6:
                    if self.infoModel?.resumeinfo?.resumeSelfDes?.trimAfterCount() == 0
                    {
                        return cell
                    }
                    let cell2 = tableView.dequeueReusableCell(withIdentifier: "ZJVCHomeWorkDesCell") as! ZJVCHomeWorkDesCell
                    cell2.infoLabel.attributedText = Utils.getAttributeStringWithString((self.infoModel?.resumeinfo?.resumeSelfDes ?? ""), lineSpace: 3)
                    cell2.editDesAction = {
                        let toVC = ZJAddSelfEvaluateController()
                        toVC.navTitle = "自我评价"
                        toVC.model = self.infoModel?.resumeinfo
                        self.controller.navigationController?.pushViewController(toVC, animated: true)
                        
                    }

                    return cell2
                    
                default:
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let toVC = ZJEditWorkExperienceController()
        switch indexPath.section
        {
            case 2:
                if (self.infoModel?.experiencePracticeList?.count) == 0
                {
                    toVC.navTitle = "实习信息"
                    toVC.experienceType = .practice
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }
            case 3:
                if (self.infoModel?.experienceworkList?.count) == 0
                {
                    toVC.navTitle = "工作信息"
                    toVC.experienceType = .work
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }

            case 4:
                if (self.infoModel?.experienceEducationList?.count) == 0
                {
                    toVC.navTitle = "教育信息"
                    toVC.experienceType = .edu
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }

            case 5:
                if (self.infoModel?.experienceProjectList?.count) == 0
                {
                    toVC.navTitle = "项目信息"
                    toVC.experienceType = .project
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }
            case 6:
                if self.infoModel?.resumeinfo?.resumeSelfDes == nil || self.infoModel?.resumeinfo?.resumeSelfDes?.trimAfterCount() == 0
                {
                    let toVC = ZJAddSelfEvaluateController()
                    toVC.navTitle = "自我评价"
                    toVC.model = self.infoModel?.resumeinfo
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }

            default:
                break
        }
    }
}
