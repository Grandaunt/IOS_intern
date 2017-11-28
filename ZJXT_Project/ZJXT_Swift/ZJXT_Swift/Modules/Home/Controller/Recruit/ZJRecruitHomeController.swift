//
//  ZJRecruitHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//
//  原型图的界面

import UIKit

class ZJRecruitHomeController: SecondViewController
{

    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = self?.createHeaderView()
        
        tableView.register(UINib(nibName: "ZJHomeInternshipJobCell", bundle: nil), forCellReuseIdentifier: "ZJHomeInternshipJobCell")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJRecruitHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJRecruitHomeProtocol()
        tableViewProtocol.recommendArray = [String]()
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
        
        self.tableViewProtocol.recommendArray = ["推荐1","历史搜索2","推荐来了","推荐来了","推荐来了","推荐来了"]
        self.tableView.reloadData()
    }
    
    fileprivate func createHeaderView() -> UIView
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 45))
        headerView.backgroundColor = kBackgroundColor
        
        let searchBtn = UIButton(type:.custom)
        searchBtn.backgroundColor = UIColor.white
        searchBtn.layer.masksToBounds = true
        searchBtn.layer.cornerRadius = 15
        searchBtn.addTarget(self, action: #selector(searchBtnClicked), for: .touchUpInside)
        headerView.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
            make.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        
        let btn = UIButton()
        btn.isEnabled = false
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e633}", size: 15, color: UIColor.color(hex: "#929292")), for: .normal)
        btn.setTitle(" 搜索职位/公司", for: .normal)
        btn.setTitleColor(UIColor.color(hex: "#929292"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        searchBtn.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        return headerView
    }
    
    @objc fileprivate func searchBtnClicked()
    {
        let toVC = ZJRecruitSearchController()
        let nav = ZJNavigationController(rootViewController: toVC)
        nav.transitioningDelegate = self
        
        self.present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJRecruitHomeController:UIViewControllerTransitioningDelegate
{
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return FadeInTransition()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return FadeInTransition()
    }
}
