//
//  ZJRecruitCompanyFilterController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/30.
//  Copyright © 2017年 runer. All rights reserved.
//
//  公司筛选

import UIKit

class ZJRecruitCompanyFilterController: UIViewController
{
    var sureFilterAction:((String?,String?)->Void)?

    fileprivate var capitalArray = [ZJEduAndWorkModel]()  //融资
    fileprivate var indstryArray = [ZJEduAndWorkModel]()  //类型
    
    fileprivate var capitalBtnArray = [UIButton]()
    fileprivate var indstryBtnArray = [UIButton]()
    
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
        self.requestData()
    }
    
    fileprivate func requestData()
    {
        BaseViewModel().post(url: kGetCapAndIndURL, param: nil, MBProgressHUD: false, success: { (resp) in
            let capitalArray = resp?["entity"]["capitalList"].arrayObject
            let indstryArray = resp?["entity"]["indstryList"].arrayObject
            self.capitalArray = ZJEduAndWorkModel.mj_objectArray(withKeyValuesArray: capitalArray) as! [ZJEduAndWorkModel]
            self.indstryArray = ZJEduAndWorkModel.mj_objectArray(withKeyValuesArray: indstryArray) as! [ZJEduAndWorkModel]
            self.view.addSubview(self.tableView)
            self.tableView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
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
                        btn.snp.remakeConstraints({ (make) in
                            make.left.equalToSuperview().offset(15)
                            make.width.equalTo(btnWidth)
                            make.height.equalTo(btnHeight)
                            make.top.equalToSuperview()
                            make.bottom.equalToSuperview()
                        })
                        
                    }
                    else
                    {
                        btn.snp.remakeConstraints({ (make) in
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
                    btn.snp.remakeConstraints({ (make) in
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
        if self.capitalBtnArray.contains(btn)
        {
            for capBtn in self.capitalBtnArray
            {
                if capBtn != btn
                {
                    capBtn.isSelected = false
                    capBtn.layer.borderWidth = 1
                }
                else
                {
                    capBtn.layer.borderWidth = 0
                }
            }
        }
        else
        {
            for insBtn in self.indstryBtnArray
            {
                if insBtn != btn
                {
                    insBtn.isSelected = false
                    insBtn.layer.borderWidth = 1
                }
                else
                {
                    insBtn.layer.borderWidth = 0
                }
            }
        }
    }
    
    @objc fileprivate func sureBtnClicked()
    {
        var capId:String?
        var insId:String?
        
        //获取工作经验
        var selectedCapIndex:Int?
        for (index,btn) in self.capitalBtnArray.enumerated()
        {
            if btn.isSelected
            {
                selectedCapIndex = index
            }
        }
        
        if selectedCapIndex != nil
        {
            capId = self.capitalArray[selectedCapIndex!].id
        }
        
        //获取学历要求
        var selectedInsIndex:Int?
        for (index,btn) in self.indstryBtnArray.enumerated()
        {
            if btn.isSelected
            {
                selectedInsIndex = index
            }
        }
        if selectedInsIndex != nil
        {
            insId = self.indstryArray[selectedInsIndex!].id
        }
        
        if self.sureFilterAction != nil
        {
            self.sureFilterAction!(capId,insId)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(YZUpdateMenuTitleNote), object: self, userInfo: ["title":"","name":""])
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJRecruitCompanyFilterController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        guard section == 1 else {
            return 0.01
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        guard section == 1 else {
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
            titleLabel.text = "融资阶段"
        case 1:
            titleLabel.text = "行业领域"
        default:
            break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
            case 0:
                let value = self.createCell(reuseIdentifier: "cell1", titleArray: self.capitalArray)
                self.capitalBtnArray = value.1
                return value.0
            default:
                let value = self.createCell(reuseIdentifier: "cell2", titleArray: self.indstryArray)
                self.indstryBtnArray = value.1
                return value.0
            }
    }
}
