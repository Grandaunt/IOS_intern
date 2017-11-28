//
//  ZJISAlreadyLeaveController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//
//  请假，出差

import UIKit
import MBProgressHUD

enum LeaveType:Int
{
    case leave = 0 //请假
    case trip //出差
}

class ZJISAlreadyLeaveController: SecondViewController
{

    var model:ZJUserHasPracticeModel?
    var type:LeaveType = .leave
    var editModel:ZJMyBusinessTripModel?
    
    fileprivate lazy var tableViewProtocol:ZJISAlreadyLeaveProtocol = {[weak self] in
        let tableViewProtocol = ZJISAlreadyLeaveProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.type = (self?.type)!
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    fileprivate func initNav()
    {
        if self.editModel != nil
        {
            return
        }
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("提交", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func save()
    {
        let data = self.tableViewProtocol.getData()
        if data.startTime?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请选择开始时间")
            return
        }
        if data.endTime?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请选择结束时间")
            return
        }
        
        if data.direction?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写去向")
            return
        }
        if data.tel?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写联系方式")
            return
        }
        if data.reason?.trimAfterCount() == 0
        {
            if self.type == .leave
            {
                MBProgressHUD.show(error: "请填写请假事由")

            }
            else
            {
                MBProgressHUD.show(error: "请填写出差事由")
            }
            return
        }
        
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["practiceId"] = self.model?.userPracticeId
        param["leaveDes"] = data.reason
        param["leaveStartTime"] = data.startTime
        param["leaveEndTime"] = data.endTime
        param["userTel"] = data.tel
        param["leaveToAddress"] = data.direction
        param["checkStatus"] = 1  //这个不知道传不传

        var url:String?
        if self.type == .leave
        {
            param["leaveType"] = 1 //1请假 2出差
            url = kAddLeaveURL
        }
        else
        {
            param["leaveType"] = 1 //1请假 2出差
            url = kAddTripURL
        }
        //这个接口请求相对简单，所以不封装viewmodel了
        BaseViewModel().post(url: url!, param: param, MBProgressHUD: true, success: { (resp) in
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
