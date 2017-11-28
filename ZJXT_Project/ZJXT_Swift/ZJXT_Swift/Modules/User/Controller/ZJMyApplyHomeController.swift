//
//  ZJApplyHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的申请

import UIKit
import MJRefresh

class ZJMyApplyHomeController: SecondViewController
{
    fileprivate var currentPage = 1
    fileprivate lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kBackgroundColor
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })
        
        tableView.register(UINib(nibName: "ZJMyApplyHomeCell", bundle: nil), forCellReuseIdentifier: "ZJMyApplyHomeCell")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJMyApplyHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJMyApplyHomeProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate lazy var viewModel = ZJMyApplyHomeViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.requestData()
    }
    
    fileprivate func requestData()
    {
        self.viewModel.requestList(page: self.currentPage) {[weak self] (dataArray, isNoData) in
            self?.tableViewProtocol.dataArray = dataArray
            self?.tableView.reloadData()

            self?.tableView.mj_header.endRefreshing()
            if isNoData
            {
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            else
            {
                self?.tableView.mj_footer.endRefreshing()
            }
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
