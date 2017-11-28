//
//  ZJISAlreadyWeeklyController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJISAlreadyWeeklyController: SecondViewController
{
    var model:ZJUserHasPracticeModel?
    var editModel:ZJMyWeeklyJournalModel?  //用于展示详情

    fileprivate lazy var tableViewProtocol:ZJISAlreadyWeeklyProtocol = {[weak self] in
        let tableViewProtocol = ZJISAlreadyWeeklyProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.model = self?.model
        tableViewProtocol.editModel = self?.editModel
        return tableViewProtocol
    }()
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "ZJHomeApplyFormCell", bundle: nil), forCellReuseIdentifier: "ZJHomeApplyFormCell")
        
        return tableView
    }()
    
    fileprivate var locationCor:(longitude:String,latitude:String)?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.initLocation()
    }
    
    fileprivate func initLocation()
    {
        LocationManager.startLocation(finish: { (location) in
            
            let longitude = String(format: "%.6f", Double(location.longitude)) //精度
            let latitude = String(format: "%.6f", Double(location.latitude))  //纬度
            self.locationCor = (longitude,latitude)
            
        }) { (marks) in
            
        }
    }
    
    fileprivate func initNav()
    {
        if self.editModel != nil
        {
            return
        }
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        rightBtn.setTitle("提交", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func save()
    {
        let data = self.tableViewProtocol.getData()
        
        if data.0?.trimAfterCount() == 0 || data.1?.trimAfterCount() == 0 || data.2?.trimAfterCount() == 0 || data.3?.trimAfterCount() == 0 || data.4?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写完整工作内容")
            return
        }
        
        if data.5?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写本周小结")
            return
        }
        
        if data.6?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写下周计划")
            return
        }
        
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["practiceId"] = self.model?.userPracticeId
        param["weekpost"] = self.model?.practicePost
        param["weekReportExperience"] = data.5
        param["nextWeekPlan"] = data.6
        param["weekReportAddress"] = (self.locationCor?.longitude ?? "") + "," + (self.locationCor?.latitude ?? "")
        param["mondayContent"] = data.0
        param["tuesdayContent"] = data.1
        param["wednesdayContent"] = data.2
        param["thursdayContent"] = data.3
        param["fridayContent"] = data.4
        
        //这个接口请求相对简单，所以不封装viewmdeol了
        BaseViewModel().post(url: kAddWeeklyURL, param: param, MBProgressHUD: true, success: { (resp) in
            MBProgressHUD.show(info: "添加成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }, noData: nil, failure: nil)


    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
