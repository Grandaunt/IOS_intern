//
//  ZJLearnClassifyInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//
//  点击分类进入的界面

import UIKit
import MJRefresh

class ZJLearnClassifyInfoController: SecondViewController
{
    var model:ZJLearnHomeClassModel?
    
    fileprivate var currentPage = 1
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .plain)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })

        
        tableView.register(UINib(nibName: "ZJLearnClassifyInfoCell", bundle: nil), forCellReuseIdentifier: "ZJLearnClassifyInfoCell")
        
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJLearnClassifyInfoProtocol = {[weak self] in
        let tableViewProtocol = ZJLearnClassifyInfoProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.model = self?.model
        return tableViewProtocol
    }()
    
    fileprivate var viewModel = ZJLearnClassifyInfoViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestData()
    }
    
    fileprivate func requestData()
    {
        self.viewModel.requestList(categoryId:(self.model?.courseCategoryId)!,page: self.currentPage) {[weak self] (dataArray, isNoData) in
            self?.tableViewProtocol.dataArray = dataArray
            self?.tableView.reloadData()
            
            self?.tableView.mj_header.endRefreshing()
            if isNoData
            {
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            else
            {
                self?.tableView.mj_footer.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func initNav()
    {
        self.transitioningDelegate = self
        
        let searchBtn = SearchButton(type: .custom)
        searchBtn.frame = CGRect(x: 40, y: 7, width: kScreenViewWidth - 50, height: 30)
        searchBtn.layer.masksToBounds = true
        searchBtn.layer.cornerRadius = 17
        searchBtn.backgroundColor = kBackgroundColor
        searchBtn.addTarget(self, action: #selector(searchBtnClicked), for: .touchUpInside)
        
        let imgView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e7e0}", size: 18, color: UIColor.color(hex: "#CACACA")))
        searchBtn.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview()
        }
        
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#CACACA")
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "请输入课程关键字"
        searchBtn.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kHomeEdgeSpace)
            make.centerY.equalToSuperview()
        }
        
        self.navigationItem.titleView = searchBtn
    }
    
    @objc fileprivate func searchBtnClicked()
    {
        let toVC = ZJLearnSearchController()
        let nav = ZJNavigationController(rootViewController: toVC)
        nav.transitioningDelegate = self
        
        self.present(nav, animated: true, completion: nil)
    }
}

extension ZJLearnClassifyInfoController:UIViewControllerTransitioningDelegate
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

