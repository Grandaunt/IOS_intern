//
//  ZJRecruitJobFilterController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//
//  职位筛选

import UIKit

class ZJRecruitJobFilterController: UIViewController
{
    var sureFilterAction:((String?,String?,String?)->Void)?
    fileprivate var eduArray = [ZJEduAndWorkModel]()
    fileprivate var workArray = [ZJEduAndWorkModel]()
    
    fileprivate var eduBtnArray = [UIButton]()
    fileprivate var workBtnArray = [UIButton]()
    
    fileprivate lazy var slider:CSDualWaySlider = {
        let slider = CSDualWaySlider(frame: CGRect(x: 30, y: 0, width: kScreenViewWidth - 60, height: 60), minValue: 1, maxValue: 100, blockSpaceValue: 1)
        
        slider.minIndicateView.title = "1K"
        slider.minIndicateView.backIndicateColor = kTabbarBlueColor
        slider.maxIndicateView.backIndicateColor = kTabbarBlueColor
        slider.maxIndicateView.title = "100K"
        slider.progressHeight = 3
        slider.progressRadius = 2.5
        slider.lightColor = kTabbarBlueColor
        slider.darkColor = UIColor.color(hex: "#929292")
        slider.frontScale = 0.5
        slider.frontValue = 30
        slider.showAnimate = false
        
        slider.getMinTitle = { minValue in
            if minValue == 1
            {
                return "1K"
            }
            else
            {
                return "\(Int(minValue))K"
            }
        }
        
        slider.getMaxTitle = { maxValue in
            if maxValue == 1
            {
                return "1K"
            }
            else
            {
                return "\(Int(maxValue))K"
            }
            
        }
        
        return slider
    }()

    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        return tableView
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestData()
    }
    
    fileprivate func requestData()
    {
        BaseViewModel().post(url: kGetEduAndWorkURL, param: nil, MBProgressHUD: false, success: { (resp) in
            let eduArray = resp?["entity"]["educationList"].arrayObject
            let workArray = resp?["entity"]["workList"].arrayObject
            self.eduArray = ZJEduAndWorkModel.mj_objectArray(withKeyValuesArray: eduArray) as! [ZJEduAndWorkModel]
            self.workArray = ZJEduAndWorkModel.mj_objectArray(withKeyValuesArray: workArray) as! [ZJEduAndWorkModel]
            self.tableView.reloadData()
        }, noData: nil, failure: nil)
    }
    
    fileprivate func createCell(reuseIdentifier:String,titleArray:[ZJEduAndWorkModel]) -> (UITableViewCell,[UIButton])
    {
        let btnWidth:CGFloat = 65
        let btnHeight:CGFloat = 27
        let space = (kScreenViewWidth - btnWidth*4 - 30)/3

        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .none
        var lineFirstBtn:UIButton?
        var preBtn:UIButton?
        
        var btnArray = [UIButton]()
        for (index,model) in titleArray.enumerated()
        {
            let btn = UIButton()
            btn.setTitle(model.name, for: .normal)
            btn.setTitleColor(UIColor.color(hex: "#666666"), for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.setBackgroundImage(UIImage.image(UIColor.white), for: .normal)
            btn.setBackgroundImage(UIImage.image(kTabbarBlueColor), for: .selected)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 2
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor.color(hex: "#929292").cgColor
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
            
            cell.addSubview(btn)
            btnArray.append(btn)
            let last = Double(index).truncatingRemainder(dividingBy: 4.0)
            if last == 0
            {
                if index == 0
                {
                    btn.snp.makeConstraints({ (make) in
                        make.left.equalToSuperview().offset(15)
                        make.width.equalTo(btnWidth)
                        make.height.equalTo(btnHeight)
                        make.top.equalToSuperview()
                    })
                }
                else
                {
                    btn.snp.makeConstraints({ (make) in
                        make.left.equalToSuperview().offset(15)
                        make.width.equalTo(btnWidth)
                        make.height.equalTo(btnHeight)
                        make.top.equalTo((lineFirstBtn?.snp.bottom)!).offset(15)
                    })
                    
                }
                
                if index == titleArray.count - 1
                {
                    if index == 0
                    {
                        btn.snp.makeConstraints({ (make) in
                            make.left.equalToSuperview().offset(15)
                            make.width.equalTo(btnWidth)
                            make.height.equalTo(btnHeight)
                            make.top.equalToSuperview()
                            make.bottom.equalToSuperview()
                        })
                        
                    }
                    else
                    {
                        btn.snp.makeConstraints({ (make) in
                            make.left.equalToSuperview().offset(15)
                            make.width.equalTo(btnWidth)
                            make.height.equalTo(btnHeight)
                            make.top.equalTo((lineFirstBtn?.snp.bottom)!).offset(15)
                            make.bottom.equalToSuperview()
                        })
                    }
                    
                }
                
                
                lineFirstBtn = btn
            }
            else
            {
                btn.snp.makeConstraints({ (make) in
                    make.left.equalTo((preBtn?.snp.right)!).offset(space)
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                    make.top.equalTo(preBtn!)
                })
                
                if index == titleArray.count - 1
                {
                    btn.snp.makeConstraints({ (make) in
                        make.left.equalTo((preBtn?.snp.right)!).offset(space)
                        make.width.equalTo(btnWidth)
                        make.height.equalTo(btnHeight)
                        make.top.equalTo(preBtn!)
                        make.bottom.equalToSuperview()
                    })
                    
                }
            }
            preBtn = btn
        }
        
        return (cell,btnArray)
    }
    
    @objc fileprivate func btnClicked(btn:UIButton)
    {
        btn.isSelected = !btn.isSelected
        
        if self.workBtnArray.contains(btn)
        {
            for workBtn in self.workBtnArray
            {
                if workBtn != btn
                {
                    workBtn.isSelected = false
                    workBtn.layer.borderWidth = 1
                }
                else
                {
                    workBtn.layer.borderWidth = 0
                }
            }
        }
        else
        {
            for eduBtn in self.eduBtnArray
            {
                if eduBtn != btn
                {
                    eduBtn.isSelected = false
                    eduBtn.layer.borderWidth = 1
                }
                else
                {
                    eduBtn.layer.borderWidth = 0
                }
            }
        }
    }

    @objc fileprivate func sureBtnClicked()
    {
        var postMoney:String?
        var workId:String?
        var eduId:String?
        
        //获取薪酬范围
        if self.slider.currentMinValue == 1 && self.slider.currentMaxValue == 100
        {
            postMoney = nil
        }
        else
        {
            let min = String(format: "%.f", self.slider.currentMinValue)
            let max = String(format: "%.f", self.slider.currentMaxValue)
            postMoney = min + "-" + max
        }
        
        //获取工作经验
        var selectedWorkIndex:Int?
        for (index,btn) in self.workBtnArray.enumerated()
        {
            if btn.isSelected
            {
                selectedWorkIndex = index
            }
        }
        
        if selectedWorkIndex != nil
        {
            workId = self.workArray[selectedWorkIndex!].id
        }
        
        //获取学历要求
        var selectedEduIndex:Int?
        for (index,btn) in self.eduBtnArray.enumerated()
        {
            if btn.isSelected
            {
                selectedEduIndex = index
            }
        }
        if selectedEduIndex != nil
        {
            eduId = self.eduArray[selectedEduIndex!].id
        }
        
        if self.sureFilterAction != nil
        {
            self.sureFilterAction!(postMoney,workId,eduId)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(YZUpdateMenuTitleNote), object: self, userInfo: ["title":"","name":""])
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJRecruitJobFilterController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        guard section == 2 else {
            return 0.01
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        guard section == 2 else {
            return nil
        }
        
        let footerView = UIView(frame:CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 50))
        footerView.backgroundColor = UIColor.white
        
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = kTabbarBlueColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        
        footerView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(35)
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 50))
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.color(hex: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        switch section
        {
            case 0:
                titleLabel.text = "月薪范围"
                
                let label = UILabel()
                label.textColor = kTabbarBlueColor
                label.font = UIFont.systemFont(ofSize: 13)
                label.text = "(不限)"
                headerView.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.left.equalTo(titleLabel.snp.right).offset(15)
                    make.centerY.equalTo(titleLabel)
                })
            case 1:
                titleLabel.text = "工作经验"
            case 2:
                titleLabel.text = "学历要求"
            default:
                break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard indexPath.section == 0 else {
            return UITableViewAutomaticDimension
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
            case 0:
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.selectionStyle = .none
                cell.addSubview(self.slider)
                return cell
            case 1:
                let value = self.createCell(reuseIdentifier: "cell1", titleArray: self.workArray)
                let cell = value.0
                self.workBtnArray = value.1
                return cell
            case 2:
                let value = self.createCell(reuseIdentifier: "cell2", titleArray: self.eduArray)
                let cell = value.0
                self.eduBtnArray = value.1
                return cell
            default:
                let value = self.createCell(reuseIdentifier: "cell2", titleArray: self.eduArray)
                return value.0
        }
    }
}
