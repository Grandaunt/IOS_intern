//
//  ZJISAlreadyQuestionProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyQuestionProtocol: NSObject
{
    weak var controller:UIViewController!
    
    fileprivate var textView:UITextView?
    fileprivate var titleStr = ""
    fileprivate var leftBtn:UIButton?
    fileprivate var rightBtn:UIButton?
    
    func getData()->(title:String?,text:String?,isNormal:Bool)
    {
        return (self.titleStr,self.textView?.text,(self.leftBtn?.isSelected)! ? false : true)
    }
    
    @objc fileprivate func textDidChanged(textField:UITextField)
    {
        self.titleStr = textField.text!
    }
    
    //紧急程度点击方法
    @objc fileprivate func btnClicked(btn:UIButton)
    {
        btn.isSelected = true
        if btn == self.leftBtn
        {
            self.rightBtn?.isSelected = false
        }
        else
        {
            self.leftBtn?.isSelected = false
        }
    }
}

extension ZJISAlreadyQuestionProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard section == 0 else {
            return 2
        }
        return 1
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
        if indexPath.row == 0 || (indexPath.section == 2 && indexPath.row == 1)
        {
            return 49
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeApplyFormCell") as! ZJHomeApplyFormCell
        cell.selectionStyle = .none
        
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell1 == nil
        {
            cell1 = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell1?.selectionStyle = .none
        }
        
        if indexPath.section == 0
        {
            cell.type = .input
            cell.titleLabel.text = "标题"
            cell.field.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
            return cell
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                cell.type = .none
                cell.titleLabel.text = "问题正文"
            }
            else
            {
                let textView = UITextView()
                textView.wzb_placeholder = "问题详情，10-200字之间"
                textView.font = UIFont.systemFont(ofSize: 16)
                self.textView = textView
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
        else
        {
            if indexPath.row == 0
            {
                cell.type = .none
                cell.titleLabel.text = "紧急程度"
            }
            else
            {
                let leftBtn = UIButton()
                leftBtn.setImage(UIImage(named:"question_critical"), for: .normal)
                leftBtn.setImage(UIImage(named:"question_critical_select"), for: .selected)
                leftBtn.isSelected = true
                leftBtn.setTitle("  紧急问题", for: .normal)
                leftBtn.setTitleColor(UIColor.color(hex: "#929292"), for: .normal)
                leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                leftBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
                self.leftBtn = leftBtn
                cell1?.addSubview(leftBtn)
                leftBtn.snp.makeConstraints({ (make) in
                    make.centerY.equalToSuperview()
                    make.left.equalToSuperview().offset(15)
                })
                
                let rightBtn = UIButton()
                rightBtn.setImage(UIImage(named:"question_normal"), for: .normal)
                rightBtn.setImage(UIImage(named:"question_normal_select"), for: .selected)
                rightBtn.setTitle("  普通问题", for: .normal)
                rightBtn.setTitleColor(UIColor.color(hex: "#929292"), for: .normal)
                rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                rightBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
                self.rightBtn = rightBtn
                
                cell1?.addSubview(rightBtn)
                rightBtn.snp.makeConstraints({ (make) in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(leftBtn.snp.right).offset(60)
                })
                
                return cell1!

                
            }
            return cell
            
        }
    }
}
