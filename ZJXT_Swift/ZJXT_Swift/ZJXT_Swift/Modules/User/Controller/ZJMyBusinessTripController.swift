//
//  ZJMyBusinessTripController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的出差

import UIKit
import MJRefresh

class ZJMyBusinessTripController: SecondViewController
{
    var isTrip:Bool = true  //是否是出差  true出差 false请假
    fileprivate var noDataView = ZJNoDataView.noDataView(img: UIImage(named:"noLog")!, title: "暂无填写任何数据", info: "")
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })
        tableView.register(UINib(nibName: "ZJMyWeeklyJournalCell", bundle: nil), forCellReuseIdentifier: "ZJMyWeeklyJournalCell")
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJMyBusinessTripProtocol = {[weak self] in
        let tableViewProtocol = ZJMyBusinessTripProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate var currentPage = 1
    fileprivate var viewModel = ZJMyBusinessTripViewModel()
    
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
        if self.isTrip
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
                
                if dataArray.count == 0
                {
                    self?.noDataView.isHidden = false
                }
                else
                {
                    self?.noDataView.isHidden = true
                }
            }
        }
        else
        {
            self.viewModel.requestEventList(page: self.currentPage) {[weak self] (dataArray, isNoData) in
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
                
                if dataArray.count == 0
                {
                    self?.noDataView.isHidden = false
                }
                else
                {
                    self?.noDataView.isHidden = true
                }
            }

        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
