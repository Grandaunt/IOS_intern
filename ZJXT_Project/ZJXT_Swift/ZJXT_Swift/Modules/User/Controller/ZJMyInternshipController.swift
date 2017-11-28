//
//  ZJMyInternshipController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/10.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的实习

import UIKit

class ZJMyInternshipController: SecondViewController
{
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "ZJUserHomeOtherCell", bundle: nil), forCellReuseIdentifier: "ZJUserHomeOtherCell")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJMyInternshipProtocol = {[weak self] in
        let tableViewProtocol = ZJMyInternshipProtocol()
        tableViewProtocol.dataArray = self?.dataArray
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()

    
    fileprivate lazy var dataArray:[[String:String]] = {
        let dictArray = [["icon":"Internship_0","title":"我的日志"],
                         ["icon":"Internship_1","title":"我的周报"],
                         ["icon":"Internship_2","title":"我的问答"],
                         ["icon":"Internship_3","title":"我的出差"],
                         ["icon":"Internship_4","title":"我的请假"]]
        return dictArray
        
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
