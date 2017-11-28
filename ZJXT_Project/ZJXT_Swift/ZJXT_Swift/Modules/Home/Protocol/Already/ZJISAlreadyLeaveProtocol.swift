//
//  ZJISAlreadyLeaveProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyLeaveProtocol: NSObject
{
    weak var controller:UIViewController!
    var type:LeaveType!
    var model:ZJUserHasPracticeModel?
    
    var editModel:ZJMyBusinessTripModel? //用于展示信息
    
    fileprivate var selectStartTime:String?
    fileprivate var selectEndTime:String?
    fileprivate var direction:String?
    fileprivate var tel:String?
    fileprivate var textView:UITextView?
    
    func getData() -> (startTime:String?,endTime:String?,direction:String?,tel:String?,reason:String?)
    {
        return (self.selectStartTime,self.selectEndTime,self.direction,self.tel,self.textView?.text)
    }
    
    @objc fileprivate func textDidChanged(textField:UITextField)
    {
        if textField.tag == 4
        {
            self.direction = textField.text
        }
        else
        {
            self.tel = textField.text
        }
    }
}

extension ZJISAlreadyLeaveProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard section == 0 else {
            return 2
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard indexPath.section == 0 || indexPath.row == 0 else {
            return 120
        }
        return 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeApplyFormCell") as! ZJHomeApplyFormCell
        cell.field.isEnabled = true
        cell.field.text = ""
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell1 == nil
        {
            cell1 = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0
        {
            cell.type = .input
            switch indexPath.row
            {
                case 0:
                    if self.type == .leave
                    {
                        cell.titleLabel.text = "请假人"
                    }
                    else
                    {
                        cell.titleLabel.text = "出差人"
                    }
                    cell.field.text = UserInfo.shard.trueName
                    cell.field.isEnabled = false

                case 1:
                    cell.titleLabel.text = "实习企业"
                    cell.field.text = self.model?.companyName
                    cell.field.isEnabled = false
                
                    if self.editModel != nil
                    {
                        cell.field.text = UserInfo.shard.companyName
                    }

                case 2:
                    cell.titleLabel.text = "开始时间"
                    cell.type = .info
                    if self.selectStartTime != nil
                    {
                        cell.infoLabel.text = self.selectStartTime
                    }
                    if self.editModel != nil
                    {
                        cell.infoLabel.text = self.editModel?.leaveStartTime
                    }

                case 3:
                    cell.titleLabel.text = "结束时间"
                    cell.type = .info
                    if self.selectEndTime != nil
                    {
                        cell.infoLabel.text = self.selectEndTime
                    }
                    if self.editModel != nil
                    {
                        cell.infoLabel.text = self.editModel?.leaveEndTime
                    }
                case 4:
                    cell.titleLabel.text = "去向"
                    cell.field.tag = 4
                    cell.field.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
                    if self.editModel != nil
                    {
                        cell.field.isEnabled = false
                        cell.field.text = self.editModel?.leaveToAddress
                    }
                case 5:
                    cell.titleLabel.text = "联系方式"
                    cell.field.tag = 5
                    cell.field.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
                    if self.editModel != nil
                    {
                        cell.field.isEnabled = false
                        cell.field.text = self.editModel?.userTel
                    }

                default:
                    break
            }
            return cell
        }
        else
        {
            if indexPath.row == 0
            {
                cell.type = .none
                
                if self.type == .leave
                {
                    cell.titleLabel.text = "请假事由"
                }
                else
                {
                    cell.titleLabel.text = "出差事由"
                }
            }
            else
            {
                let textView = UITextView()
                if self.type == .leave
                {
                    textView.wzb_placeholder = "请输入请假事由，10-200字之间"
                }
                else
                {
                    textView.wzb_placeholder = "请输入出差事由，10-200字之间"
                }
                
                textView.font = UIFont.systemFont(ofSize: 16)
                self.textView = textView
                cell1?.addSubview(textView)
                textView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                
                if self.editModel != nil
                {
                    textView.isEditable = false
                    textView.text = self.editModel?.leaveDes
                }
                
                return cell1!
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && self.editModel == nil
        {
            if indexPath.row == 2 || indexPath.row == 3
            {
                let datePicker = HooDatePicker(superView:self.controller.view)
                datePicker?.title = indexPath.row == 2 ? "开始时间" : "结束时间"
                datePicker?.minimumDate = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                datePicker?.maximumDate = dateFormatter.date(from: "2050-12-31")
                datePicker?.datePickerMode = HooDatePickerMode.date
                datePicker?.selectedDateBlock = {[weak self]date in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    //                    self?.timeField.text = dateFormatter.string(from: date!)
                    if indexPath.row == 2
                    {
                        self?.selectStartTime = dateFormatter.string(from: date!)
                    }
                    else
                    {
                        self?.selectEndTime = dateFormatter.string(from: date!)
                        
                    }
                    
                    tableView.reloadRows(at: [IndexPath(row: 2, section: 0),IndexPath(row: 3, section: 0)], with: .automatic)                    
                }
                datePicker?.show()

            }
        }
    }
}
