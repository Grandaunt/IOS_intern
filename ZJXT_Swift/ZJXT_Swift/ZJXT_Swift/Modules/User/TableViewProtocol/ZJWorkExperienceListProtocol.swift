//
//  ZJWorkExperienceListProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/14.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJWorkExperienceListProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [Any]()  //数据
    var experienceType = ExpericenType.work
    
    @objc fileprivate func addBtnClicked()
    {
        let toVC = ZJEditWorkExperienceController()
        switch self.experienceType
        {
            case .work:
                let toVC = ZJEditWorkExperienceController()
                toVC.navTitle = "添加工作经历"
                toVC.experienceType = self.experienceType
            
            case .project:
                toVC.navTitle = "添加项目经历"
                toVC.experienceType = self.experienceType
            case .train:
                toVC.navTitle = "添加培训经历"
                toVC.experienceType = self.experienceType
            case .practice:
                toVC.navTitle = "添加实习经历"
                toVC.experienceType = self.experienceType

            
            default:
                toVC.navTitle = "添加教育经历"
                toVC.experienceType = self.experienceType
        }
        
        self.controller.navigationController?.pushViewController(toVC, animated: true)
    }
}

extension ZJWorkExperienceListProtocol:UITableViewDataSource,UITableViewDelegate
{
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
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == self.dataArray.count - 1
        {
            return 115
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if section == self.dataArray.count - 1
        {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 115))
            
            let button = UIButton()
            
            switch self.experienceType
            {
                case .work:
                    button.setTitle("添加工作经历", for: .normal)
                case .project:
                    button.setTitle("添加项目经历", for: .normal)
                case .train:
                    button.setTitle("添加培训经历", for: .normal)
                case .practice:
                    button.setTitle("添加实习经历", for: .normal)
                default:
                    button.setTitle("添加教育经历", for: .normal)
            }
            
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = kTabbarBlueColor
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 3
            button.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
            
            footerView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
                make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
                make.top.equalToSuperview().offset(25)
                make.height.equalTo(40)
            })
            return footerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJWorkExperienceListCell") as! ZJWorkExperienceListCell
        
        switch self.experienceType
        {
            case .work,.practice:
                let m = self.dataArray[indexPath.section]
                if self.experienceType == .practice
                {
                    let model = m as! ZJVCExperiencePracticeModel
                    cell.dateLabel.text = model.practiceStartTime! + " - " + model.practiceEndTime!
                    cell.companyLabel.text = model.companyName! + "/" + model.practicePost!
                    cell.infoLabel.attributedText = Utils.getAttributeStringWithString(model.practiceDes!, lineSpace: 3)
                }
                else
                {
                    let model = m as! ZJVCExperienceWorkModel
                    cell.dateLabel.text = model.workStartTime! + " - " + model.workEndTime!
                    cell.companyLabel.text = model.companyName! + "/" + model.workPost!
                    cell.infoLabel.attributedText = Utils.getAttributeStringWithString(model.workDes!, lineSpace: 3)
                }
                cell.editExperienceAction = {[weak self] in
                    let toVC = ZJEditWorkExperienceController()
                    toVC.experienceType = (self?.experienceType)!
                    toVC.isEdit = true
                    toVC.model = m
                    self?.controller.navigationController?.pushViewController(toVC, animated: true)
                    
                }

                return cell
            case .project,.train:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJProjectExperienceCell") as! ZJProjectExperienceCell
                if self.experienceType == .project
                {
                    let model = self.dataArray[indexPath.section] as! ZJVCExperienceProjectModel
                    cell.timeLabel.text = model.projectStartTime! + " - " + model.projectEndTime!
                    cell.projectNameLabel.text = "【项目名称】" + (model.projectName ?? "暂无")
                    cell.projectWorkLabel.text = "【项目职责】" + (model.projectPost ?? "暂无")
                    cell.projectInfoLabel.attributedText = Utils.getAttributeStringWithString(model.projectDes!, lineSpace: 3)
                    cell.editExperienceAction = {[weak self] in
                        let toVC = ZJEditWorkExperienceController()
                        toVC.experienceType = (self?.experienceType)!
                        toVC.isEdit = true
                        toVC.model = model
                        self?.controller.navigationController?.pushViewController(toVC, animated: true)
                        
                    }

                }
                else
                {
                    cell.projectNameLabel.text = "这是培训培训培训"
                }

                return cell

            default:
                //教育经历
                let model = self.dataArray[indexPath.section] as! ZJVCExperienceEducationModel
                
                cell.dateLabel.text = model.schoolName
                cell.companyLabel.text = model.educationStartTime! + " - " + model.educationEndTime!
                cell.infoLabel.text = (model.educationDes ?? "暂无数据") + "·" + (model.educationMajor ?? "暂无数据")
                
                cell.editExperienceAction = {[weak self] in
                    let toVC = ZJEditWorkExperienceController()
                    toVC.experienceType = (self?.experienceType)!
                    toVC.isEdit = true
                    toVC.model = model
                    self?.controller.navigationController?.pushViewController(toVC, animated: true)
                    
                }


                return cell
        }
    }
    
}
