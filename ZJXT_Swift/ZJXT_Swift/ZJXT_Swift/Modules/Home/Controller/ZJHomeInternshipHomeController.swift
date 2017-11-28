//
//  ZJHomeInternshipHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MJRefresh

class ZJHomeInternshipHomeController: SecondViewController {

    fileprivate var currentPage = 1
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = self?.createHeaderView()
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })

        
        tableView.register(UINib(nibName: "ZJHomeInternshipJobCell", bundle: nil), forCellReuseIdentifier: "ZJHomeInternshipJobCell")
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJHomeInternshipHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJHomeInternshipHomeProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate lazy var viewModel = ZJHomeInternshipHomeViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestData()
    }
    
    fileprivate func createHeaderView() -> UIView
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 95))
        
        let button = UIButton(type:.custom)
        button.addTarget(self, action: #selector(applyBtnClicked), for: .touchUpInside)
        button.backgroundColor = UIColor.color(hex: "#00B9F6")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3
        
        let tempBtn = UIButton()
        tempBtn.setImage(IconFontUtils.imageSquare(code: "\u{e6d8}", size: 25, color: UIColor.white), for: .normal)
        tempBtn.setTitle("  申请实习", for: .normal)
        tempBtn.setTitleColor(UIColor.white, for: .normal)
        tempBtn.isUserInteractionEnabled = false
        button.addSubview(tempBtn)
        tempBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        headerView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(kHomeEdgeSpace)
            make.bottom.right.equalToSuperview().offset(-kHomeEdgeSpace)
        }
        
        return headerView
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
    
    @objc fileprivate func applyBtnClicked()
    {
        let toVC = ZJHomeApplyInternShipController()
        toVC.navTitle = "申请实习"
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
