//
//  ZJISAlreadyDimissionController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//
//  离职

import UIKit

class ZJISAlreadyDimissionController: SecondViewController
{
    var model:ZJUserHasPracticeModel?

    fileprivate lazy var tableViewProtocol:ZJISAlreadyDimissionProtocol = {[weak self] in
        let tableViewProtocol = ZJISAlreadyDimissionProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.model = self?.model
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
        rightBtn.setTitle("提交", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
