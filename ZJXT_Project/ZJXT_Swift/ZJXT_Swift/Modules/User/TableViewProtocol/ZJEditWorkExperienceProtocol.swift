//
//  ZJEditWorkExperienceProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/14.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJEditWorkExperienceProtocol: NSObject
{
    var experienceType = ExpericenType.work
    var isEdit = false  //是否编辑 否就是添加
    var model:Any?
    
    var phTextView:PlaceholderTextView!
    
    var delAction:(()->Void)?
    
    @objc fileprivate func delBtnClicked()
    {
        if self.delAction != nil
        {
            self.delAction!()
        }
    }
}

extension ZJEditWorkExperienceProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch self.experienceType
        {
            case .work,.project,.train,.practice:
                return 2
            default:
                guard section == 2 else {
                    return 2
                }
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == 2 && self.isEdit
        {
            return 90
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if section == 2 && self.isEdit
        {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 90))
            footerView.backgroundColor = UIColor.white
            
            let button = UIButton()
            
            switch self.experienceType
            {
                case .work:
                    button.setTitle("删除此工作经历", for: .normal)
                case .project:
                    button.setTitle("删除此项目经历", for: .normal)
                case .train:
                    button.setTitle("删除此培训经历", for: .normal)
                case .practice:
                    button.setTitle("删除此实习经历", for: .normal)



                default:
                    button.setTitle("删除此教育经历", for: .normal)
            }
            
            button.setTitleColor(kTabbarBlueColor, for: .normal)
            button.backgroundColor = UIColor.color(hex: "#F5F5FA")
            button.addTarget(self, action: #selector(delBtnClicked), for: .touchUpInside)
            footerView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.top.equalToSuperview().offset(25)
                make.height.equalTo(40)
            })
            
            return footerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 1 || section == 2
        {
            return 25
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 2 && indexPath.row == 1 && (self.experienceType == .work || self.experienceType == .project || self.experienceType == .train || self.experienceType == .practice)
        {
            return 150
        }
        else
        {
            return 49
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ZJEditWorkExperienceCell.cellWithTableView(tableView)
    
        
        if indexPath.section == 0
        {
            guard indexPath.row == 0 else {
                switch self.experienceType
                {
                    case .work,.practice:
                        cell.textField.placeholder = "你的职位"
                        cell.style = .input
                        if self.isEdit
                        {
                            if self.experienceType == .practice
                            {
                                let m = self.model as! ZJVCExperiencePracticeModel
                                cell.textField.text = m.practicePost
                            }
                            else
                            {
                                let m = self.model as! ZJVCExperienceWorkModel
                                cell.textField.text = m.workPost
                            }
                        }
                    case .project:
                        cell.textField.placeholder = "你的职责"
                        cell.style = .input
                        if self.isEdit
                        {
                            let m = self.model as! ZJVCExperienceProjectModel
                            cell.textField.text = m.projectPost
                        }
                    case .train:
                        cell.textField.placeholder = "培训技能"
                        cell.style = .input

                    default:
                        cell.textField.placeholder = "专业"
                        cell.style = .input
                        if self.isEdit
                        {
                            let m = self.model as! ZJVCExperienceEducationModel
                            cell.textField.text = m.educationMajor
                        }
                }
                return cell
            }
            
            switch self.experienceType
            {
                case .work,.practice:
                    cell.textField.placeholder = "公司名称"
                    cell.style = .input
                    if self.isEdit
                    {
                        if self.experienceType == .practice
                        {
                            let m = self.model as! ZJVCExperiencePracticeModel
                            cell.textField.text = m.companyName
                        }
                        else
                        {
                            let m = self.model as! ZJVCExperienceWorkModel
                            cell.textField.text = m.companyName
                        }
                    }
                case .project:
                    cell.textField.placeholder = "项目名称"
                    cell.style = .input
                    if self.isEdit
                    {
                            let m = self.model as! ZJVCExperienceProjectModel
                            cell.textField.text = m.projectName
                    }
                case .train:
                    cell.textField.placeholder = "培训机构"
                    cell.style = .input

                default:
                    cell.textField.placeholder = "学校名称"
                    cell.style = .input
                    if self.isEdit
                    {
                        let m = self.model as! ZJVCExperienceEducationModel
                        cell.textField.text = m.schoolName
                    }
            }
            
            return cell
        }
        else if indexPath.section == 1
        {
            guard indexPath.row == 0 else {
                switch self.experienceType
                {
                    case .work,.practice:
                        cell.textField.placeholder = "离职时间"
                        cell.style = .tap
                        if self.isEdit
                        {
                            if self.experienceType == .practice
                            {
                                let m = self.model as! ZJVCExperiencePracticeModel
                                cell.textField.text = m.practiceEndTime
                            }
                            else
                            {
                                let m = self.model as! ZJVCExperienceWorkModel
                                cell.textField.text = m.workEndTime
                            }
                        }
                    case .project:
                        cell.textField.placeholder = "结束时间"
                        cell.style = .tap
                        if self.isEdit
                        {
                            let m = self.model as! ZJVCExperienceProjectModel
                            cell.textField.text = m.projectEndTime
                        }
                    case .train:
                        cell.textField.placeholder = "培训结束时间"
                        cell.style = .tap

                    default:
                        cell.textField.placeholder = "毕业时间"
                        cell.style = .tap
                        if self.isEdit
                        {
                            let m = self.model as! ZJVCExperienceEducationModel
                            cell.textField.text = m.educationEndTime
                        }

                }
                return cell
            }
        
            switch self.experienceType
            {
                case .work,.practice:
                    cell.textField.placeholder = "入职时间"
                    cell.style = .tap
                    if self.isEdit
                    {
                        if self.experienceType == .practice
                        {
                            let m = self.model as! ZJVCExperiencePracticeModel
                            cell.textField.text = m.practiceStartTime
                        }
                        else
                        {
                            let m = self.model as! ZJVCExperienceWorkModel
                            cell.textField.text = m.workStartTime
                        }
                }
                case .project:
                    cell.textField.placeholder = "开始时间"
                    cell.style = .tap
                    if self.isEdit
                    {
                        let m = self.model as! ZJVCExperienceProjectModel
                        cell.textField.text = m.projectStartTime
                    }
                case .train:
                    cell.textField.placeholder = "培训结束时间"
                    cell.style = .tap


                default:
                    cell.textField.placeholder = "入学时间"
                    cell.style = .tap
                    if self.isEdit
                    {
                        let m = self.model as! ZJVCExperienceEducationModel
                        cell.textField.text = m.educationStartTime
                    }
            }
            return cell

        }
        else
        {
            
            switch self.experienceType
            {
                case .work,.project,.train,.practice:
                    if indexPath.row == 0
                    {
                        if self.experienceType == .work || self.experienceType == .practice
                        {
                            cell.textField.placeholder = "工作内容"
                        }
                        else if self.experienceType == .project
                        {
                            cell.textField.placeholder = "项目描述"
                        }
                        else
                        {
                            cell.textField.placeholder = "培训内容"
                        }
                        cell.style = .info
                        cell.bottomLineStyle = .none
                        return cell
                    }
                    else
                    {
                        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                        if cell == nil
                        {
                            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                        }
                        
                        let phTextView = PlaceholderTextView()
                        self.phTextView = phTextView
                        
                        if self.experienceType == .work || self.experienceType == .practice
                        {
                            phTextView.placeholder = "详细描述工作内容"
                        }
                        else if self.experienceType == .project
                        {
                            phTextView.placeholder = "详细描述项目内容"
                        }
                        else
                        {
                            phTextView.placeholder = "详细描述培训内容"

                        }
                        
                        if self.isEdit
                        {
                            if self.experienceType == .practice
                            {
                                let m = self.model as! ZJVCExperiencePracticeModel
                                phTextView.text = m.practiceDes
                            }
                            else if self.experienceType == .work
                            {
                                let m = self.model as! ZJVCExperienceWorkModel
                                phTextView.text = m.workDes
                            }
                            else if self.experienceType == .project
                            {
                                let m = self.model as! ZJVCExperienceProjectModel
                                phTextView.text = m.projectDes
                            }
                        }
                        
                        phTextView.placeholderLabel.textColor = UIColor.color(hex: "#CCCCCC")
                        phTextView.placeholderLabel.font = UIFont.systemFont(ofSize: 16)
                        phTextView.font = UIFont.systemFont(ofSize: 16)
                        phTextView.backgroundColor = UIColor.color(hex: "#F5F5FA")
                        phTextView.layer.masksToBounds = true
                        phTextView.layer.cornerRadius = 3
                        
                        phTextView.maxLength = 1600
                        
                        cell?.addSubview(phTextView)
                        
                        phTextView.snp.makeConstraints({ (make) in
                            make.top.bottom.equalToSuperview()
                            make.left.equalToSuperview().offset(15)
                            make.right.equalToSuperview().offset(-15)
                        })
                        
                        return cell!
                    }
                default:
                    cell.textField.placeholder = "学历"
                    cell.style = .input
                    if self.isEdit
                    {
                        let m = self.model as! ZJVCExperienceEducationModel
                        cell.textField.text = m.educationDes
                    }
                    return cell

                }


        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch self.experienceType
        {
        case .practice,.work,.edu,.project:
            if indexPath.section == 1
            {
                let cell = tableView.cellForRow(at: indexPath) as! ZJEditWorkExperienceCell

                if indexPath.row == 0
                {
                    let datePicker = HooDatePicker(superView:tableView.superview)
                    datePicker?.title = "入职时间"
                    datePicker?.datePickerMode = HooDatePickerMode.yearAndMonth
                    datePicker?.selectedDateBlock = {date in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM"
                        cell.textField.text = dateFormatter.string(from: date!)
                    }
                    datePicker?.show()
                }
                else
                {
                    let datePicker = HooDatePicker(superView:tableView.superview)
                    datePicker?.title = "离职时间"
                    datePicker?.datePickerMode = HooDatePickerMode.yearAndMonth
                    datePicker?.selectedDateBlock = {date in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM"
                        cell.textField.text = dateFormatter.string(from: date!)
                    }
                    datePicker?.show()

                }
            }
        default:
            break
        }
    }
}
