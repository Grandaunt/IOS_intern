//
//  ZJHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/6.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MJRefresh

class ZJHomeController: BaseViewController
{
    fileprivate var currentPage = 1

    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })

        
        tableView.register(UINib(nibName: "ZJHomeClassCell", bundle: nil), forCellReuseIdentifier: "ZJHomeClassCell")
        tableView.register(UINib(nibName: "ZJHomeNoticeCell", bundle: nil), forCellReuseIdentifier: "ZJHomeNoticeCell")
        tableView.register(UINib(nibName: "ZJHomeRecruitCell", bundle: nil), forCellReuseIdentifier: "ZJHomeRecruitCell")
        tableView.register(UINib(nibName: "ZJHomeApplyCell", bundle: nil), forCellReuseIdentifier: "ZJHomeApplyCell")
        tableView.register(UINib(nibName: "ZJHomeCircleCell", bundle: nil), forCellReuseIdentifier: "ZJHomeCircleCell")

        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJHomeProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate lazy var viewModel = ZJHomeViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestData()
        self.requestTextData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if ZJCitysData.shard.citys == nil
        {
            self.requestCitysData()
        }
    }
    
    //请求城市列表
    fileprivate func requestCitysData()
    {
        //只在第一次加载app的时候把省市区保存到本地
        BaseViewModel().post(url: kGetAllCitysURL, param: nil, MBProgressHUD: false, success: { (resp) in
            let array = resp?["list"].arrayObject
            let dataArray = ZJCityModel.mj_objectArray(withKeyValuesArray: array) as! [ZJCityModel]
            ZJCitysData.save(citys: dataArray)
            
        }, noData: nil, failure: nil)
    }

    
    fileprivate func initNav()
    {
        let searchBtn = SearchButton(type: .custom)
        searchBtn.frame = CGRect(x: 15, y: 7, width: kScreenViewWidth - 30, height: 30)
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
        label.text = "JAVA高级工程师"
        searchBtn.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kHomeEdgeSpace)
            make.centerY.equalToSuperview()
        }
        
        self.navigationItem.titleView = searchBtn
    }
    
    fileprivate func requestData()
    {
        self.viewModel.requestList(page: self.currentPage) {[weak self] (dataArray, isNoData) in
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
    
    fileprivate func requestTextData()
    {
        self.viewModel.requestText { (dataArray) in
            var titleArray = [String]()
            for model in dataArray
            {
                titleArray.append(model.noticeContent!)
            }
            
            self.tableViewProtocol.textArray = titleArray
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        }
    }
    
    @objc fileprivate func searchBtnClicked()
    {
        let toVC = ZJNewRecruitHomeController()
        toVC.navTitle = "招聘"
        self.navigationController?.pushViewController(toVC, animated: true)
    }

}
