//
//  ZJLearnSearchController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

private let kSearchHistory = "com.runer.zjxt_search_history"

class ZJLearnSearchController: BaseViewController
{
    var hotArray:[ZJLearnHomeCourseModel]?
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
    
    fileprivate lazy var tableViewProtocol:ZJLearnSearchProtocol = {[weak self] in
        let tableViewProtocol = ZJLearnSearchProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.historyArray = [String]()
        tableViewProtocol.hotArray = [String]()
        tableViewProtocol.clearSearchHistoryAction = {
            self?.clearSearchHistory()
        }
        return tableViewProtocol
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //获取热门搜索
        var titleArray = [String]()
        for model in self.hotArray!
        {
            titleArray.append(model.courseName!)
        }
        self.tableViewProtocol.hotArray = titleArray
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //获取历史搜索
        let userDefaults = UserDefaults.standard
        let histArray = userDefaults.array(forKey: kSearchHistory)
        
        if histArray != nil
        {
            self.tableViewProtocol.historyArray = histArray as! [String]            
        }
        self.tableView.reloadData()
    }
    
    fileprivate func initNav()
    {
        let textField = LoginInputTextField(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth - 50, height: 30))
        textField.placeholder = "调酒师(热门专业搜索)"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.returnKeyType = .search
//        textField.borderStyle = .none
        textField.backgroundColor = kBackgroundColor
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e633}", size: 17, color: kGrayTextColor))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.delegate = self
//        self.textField = textField
        self.navigationItem.titleView = textField
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        backBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        backBtn.setTitle("取消", for: .normal)
        backBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backBtn)
        
        self.navigationItem.rightBarButtonItem = backItem
        
    }
    
    @objc fileprivate func clearSearchHistory()
    {
        let cancelAlertActin = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let sureAlertAction = UIAlertAction(title: "确定", style: .default) { (action) in
            let userDefaults = UserDefaults.standard
            
            if userDefaults.array(forKey: kSearchHistory) != nil
            {
                self.tableViewProtocol.historyArray.removeAll()
                userDefaults.removeObject(forKey: kSearchHistory)
                self.tableView.reloadData()
            }
        }
        
        let alertController = UIAlertController(title: "清空记录", message: "确定清空搜索记录？", preferredStyle: .alert)
        alertController.addAction(cancelAlertActin)
        alertController.addAction(sureAlertAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }

    
    @objc fileprivate func backBtnClicked()
    {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ZJLearnSearchController:UITextFieldDelegate
{
    // MARK: - UITextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // 搜索 click 时
        let searchBarText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchBarText?.count == 0
        {
            textField.text = nil
            return true
        }
        
        textField.resignFirstResponder()
        let userDefaults = UserDefaults.standard
        var historyArray = [String]()
        
        if userDefaults.array(forKey: kSearchHistory) != nil
        {
            historyArray = userDefaults.array(forKey: kSearchHistory) as! [String]
            
        }
        
        if historyArray.contains(searchBarText!) == false
        {
            //每次把最新数据放在前面
            historyArray.insert(searchBarText!, at: 0)
            //添加完以后如果超过20个，自动去除最后面的数据
            if historyArray.count > 20
            {
                historyArray.removeLast()
            }
        }
        userDefaults.setValue(historyArray, forKey: kSearchHistory)
        userDefaults.synchronize()
        
        let toVC = ZJLearnSearchResultController()
        toVC.navTitle = ""
        toVC.searchStr = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.navigationController?.pushViewController(toVC, animated: true)
        
        return true
    }
}
