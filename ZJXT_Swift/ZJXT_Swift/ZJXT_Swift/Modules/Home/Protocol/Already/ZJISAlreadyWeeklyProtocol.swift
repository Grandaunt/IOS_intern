//
//  ZJISAlreadyWeeklyProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyWeeklyProtocol: NSObject
{
    weak var controller:UIViewController!
    var model:ZJUserHasPracticeModel?
    var editModel:ZJMyWeeklyJournalModel?  //用于展示详情
    
    fileprivate var textViewAll:UITextView?  //小结
    fileprivate var textViewNext:UITextView?  //下周计划
    
    //周一到周五的textView
    fileprivate lazy var textView1:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    fileprivate lazy var textView2:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isHidden = true
        return textView

    }()
    fileprivate lazy var textView3:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isHidden = true
        return textView
    }()
    fileprivate lazy var textView4:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isHidden = true
        return textView
    }()
    fileprivate lazy var textView5:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isHidden = true
        return textView
    }()

    
    fileprivate var weekBtnArray = [UIButton]()
    fileprivate var textViewArray = [UITextView]()
    
    @objc fileprivate func weekBtnClicked(btn:UIButton)
    {
        btn.isSelected = true
        for (index,tempBtn) in self.weekBtnArray.enumerated()
        {
            let textView = self.textViewArray[index]
            if tempBtn != btn
            {
                tempBtn.isSelected = false
                textView.isHidden = true
            }
            else
            {
                textView.isHidden = false
                textView.becomeFirstResponder()
            }
        }
    }
    
    func getData()->(String?,String?,String?,String?,String?,String?,String?) //开始时间 结束时间 周一 周二 周三 周四 周五 小结 下周计划
    {
        return (self.textView1.text,self.textView2.text,self.textView3.text,self.textView4.text,self.textView5.text,self.textViewAll?.text,self.textViewNext?.text)
    }

}

extension ZJISAlreadyWeeklyProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 4
        }
        else if section == 1
        {
            return 3
        }
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
        guard indexPath.section == 0 || indexPath.row == 0 || (indexPath.section == 1 && indexPath.row == 1) else {
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
        cell1?.selectionStyle = .none
        
        if indexPath.section == 0
        {
            cell.type = .input
            let weekDay = Date.getCurrentWeek()
            if indexPath.row == 0
            {
                cell.titleLabel.text = "开始时间"
                cell.type = .info
                cell.infoLabel.text = weekDay.startTime
                
                if self.editModel != nil
                {
                    cell.infoLabel.text = self.editModel?.mondayTime
                }
            }
            else if indexPath.row == 1
            {
                cell.titleLabel.text = "结束时间"
                cell.type = .info
                cell.infoLabel.text = weekDay.endTime
                
                if self.editModel != nil
                {
                    cell.infoLabel.text = self.editModel?.sundayTime
                }

            }
            else if indexPath.row == 2
            {
                cell.titleLabel.text = "实习企业"
                cell.field.text = self.model?.companyName
                cell.field.isEnabled = false
                
                if self.editModel != nil
                {
                    cell.field.text = UserInfo.shard.companyName
                }

            }
            else
            {
                cell.titleLabel.text = "实习地点"
                cell.field.text = self.model?.basePlanAddres
                cell.field.isEnabled = false
                
                if self.editModel != nil
                {
                    cell.field.text = "暂无"
                }


            }
            return cell
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                cell.type = .none
                cell.titleLabel.text = "工作简述"
            }
            else if indexPath.row == 1
            {
                let space:CGFloat = 15
                let btnWidth = (kScreenViewWidth - 6 * space)/5
                let btnHeight = 30
                
                self.weekBtnArray.removeAll()
                var preBtn:UIButton?
                
                let titleArray = ["周一","周二","周三","周四","周五"]
                for (index,title) in titleArray.enumerated()
                {
                    let btn = UIButton()
                    btn.setTitle(title, for: .normal)
                    btn.setTitleColor(UIColor.color(hex: "#333333"), for: .normal)
                    btn.setTitleColor(UIColor.white, for: .selected)
                    btn.setBackgroundImage(UIImage.image(UIColor.white), for: .normal)
                    btn.setBackgroundImage(UIImage.image(kTabbarBlueColor), for: .selected)
                    btn.addTarget(self, action: #selector(weekBtnClicked(btn:)), for: .touchUpInside)
                    btn.layer.masksToBounds = true
                    btn.layer.cornerRadius = 15
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    cell1?.addSubview(btn)
                    if index == 0
                    {
                        btn.isSelected = true
                        btn.snp.makeConstraints({ (make) in
                            make.centerY.equalToSuperview()
                            make.left.equalToSuperview().offset(space)
                            make.width.equalTo(btnWidth)
                            make.height.equalTo(btnHeight)
                        })
                    }
                    else
                    {
                        btn.snp.makeConstraints({ (make) in
                            make.centerY.equalToSuperview()
                            make.left.equalTo((preBtn?.snp.right)!).offset(space)
                            make.width.equalTo(btnWidth)
                            make.height.equalTo(btnHeight)
                        })

                    }
                    
                    preBtn = btn
                    self.weekBtnArray.append(btn)
                }
                return cell1!
            }
            else
            {
                self.textView1.isHidden = false
                cell1?.addSubview(self.textView1)
                self.textView1.isHidden = false
                self.textView1.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                cell1?.addSubview(self.textView2)
                self.textView2.snp.makeConstraints({ (make) in
                    make.edges.equalTo(self.textView1)
                })
                cell1?.addSubview(self.textView3)
                self.textView3.snp.makeConstraints({ (make) in
                    make.edges.equalTo(self.textView1)
                })
                cell1?.addSubview(self.textView4)
                self.textView4.snp.makeConstraints({ (make) in
                    make.edges.equalTo(self.textView1)
                })
                cell1?.addSubview(self.textView5)
                self.textView5.snp.makeConstraints({ (make) in
                    make.edges.equalTo(self.textView1)
                })

                self.textViewArray.removeAll()
                self.textViewArray = [self.textView1,self.textView2,self.textView3,self.textView4,self.textView5]
                
                if self.editModel != nil
                {
                    self.textView1.isEditable = false
                    self.textView2.isEditable = false
                    self.textView3.isEditable = false
                    self.textView4.isEditable = false
                    self.textView5.isEditable = false
                    
                    self.textView1.text = self.editModel?.mondayContent
                    self.textView2.text = self.editModel?.tuesdayContent
                    self.textView3.text = self.editModel?.wednesdayContent
                    self.textView4.text = self.editModel?.thursdayContent
                    self.textView5.text = self.editModel?.fridayContent
                }
                else
                {
                    self.textView1.isEditable = true
                    self.textView2.isEditable = true
                    self.textView3.isEditable = true
                    self.textView4.isEditable = true
                    self.textView5.isEditable = true

                    self.textView1.wzb_placeholder = "请输入工作简述，10-200字之间"
                    self.textView2.wzb_placeholder = "请输入工作简述，10-200字之间"
                    self.textView3.wzb_placeholder = "请输入工作简述，10-200字之间"
                    self.textView4.wzb_placeholder = "请输入工作简述，10-200字之间"
                    self.textView5.wzb_placeholder = "请输入工作简述，10-200字之间"

                }
                
                return cell1!
            }
            return cell
        }
        else if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                cell.type = .none
                cell.titleLabel.text = "本周小结"
            }
            else
            {
                let textView = UITextView()
                textView.font = UIFont.systemFont(ofSize: 16)
                self.textViewAll = textView
                
                cell1?.addSubview(textView)
                textView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                
                if self.editModel != nil
                {
                    textView.isEditable = false
                    textView.text = self.editModel?.weekReportExperience
                }
                else
                {
                    textView.isEditable = true
                    textView.wzb_placeholder = "请输入本周小结，10-200字之间"
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
                cell.titleLabel.text = "下周计划"
            }
            else
            {
                let textView = UITextView()
                textView.font = UIFont.systemFont(ofSize: 16)
                self.textViewNext = textView
                
                cell1?.addSubview(textView)
                textView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-15)
                })
                
                if self.editModel != nil
                {
                    textView.isEditable = false
                    textView.text = self.editModel?.nextWeekPlan
                }
                else
                {
                    textView.isEditable = true
                    textView.wzb_placeholder = "请输入下周计划，10-200字之间"
                }
                
                return cell1!
            }
            return cell
            
        }

    }
}
