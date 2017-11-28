//
//  ZJISAlreadyJournalController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//
//  日志

import UIKit
import MBProgressHUD

class ZJISAlreadyJournalController: SecondViewController
{
    
    var model:ZJUserHasPracticeModel?
    
    var editModel:ZJMyLogModel?  //用于展示已写日志
    
    fileprivate lazy var tableViewProtocol:ZJISAlreadyJournalProtocol = {[weak self] in
        let tableViewProtocol = ZJISAlreadyJournalProtocol()
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
        let texts = self.tableViewProtocol.getText()
        
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["practiceId"] = self.model?.userPracticeId
        param["dayReportContent"] = texts.0
        param["dayReportExperience"] = texts.1
        param["dayReportType"] = 1
        
        //这个接口请求相对简单，所以不封装viewmdeol了
        BaseViewModel().post(url: kAddJournalURL, param: param, MBProgressHUD: true, success: { (resp) in
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
