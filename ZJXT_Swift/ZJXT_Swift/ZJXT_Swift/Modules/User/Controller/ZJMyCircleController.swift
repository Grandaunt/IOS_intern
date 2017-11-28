//
//  ZJMyCircleController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MJRefresh

class ZJMyCircleController: SecondViewController
{

    fileprivate var noDataView = ZJNoDataView.noDataView(img: UIImage(named:"noLog")!, title: "暂无任何圈子", info: "快去发布你的圈子吧")
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
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
    
    fileprivate lazy var tableViewProtocol:ZJMyCircleProtocol = {[weak self] in
        let tableViewProtocol = ZJMyCircleProtocol()
        tableViewProtocol.controller = self
        //删除操作
        weak var weakProtocol = tableViewProtocol
        tableViewProtocol.delCircleAction = {[weak self] (circleId,indexPath) in
            
            let action = UIAlertAction(title: "删除", style: .destructive) { (action) in
                self?.viewModel.delCircle(circleId: circleId, finish: {
                    weakProtocol?.dataArray.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                })
            }
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            let alertController = UIAlertController(title: "是否确认删除", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(action)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
        }
        return tableViewProtocol
    }()
    
    
    fileprivate var currentPage = 1
    fileprivate var viewModel = ZJMyCircleViewModel()
    
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

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
