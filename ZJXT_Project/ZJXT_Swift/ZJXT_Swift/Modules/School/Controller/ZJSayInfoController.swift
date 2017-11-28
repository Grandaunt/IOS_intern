//
//  ZJSayInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/11.
//  Copyright © 2017年 runer. All rights reserved.
//
//  召集令和心情 公用一个控制器
import UIKit
import MJRefresh

class ZJSayInfoController: SecondViewController
{
    var model:ZJCircleModel?    //上个界面传过来的model
    
    fileprivate var scrollY:CGFloat?
    
    fileprivate var commentPage = 1
    fileprivate var thumPage = 1
    fileprivate var applyPage = 1

    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "ZJSayInfoFirstCell", bundle: nil), forCellReuseIdentifier: "ZJSayInfoFirstCell")
        tableView.register(UINib(nibName: "ZJCallInfoFirstCell", bundle: nil), forCellReuseIdentifier: "ZJCallInfoFirstCell")
        tableView.register(UINib(nibName: "ZJCallInfoOtherCell", bundle: nil), forCellReuseIdentifier: "ZJCallInfoOtherCell")
        tableView.register(UINib(nibName: "ZJCircleCommentCell", bundle: nil), forCellReuseIdentifier: "ZJCircleCommentCell")
        
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
//            self?.currentPage = 1
//            self?.requestData()
//        })
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: {
            
            if (self?.commentBtn.isSelected)!
            {
                self?.commentPage = (self?.commentPage)! + 1
                self?.requestCommentData()
            }
            else if (self?.thumbupBtn.isSelected)!
            {
                self?.thumPage = (self?.thumPage)! + 1
                self?.requestThumData()
            }
            else
            {
                self?.applyPage = (self?.applyPage)! + 1
                self?.requestApplyData()
            }
        })
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJSayInfoProtocol = {[weak self] in
        let tableViewProtocol = ZJSayInfoProtocol()
        tableViewProtocol.commentBtn = self?.commentBtn
        tableViewProtocol.thumupBtn = self?.thumbupBtn
        tableViewProtocol.joinBtn = self?.joinBtn
        tableViewProtocol.controller = self
        tableViewProtocol.infoModel = (self?.model)!  //先赋上个界面传过来的model，再去请求一次
        return tableViewProtocol
    }()
    
    fileprivate lazy var viewModel = ZJSayInfoViewModel()
    
    fileprivate lazy var commentBtn:UIButton = {
        let btn = self.createBtn()
        btn.setTitle("评论137", for: .normal)
        btn.addTarget(self, action: #selector(listBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    //赞的按钮
    fileprivate lazy var thumbupBtn:UIButton = {
        let btn = self.createBtn()
        btn.setTitle("赞44", for: .normal)
        btn.addTarget(self, action: #selector(listBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var joinBtn:UIButton = {
        let btn = self.createBtn()
        btn.setTitle("已参加15", for: .normal)
        btn.addTarget(self, action: #selector(listBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
        
    fileprivate lazy var homeShareBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.color(hex: "#66666"), for: .normal)
        btn.setTitle(" 分享", for: .normal)
        btn.setImage(UIImage(named:"school_call_info_share"), for: .normal)
        btn.addTarget(self, action: #selector(bottomBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var homeCommentBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.color(hex: "#66666"), for: .normal)
        btn.setTitle(" 评论", for: .normal)
        btn.setImage(UIImage(named:"school_call_info_comment"), for: .normal)
        btn.addTarget(self, action: #selector(bottomBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var homeThumBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.color(hex: "#66666"), for: .normal)
        btn.setTitle(" 点赞", for: .normal)
        btn.setImage(UIImage(named:"school_call_info_thum"), for: .normal)
        btn.setTitleColor(UIColor.color(hex: "#d13b09"), for: .selected)
        btn.setImage(UIImage(named:"school_call_info_thum1"), for: .selected)
        btn.addTarget(self, action: #selector(bottomBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initBottomView()
        self.initData()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
        }
        self.requestInfoData()
        self.requestCommentData()
        self.requestThumData()
        self.requestApplyData()
        
        self.listBtnClicked(btn: self.commentBtn)
        if self.scrollY != nil
        {
            self.tableView.contentOffset = CGPoint(x: 0, y: (self.scrollY)!)
        }

    }
    
    fileprivate func initData()
    {
        let commentNum = "评论 " + (model?.commentNumber ?? "0")
        let thumNum = "点赞 " + (model?.praiseNumber ?? "0")
        let applyNum = "已参加 " + (model?.applyNumber ?? "0")

        self.commentBtn.setTitle(commentNum, for: .normal)
        self.thumbupBtn.setTitle(thumNum, for: .normal)
        self.joinBtn.setTitle(applyNum, for: .normal)
        
//        if self.scrollY != nil
//        {
//            self.tableView.contentOffset = CGPoint(x: 0, y: (self.scrollY)!)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.scrollY = self.tableView.contentOffset.y
    }
    
    fileprivate func requestInfoData()
    {
        self.viewModel.requestData(circleId: (self.model?.circleId)!) {[weak self] (model) in
            
            let commentNum = "评论 " + (model.commentNumber ?? "0")
            let thumNum = "点赞 " + (model.praiseNumber ?? "0")
            let applyNum = "已参加 " + (model.applyNumber ?? "0")
            
            self?.commentBtn.setTitle(commentNum, for: .normal)
            self?.thumbupBtn.setTitle(thumNum, for: .normal)
            self?.joinBtn.setTitle(applyNum, for: .normal)
            
            if model.isPraise == "YES"
            {
                self?.homeThumBtn.isSelected = true
            }
            else
            {
                self?.homeThumBtn.isSelected = false
            }
            
            self?.tableViewProtocol.infoModel = model
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }

    }
    
    func requestCommentData()
    {
        self.viewModel.requestCommentList(circleId:(self.model?.circleId)!,page: self.commentPage) {[weak self] (dataArray, isNoData) in
            self?.tableViewProtocol.commentArray = dataArray
            self?.tableView.reloadData()
//            self?.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .automatic)

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
    
    fileprivate func requestThumData()
    {
        self.viewModel.requestThumList(circleId:(self.model?.circleId)!,page: self.commentPage) {[weak self] (dataArray, isNoData) in
            self?.tableViewProtocol.thumArray = dataArray
            self?.tableView.reloadData()
            
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

    fileprivate func requestApplyData()
    {
        self.viewModel.requestApplyList(circleId:(self.model?.circleId)!,page: self.commentPage) {[weak self] (dataArray, isNoData) in
            self?.tableViewProtocol.applyArray = dataArray
            self?.tableView.reloadData()
            
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

    
    fileprivate func initBottomView()
    {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.color(hex: "#f9f9f9")
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        bottomView.addSubview(self.homeShareBtn)
        self.homeShareBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(kScreenViewWidth/6)
        }
        
        bottomView.addSubview(self.homeCommentBtn)
        self.homeCommentBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        bottomView.addSubview(self.homeThumBtn)
        self.homeThumBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(kScreenViewWidth/6*5)
        }
    }
    
    //生成列表页的三个按钮
    fileprivate func createBtn() -> UIButton
    {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.color(hex: "#333333"), for: .selected)
        btn.setTitleColor(UIColor.color(hex: "#929292"), for: .normal)
        btn.backgroundColor = UIColor.white
        return btn
    }
    
    @objc fileprivate func listBtnClicked(btn:UIButton)
    {
        btn.isSelected = true
        if btn == self.commentBtn
        {
            self.thumbupBtn.isSelected = false
            self.joinBtn.isSelected = false
        }
        else if btn == self.thumbupBtn
        {
            self.commentBtn.isSelected = false
            self.joinBtn.isSelected = false
        }
        else
        {
            self.commentBtn.isSelected = false
            self.thumbupBtn.isSelected = false
        }
        self.tableView.reloadData()

    }
    
    @objc fileprivate func bottomBtnClicked(btn:UIButton)
    {
        if btn == self.homeCommentBtn
        {
            let toVC = ZJAddCommentController()
            toVC.navTitle = "评论"
            toVC.circleId = self.model?.circleId
            toVC.mainCommentSuccess = {
                //设置按钮
                let titleStr = self.commentBtn.title(for: .normal)
                let num = titleStr?.split(separator: " ").last
                let numTitle = Int(num ?? "0")! + 1
                let commentNum = "评论 \(numTitle)"
                self.commentBtn.setTitle(commentNum, for: .normal)
                
                self.commentPage = 1
                self.requestCommentData()
            }
            self.navigationController?.pushViewController(toVC, animated: true)
        }
        else if btn == self.homeThumBtn
        {
            //圈子点赞
            BaseViewModel().post(url: kCircleThumURL, param: ["circleId":self.model!.circleId!,"userId":UserInfo.shard.userId!], MBProgressHUD: false, success: { (resp) in
                self.homeThumBtn.isSelected = !self.homeThumBtn.isSelected
                
                let title = self.thumbupBtn.title(for: .normal)
                let titleArray = title?.components(separatedBy: " ")
                
                var num = Int(titleArray?.last ?? "0")!
                if self.homeThumBtn.isSelected
                {
                    num = num + 1
                }
                else
                {
                    num = num - 1
                }
                
                let thumNum = "点赞 \(num)"
                self.thumbupBtn.setTitle(thumNum, for: .normal)
                let model = ZJCirclePraiseModel()
                model.circleId = self.model?.circleId
                model.userId = UserInfo.shard.userId
                model.trueName = UserInfo.shard.trueName
                model.nickName = UserInfo.shard.nickName
                model.logo = UserInfo.shard.logo
                self.tableViewProtocol.thumArray.insert(model, at: 0)
                self.tableView.reloadData()

            }, noData: nil, failure: nil)
        }
    }
}
