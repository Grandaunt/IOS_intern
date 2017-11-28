//
//  ZJMyCollectController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/10.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的收藏

import UIKit

class ZJMyCollectController: SecondViewController
{
    fileprivate lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kBackgroundColor
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        
        tableView.register(UINib(nibName: "ZJMyCollectCell", bundle: nil), forCellReuseIdentifier: "ZJMyCollectCell")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJMyCollectProtocol = {[weak self] in
        let tableViewProtocol = ZJMyCollectProtocol()
        return tableViewProtocol
    }()
    
    fileprivate var noDataView = ZJNoDataView.noDataView(img: UIImage(named:"noCollect")!, title: "暂无收藏任何职位", info: "快去收藏你喜欢的内容吧")
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(self.noDataView)
        self.view.bringSubview(toFront: self.noDataView)
        self.noDataView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    fileprivate func initNav()
    {
        //调整位置，以防往右偏移
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("清空", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
