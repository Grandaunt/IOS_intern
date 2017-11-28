//
//  ZJMySettingController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/10.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的设置

import MBProgressHUD

class ZJMySettingController: SecondViewController
{
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJMySettingProtocol = {[weak self] in
        let tableViewProtocol = ZJMySettingProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
