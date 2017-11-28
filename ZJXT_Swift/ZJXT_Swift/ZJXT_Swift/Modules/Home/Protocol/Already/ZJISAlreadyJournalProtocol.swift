//
//  ZJISAlreadyJournalProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyJournalProtocol: NSObject
{
    weak var controller:UIViewController!
    var model:ZJUserHasPracticeModel!
    
    var editModel:ZJMyLogModel?  //用于展示数据
    
    fileprivate var textView1:UITextView?
    fileprivate var textView2:UITextView?
    
    func getText() -> (String,String)
    {
        return (self.textView1!.text,self.textView2!.text)
    }
}

extension ZJISAlreadyJournalProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
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
            if indexPath.row == 0
            {
                cell.titleLabel.text = "实习企业"
                cell.field.isEnabled = false
                if self.editModel != nil
                {
                    cell.field.text = UserInfo.shard.companyName
                }
                else
                {
                    cell.field.text = self.model.companyName
                }
            }
            else
            {
                cell.titleLabel.text = "实习地点"
                cell.field.isEnabled = false
                if self.editModel != nil
                {
                    cell.field.text = "暂无"
                }
                else
                {
                    cell.field.text = self.model.basePlanAddres
                }
            }
            return cell
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                cell.type = .none
                cell.titleLabel.text = "实习内容"
            }
            else
            {
                let textView = UITextView()
//                textView.placeholderFont = UIFont.systemFont(ofSize: 16)
                textView.font = UIFont.systemFont(ofSize: 16)
                self.textView1 = textView
                cell1?.addSubview(textView)
                textView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                
                if self.editModel != nil
                {
                    textView.text = self.editModel?.dayReportContent
                    textView.isEditable = false
                }
                else
                {
                    textView.isEditable = true
                    textView.wzb_placeholder = "请填写实习内容，10-200字之间"
                }
                
                return cell1!
            }
            return cell
        }
        else
        {
            if indexPath.row == 0
            {
                cell.type = .none
                cell.titleLabel.text = "工作总结"
            }
            else
            {
                let textView = UITextView()
                textView.font = UIFont.systemFont(ofSize: 16)
                self.textView2 = textView

                cell1?.addSubview(textView)
                textView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                
                if self.editModel != nil
                {
                    textView.text = self.editModel?.dayReportExperience
                    textView.isEditable = false
                }
                else
                {
                    textView.isEditable = true
                    textView.wzb_placeholder = "请填写工作总结，10-200字之间"
                }

                return cell1!
            }
            return cell

        }
    }
}
