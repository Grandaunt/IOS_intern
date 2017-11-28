//
//  ZJSchoolHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/6.
//  Copyright © 2017年 runer. All rights reserved.
//
//  校园圈子 首页

import UIKit
import MJRefresh

class ZJSchoolHomeController: BaseViewController
{
    fileprivate var currentPage = 1
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.isHidden = true
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })
        
        tableView.register(UINib(nibName: "ZJMyCircleCallCell", bundle: nil), forCellReuseIdentifier: "ZJMyCircleCallCell")
        tableView.register(UINib(nibName: "ZJMyCircleTextCell", bundle: nil), forCellReuseIdentifier: "ZJMyCircleTextCell")
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJSchoolHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJSchoolHomeProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate var addView = ZJAddCircleHomeView()
    
    fileprivate var viewModel = ZJSchoolHomeViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestData()
    }
        
    fileprivate func initView()
    {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self.addView)
        self.addView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.addView.backAction = {[weak self] in
            self?.addView.isHidden = true
        }
        self.addView.callAction = {[weak self] in
            self?.addView.isHidden = true
            let toVC = ZJAddCallController()
            toVC.navTitle = "约吧"
            self?.navigationController?.pushViewController(toVC, animated: true)
        }
        
        self.addView.sayAction = {[weak self] in
            self?.addView.isHidden = true
            let toVC = ZJAddSayController()
            toVC.navTitle = "新心情"
            self?.navigationController?.pushViewController(toVC, animated: true)

        }
        
        self.addView.backgroundColor = UIColor.white.withAlphaComponent(0.96)
        self.addView.isHidden = true
    }
    
    fileprivate func initNav()
    {
        self.navigationItem.title = "校园圈子"
        
        let img = IconFontUtils.imageSquare(code: "\u{e6da}", size: 20, color: UIColor.color(hex: "#333333")).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let rightItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(addCircle))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    fileprivate func requestData()
    {
        self.viewModel.requestList(page: self.currentPage) {[weak self] (dataArray, isNoData) in
            
            self?.tableView.isHidden = false
            
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
    
    @objc fileprivate func addCircle()
    {
        self.addView.isHidden = false
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
