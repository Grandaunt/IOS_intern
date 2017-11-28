//
//  ZJNewRecruitHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/26.
//  Copyright © 2017年 runer. All rights reserved.
//
//  安卓的界面

import UIKit
import MBProgressHUD
import MJRefresh

class ZJNewRecruitHomeController: SecondViewController {

    fileprivate var currentPage = 1
    
    //筛选的参数
    fileprivate var searchStr:String?
    fileprivate var postMoney:String?
    fileprivate var workId:String?
    fileprivate var capitalId:String?
    fileprivate var indstryId:String?
    fileprivate var educationId:String?
    fileprivate var cityCode:String?
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.currentPage = 1
            self?.requestFilter()
        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestFilter()
        })

        tableView.register(UINib(nibName: "ZJHomeInternshipJobCell", bundle: nil), forCellReuseIdentifier: "ZJHomeInternshipJobCell")
        
        return tableView
    }()
    
    fileprivate lazy var menu:YZPullDownMenu = {[weak self] in
        let menu = YZPullDownMenu()
        menu.dataSource = self?.tableViewProtocol
        return menu
    }()
    
    fileprivate lazy var searchField:LoginInputTextField = {
        let textField = LoginInputTextField()
        textField.leftViewMode = .always
        textField.placeholder = "请输入职位"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.returnKeyType = .done
        textField.backgroundColor = kBackgroundColor
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e633}", size: 17, color: kGrayTextColor))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 17.5
        textField.delegate = self
        return textField
    }()
    
    fileprivate lazy var searchBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("搜索", for: .normal)
        btn.setTitleColor(kTabbarBlueColor, for: .normal)
        btn.addTarget(self, action: #selector(searchBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var tableViewProtocol:ZJNewRecruitHomeProtocol = {[weak self] in
        let pro = ZJNewRecruitHomeProtocol()
        pro.controller = self
        return pro
    }()
    
    fileprivate lazy var viewModel = ZJNewRecruitHomeViewModel()
    
    fileprivate var noDataView = ZJNoDataView.noDataView(img: UIImage(named:"noCollect")!, title: "暂无任何职位", info: "")


    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initView()
        self.initLocation()
        self.requestFilter()
    }
        
    fileprivate func initLocation()
    {
        LocationManager.startLocation(finish: { (cor) in
            
        }) { (placeMarks) in
            let mark = placeMarks.first
            
            
            var province = mark?.administrativeArea
            if province == nil
            {
                province = mark?.locality
            }
            
            let cityController = self.childViewControllers.first as! ZJRecruitCityFilterController
            cityController.provinceName = province
        }
    }
    
    fileprivate func initView()
    {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(45)
        }
        topView.addSubview(self.searchBtn)
        self.searchBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(40)
        }
        topView.addSubview(self.searchField)
        self.searchField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.right.equalTo(self.searchBtn.snp.left).offset(-10)
        }
        self.view.addSubview(self.menu)
        self.menu.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
            make.top.equalTo(self.searchBtn.snp.bottom).offset(5)
        }
        self.setupAllChildViewController()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.menu.snp.bottom)
        }
        self.view.addSubview(self.noDataView)
        self.view.bringSubview(toFront: self.noDataView)
        self.noDataView.isHidden = true
        self.noDataView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.tableView)
        }

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
    
    fileprivate func setupAllChildViewController()
    {
        let controller1 = ZJRecruitCityFilterController()
        //选择完城市的时候
        controller1.selectCityAction = {[weak self] model in
            self?.cityCode = model.CODE
            self?.currentPage = 1
            self?.requestFilter()
        }
        
        let controller2 = ZJRecruitJobFilterController()
        //职位筛选确定的时候
        controller2.sureFilterAction = {[weak self] (postMoney,workId,eduId) in
            self?.postMoney = postMoney
            self?.workId = workId
            self?.educationId = eduId
            self?.currentPage = 1
            self?.requestFilter()
        }
        
        let controller3 = ZJRecruitCompanyFilterController()
        //公司筛选确定以后
        controller3.sureFilterAction = {[weak self] (capId,insId) in
            self?.capitalId = capId
            self?.indstryId = insId
            self?.currentPage = 1
            self?.requestFilter()
        }
        
        self.addChildViewController(controller1)
        self.addChildViewController(controller2)
        self.addChildViewController(controller3)
        
    }
    
    @objc fileprivate func searchBtnClicked()
    {
        self.searchField.resignFirstResponder()
        if self.searchField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请输入搜索职位")
            return
        }
        self.searchStr = self.searchField.text
        self.currentPage = 1
        self.requestFilter()
    }
    
    fileprivate func requestFilter()
    {
        let para = (page:self.currentPage,
                    search:self.searchStr,
                    postMoney:self.postMoney,
                    workId:self.workId,
                    capitalId:self.capitalId,
                    indstryId:self.indstryId,
                    educationId:self.educationId,
                    cityCode:self.cityCode)
        
        self.viewModel.requestFilterList(para: para) {[weak self] (dataArray, isNoData) in
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
            
            if dataArray.count == 0
            {
                self?.noDataView.isHidden = false
                self?.tableView.isHidden = true
            }
            else
            {
                self?.noDataView.isHidden = true
                self?.tableView.isHidden = false
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJNewRecruitHomeController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
