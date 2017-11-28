//
//  ZJCommentListController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MJRefresh

class ZJCommentListController: SecondViewController
{
    var model:ZJCircleCommentModel?
    
    fileprivate var currentPage = 1
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
//            self?.currentPage = 1
//            self?.requestData()
//        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            self?.currentPage = (self?.currentPage)! + 1
            self?.requestData()
        })
        
        tableView.register(UINib(nibName: "ZJCommentListCell", bundle: nil), forCellReuseIdentifier: "ZJCommentListCell")
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJCommentListProtocol = {[weak self] in
        let tableViewProtocol = ZJCommentListProtocol()
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate lazy var replyBtn:UIButton = {
        let btn = UIButton(type:.custom)
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.color(hex: "#666666")
        label.text = "评论些什么..."
        btn.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        })
        btn.backgroundColor = UIColor.white
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(commentClicked), for: .touchUpInside)
        return btn
    }()
    
    fileprivate var viewModel = ZJCommentListViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        self.view.addSubview(self.replyBtn)
        self.replyBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(30)
        }
        
        self.requestData()
    }
    
    func requestData()
    {
        self.viewModel.requestList(commentId:(self.model?.circleCommentId)!, page: self.currentPage) {[weak self] (model, isNoData) in
            self?.tableViewProtocol.model = model
            self?.tableView.reloadData()
            
//            self?.tableView.mj_header.endRefreshing()
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
    
    //对主评论进行评论
    @objc fileprivate func commentClicked()
    {
        let inputView = ZJInputPanelView.inputPanelView()
        inputView.show()
        inputView.inputDoneAction = { text in
            var param = [String:Any]()
            param["circleId"] = self.model?.circleId
            param["userId"] = UserInfo.shard.userId
            param["comment"] = text
            param["commentId"] = self.model?.circleCommentId
            param["toUserId"] = self.model?.userId
            BaseViewModel().post(url: kAddCircelCommentSubURL, param: param, MBProgressHUD: true, success: { (resp) in
                self.requestData()
            }, noData: nil, failure: nil)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
