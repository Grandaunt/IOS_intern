//
//  ZJISAlreadyQuestionController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJISAlreadyQuestionController: SecondViewController
{

    fileprivate lazy var tableViewProtocol:ZJISAlreadyQuestionProtocol = {[weak self] in
        let tableViewProtocol = ZJISAlreadyQuestionProtocol()
        tableViewProtocol.controller = self
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
        if data.title?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请输入标题")
            return
        }
        if data.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请输入问题正文")
            return
        }
        
        var param = [String:Any]()
        param["questionUserId"] = UserInfo.shard.userId
        param["questionTitle"] = data.title
        param["questionContent"] = data.text
        param["questionLevel"] = data.isNormal ? 1 : 2

        //这个接口请求相对简单，所以不封装viewmodel了
        BaseViewModel().post(url: kAddQuestionURL, param: param, MBProgressHUD: true, success: { (resp) in
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
