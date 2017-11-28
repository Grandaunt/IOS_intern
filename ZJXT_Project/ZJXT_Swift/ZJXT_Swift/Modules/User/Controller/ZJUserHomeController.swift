//
//  ZJUserHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/6.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJUserHomeController: BaseViewController
{
    fileprivate lazy var dataArray:[[[String:Any]]] = {
        let dictArray = [[["name":"test"]
                         ],
                         [
                            ["icon":"IndividualHome_0","title":"我的简历"],
                            ["icon":"IndividualHome_1","title":"我的申请"],
                            ["icon":"IndividualHome_2","title":"我的收藏"]
                         ],
                         [
                            ["icon":"IndividualHome_3","title":"我的实习"],
                            ["icon":"IndividualHome_4","title":"我的圈子"]
                         ],
                         [
                            ["icon":"IndividualHome_5","title":"我的设置"]
                         ]
                        ]
        
        return dictArray
    }()
    
    fileprivate lazy var tableViewProtocol:ZJUserHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJUserHomeProtocol()
        tableViewProtocol.dataArray = self?.dataArray
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
        
        tableView.register(UINib(nibName: "ZJUserHomeUserNotLoginCell", bundle: nil), forCellReuseIdentifier: "ZJUserHomeUserNotLoginCell")
        tableView.register(UINib(nibName: "ZJUserHomeUserLoginCell", bundle: nil), forCellReuseIdentifier: "ZJUserHomeUserLoginCell")
        tableView.register(UINib(nibName: "ZJUserHomeOtherCell", bundle: nil), forCellReuseIdentifier: "ZJUserHomeOtherCell")
        
        return tableView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "我的"
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

}
