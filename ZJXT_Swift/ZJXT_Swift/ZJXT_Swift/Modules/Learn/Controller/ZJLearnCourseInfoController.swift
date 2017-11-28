//
//  ZJLearnCourseInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//
//  主页点进去的内容详情

import UIKit

class ZJLearnCourseInfoController: SecondViewController
{
    var model:ZJLearnHomeCourseModel?
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .plain)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "ZJLearnSearchResultCell", bundle: nil), forCellReuseIdentifier: "ZJLearnSearchResultCell")
        
        tableView.register(UINib(nibName: "ZJLearnCourseInfoCell", bundle: nil), forCellReuseIdentifier: "ZJLearnCourseInfoCell")
        
        return tableView
        }()
    
    fileprivate lazy var tableViewProtocol:ZJLearnCourseInfoProtocol = {[weak self] in
        let tableViewProtocol = ZJLearnCourseInfoProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.leftBtn = self?.leftBtn
        tableViewProtocol.rightBtn = self?.rightBtn
        return tableViewProtocol
    }()
    
    fileprivate lazy var leftBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle("课程学习", for: .normal)
        btn.setTitleColor(kTabbarBlueColor, for: .selected)
        btn.setTitleColor(UIColor.color(hex: "#333333"), for: .normal)
        btn.addTarget(self, action: #selector(classBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var rightBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle("课程详情", for: .normal)
        btn.setTitleColor(kTabbarBlueColor, for: .selected)
        btn.setTitleColor(UIColor.color(hex: "#333333"), for: .normal)
        btn.addTarget(self, action: #selector(classBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate var viewModel = ZJLearnCourseInfoViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)

        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.requestData()
        
        self.classBtnClicked(btn: self.leftBtn)
        
    }
    
    fileprivate func requestData()
    {
        self.viewModel.requestInfo(carouseId: (self.model?.courseId)!) {[weak self] (model) in
            self?.tableViewProtocol.model = model
            self?.tableView.reloadData()
            
            let url = URL(string: (model.course?.topBackgroundImageUrl)!)
            
            let img = UIImage(data: try! Data(contentsOf: url!))
            
            let header = ZJLearnCourseInfoHeader(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: kScreenViewWidth/16*9), img: img!, title: (model.course?.courseName)!, subTitle: (model.course?.description1)!)
            header.applyTestAction = {[weak self] in
                let toVC = ZJLearnApplyTestController()
                toVC.navTitle = "申请考试"
                toVC.urlStr = model.course?.testTip
                self?.navigationController?.pushViewController(toVC, animated: true)
            }
            self?.tableView.tableHeaderView = header
        }
    }
    
    @objc fileprivate func classBtnClicked(btn:UIButton)
    {
        btn.isSelected = true
        if btn == self.leftBtn
        {
            self.rightBtn.isSelected = false
        }
        else
        {
            self.leftBtn.isSelected = false
        }
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
