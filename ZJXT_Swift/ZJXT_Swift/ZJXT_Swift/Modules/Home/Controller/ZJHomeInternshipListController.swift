//
//  ZJHomeInternshipListController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//
//  实习列表

import UIKit
import MJRefresh

enum InternShipPlaceType:Int {
    case base = 0  //基地
    case enterprise  //企业
}

class ZJHomeInternshipListController: SecondViewController
{
    
    var type = InternShipPlaceType.base
    var selectBaseAction:((ZJBaseListModel)->Void)?  //选择基地
    var selectEnAction:((ZJInternshipJobModel)->Void)?  //选择自主
    
    fileprivate var currentPage = 1
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestBase()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestBase()
        })
        
        tableView.register(UINib(nibName: "ZJHomeInternShipListCell", bundle: nil), forCellReuseIdentifier: "ZJHomeInternShipListCell")
        tableView.register(UINib(nibName: "ZJHomeInternshipJobCell", bundle: nil), forCellReuseIdentifier: "ZJHomeInternshipJobCell")
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJHomeInternshipListProtocol = {[weak self] in
        let tableViewProtocol = ZJHomeInternshipListProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.type = self?.type
        return tableViewProtocol
    }()
    
    fileprivate lazy var viewModel = ZJHomeInternshipListViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        if self.type == .base
        {
            self.requestBase()
        }
        else
        {
            self.requestEn()
        }
    }
    
    fileprivate func initNav()
    {
        if self.type == .enterprise
        {
            let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            rightBtn.addTarget(self, action: #selector(addEn), for: .touchUpInside)
            rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            rightBtn.setTitle("添加", for: .normal)
            rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            let rightItem = UIBarButtonItem(customView: rightBtn)
            self.navigationItem.rightBarButtonItem = rightItem
        }
    }
    
    @objc fileprivate func addEn()
    {
        let toVC = ZJAddEnterpriseController()
        toVC.navTitle = "添加企业"
        toVC.saveAction = {[weak self] model in
            var dataArray = self?.tableViewProtocol.dataArray
            dataArray?.append(model)
            self?.tableViewProtocol.dataArray = dataArray!
            self?.tableView.reloadData()
        }
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    //基地实习
    fileprivate func requestBase()
    {
        self.viewModel.requestBaseList(page: self.currentPage) {[weak self] (dataArray, isNoData) in
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
    
    //企业实习 自主实习
    fileprivate func requestEn()
    {
        self.viewModel.requestEnList(page: self.currentPage) {[weak self] (dataArray, isNoData) in
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
