//
//  ZJRecruitSearchController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJRecruitSearchController: BaseViewController
{
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJRecruitSearchProtocol = {[weak self] in
        let tableViewProtocol = ZJRecruitSearchProtocol()
        tableViewProtocol.searchStr = self?.searchStr
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate var searchStr = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func initNav()
    {
        let textField = LoginInputTextField(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth - 50, height: 30))
        textField.placeholder = "搜索职位/公司"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.returnKeyType = .search
        //        textField.borderStyle = .none
        textField.backgroundColor = kBackgroundColor
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e633}", size: 17, color: kGrayTextColor))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.addTarget(self, action: #selector(textChanged(textField:)), for: .editingChanged)
        textField.delegate = self.tableViewProtocol
        textField.becomeFirstResponder()
        //        self.textField = textField
        self.navigationItem.titleView = textField
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        backBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        backBtn.setTitle("取消", for: .normal)
        backBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backBtn)
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -10
        
        self.navigationItem.rightBarButtonItem = backItem
    }
    
    @objc fileprivate func textChanged(textField:UITextField)
    {
        let text = textField.text
        self.searchStr = text!
        self.tableViewProtocol.searchStr = self.searchStr

        if text?.trimAfterCount() == 0
        {
            self.tableView.isHidden = true
        }
        else
        {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    @objc fileprivate func backBtnClicked()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
