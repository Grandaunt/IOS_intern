//
//  ZJISAlreadyDimissionProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyDimissionProtocol: NSObject
{
    weak var controller:UIViewController!
    var model:ZJUserHasPracticeModel!
    
    fileprivate var selectStartTime:String?
    fileprivate var selectEndTime:String?
}

extension ZJISAlreadyDimissionProtocol:UITableViewDelegate,UITableViewDataSource
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
        return 5
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
        
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell1 == nil
        {
            cell1 = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0
        {
            cell.type = .input
            cell.field.isEnabled = true
            switch indexPath.row
            {
            case 0:
                cell.titleLabel.text = "申请人"
                cell.field.text = UserInfo.shard.trueName
                cell.field.isEnabled = false
                
            case 1:
                cell.titleLabel.text = "实习企业"
                cell.field.text = self.model.companyName
                cell.field.isEnabled = false
                
            case 2:
                cell.titleLabel.text = "入职时间"
                cell.type = .info
            case 3:
                cell.titleLabel.text = "离职时间"
                cell.type = .info
            case 4:
                cell.titleLabel.text = "联系方式"
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
                cell.titleLabel.text = "离职原因"
            }
            else
            {
                let textView = UITextView()
                textView.wzb_placeholder = "请输入离职原因，10-200字之间"
                textView.font = UIFont.systemFont(ofSize: 16)
                cell1?.addSubview(textView)
                textView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                
                return cell1!
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0
        {
            if indexPath.row == 2 || indexPath.row == 3
            {
                let datePicker = HooDatePicker(superView:self.controller.view)
                datePicker?.title = indexPath.row == 2 ? "入职时间" : "离职时间"
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
                    tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 0, length: 1)) as IndexSet, with: .automatic)
                    
                }
                datePicker?.show()
                
            }
        }
    }
}
