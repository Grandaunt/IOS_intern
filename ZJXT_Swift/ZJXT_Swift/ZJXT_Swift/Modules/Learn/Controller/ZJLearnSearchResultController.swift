//
//  ZJLearnSearchResultController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/21.
//  Copyright © 2017年 runer. All rights reserved.
//
//  在线学习搜索结果

import UIKit

class ZJLearnSearchResultController: SecondViewController {

    var searchStr:String?
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "ZJLearnClassifyInfoCell", bundle: nil), forCellReuseIdentifier: "ZJLearnClassifyInfoCell")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJLearnSearchResultProtocol = {[weak self] in
        let tableViewProtocol = ZJLearnSearchResultProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate var viewModel = ZJLearnSearchResultViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.search()
    }
    
    fileprivate func initNav()
    {
        let textField = LoginInputTextField(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth - 50, height: 30))
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.text = self.searchStr
        textField.returnKeyType = .search
        //        textField.borderStyle = .none
        textField.backgroundColor = kBackgroundColor
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e633}", size: 17, color: kGrayTextColor))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.delegate = self
        self.navigationItem.titleView = textField
    }
    
    fileprivate func search()
    {
        self.viewModel.getResult(searchStr: self.searchStr!) {[weak self] (array) in
            self?.tableViewProtocol.dataArray = array
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJLearnSearchResultController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.searchStr = textField.text
        self.search()
        return true
    }
}
