//
//  ZJISAlreadyHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//
//  已经实习的主页

import UIKit

class ZJISAlreadyHomeController: SecondViewController
{

    var model:ZJUserHasPracticeModel?
    fileprivate lazy var dataArray:[[[String:Any]]] = {
        let dictArray = [[["name":"test"]
            ],
                         [
                            ["icon":"internship_0","title":"签到"],
                            ["icon":"internship_1","title":"日志"],
                            ["icon":"internship_2","title":"周报"]
            ],
                         [
                            ["icon":"internship_3","title":"请假"],
                            ["icon":"internship_4","title":"出差"],
                            ["icon":"internship_5","title":"问答"]
            ],
                         [
                            ["icon":"internship_6","title":"申请离职"]
            ]
        ]
        
        return dictArray
    }()
    
    fileprivate lazy var tableViewProtocol:ZJISAlreadyHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJISAlreadyHomeProtocol()
        tableViewProtocol.dataArray = self?.dataArray
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
        
        tableView.register(UINib(nibName: "ZJISAlreadyHomeCompanyCell", bundle: nil), forCellReuseIdentifier: "ZJISAlreadyHomeCompanyCell")
        tableView.register(UINib(nibName: "ZJUserHomeOtherCell", bundle: nil), forCellReuseIdentifier: "ZJUserHomeOtherCell")
        
        return tableView
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
