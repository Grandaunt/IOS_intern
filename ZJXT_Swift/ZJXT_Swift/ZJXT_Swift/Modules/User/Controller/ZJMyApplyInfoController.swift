//
//  ZJMyApplyInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyInfoController: SecondViewController {

    var model:ZJMyApplyHomeModel?
    fileprivate lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kBackgroundColor
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(UINib(nibName: "ZJMyApplyInfoCell1", bundle: nil), forCellReuseIdentifier: "ZJMyApplyInfoCell1")
        tableView.register(UINib(nibName: "ZJMyApplyInfoCell2", bundle: nil), forCellReuseIdentifier: "ZJMyApplyInfoCell2")
        tableView.register(UINib(nibName: "ZJMyApplyInfoCell3", bundle: nil), forCellReuseIdentifier: "ZJMyApplyInfoCell3")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJMyApplyInfoProtocol = {[weak self] in
        let tableViewProtocol = ZJMyApplyInfoProtocol()
        tableViewProtocol.model = self?.model
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
