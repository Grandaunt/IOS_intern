//
//  ZJRecruitSearchResultController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJRecruitSearchResultController: SecondViewController {

    var searchStr:String?
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.viewProtocol
        tableView.dataSource = self?.viewProtocol
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "ZJHomeInternshipJobCell", bundle: nil), forCellReuseIdentifier: "ZJHomeInternshipJobCell")
        
        return tableView
    }()
    
    fileprivate lazy var viewProtocol:ZJRecruitSearchResultProtocol = {[weak self] in
        let pro = ZJRecruitSearchResultProtocol()
        pro.controller = self
        return pro
    }()
    
    fileprivate lazy var menu:YZPullDownMenu = {[weak self] in
        let menu = YZPullDownMenu()
        menu.dataSource = self?.viewProtocol
        return menu
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
    }
    
    fileprivate func initNav()
    {
        let textField = LoginInputTextField(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth - 50, height: 30))
        textField.placeholder = "搜索职位/公司"
        textField.text = self.searchStr
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.returnKeyType = .search
        //        textField.borderStyle = .none
        textField.backgroundColor = kBackgroundColor
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e633}", size: 17, color: kGrayTextColor))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
//        textField.addTarget(self, action: #selector(textChanged(textField:)), for: .editingChanged)
//        textField.delegate = self
        //        self.textField = textField
        self.navigationItem.titleView = textField
    }
    
    fileprivate func initView()
    {
        self.view.addSubview(self.menu)
        self.menu.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(45)
        }
        self.setupAllChildViewController()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.menu.snp.bottom)
        }
    }
    
    fileprivate func setupAllChildViewController()
    {
        let controller1 = ZJRecruitCityFilterController()
        
        let controller2 = ZJRecruitJobFilterController()
        
        let controller3 = ZJRecruitCompanyFilterController()
        
        self.addChildViewController(controller1)
        self.addChildViewController(controller2)
        self.addChildViewController(controller3)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
