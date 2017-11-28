//
//  ZJLearnHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/6.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MJRefresh

class SearchButton:UIButton
{
    override var intrinsicContentSize: CGSize{
        get{
            return CGSize(width: kScreenViewWidth - 30, height: 30)
        }
    }
}

class ZJLearnHomeController: BaseViewController
{
    fileprivate var hotArray = [ZJLearnHomeCourseModel]()   //热门

    fileprivate var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    fileprivate lazy var collection:UICollectionView = {[weak self] in
        let collection = UICollectionView(frame: kTableViewFrame, collectionViewLayout: (self?.layout)!)
        collection.backgroundColor = UIColor.white
        collection.delegate = self?.collectionViewProtocol
        collection.dataSource = self?.collectionViewProtocol

        collection.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self?.requestData()
            
        })
        
        collection.register(UINib(nibName: "ZJLearnHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "ZJLearnHomeClassCell")
        collection.register(UINib(nibName: "ZJLearnHomeVideoCell", bundle: nil), forCellWithReuseIdentifier: "ZJLearnHomeVideoCell")

        
        collection.register(UINib(nibName: "ZJLearnHomeHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ZJLearnHomeHeaderView")
        collection.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        return collection
    }()
    
    fileprivate lazy var collectionViewProtocol:ZJLearnHomeProtocol = {[weak self] in
        let cProtocol = ZJLearnHomeProtocol()
        cProtocol.controller = self
        return cProtocol
    }()
    
    fileprivate var viewModel = ZJLearnHomeViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        
        self.view.addSubview(self.collection)
        self.collection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.requestData()
    }
    
    fileprivate func requestData()
    {
        self.requestCategory()
        self.requestHot()
        self.requestRecommend()
        
        self.collection.mj_header.endRefreshing()
    }
        
    fileprivate func requestCategory()
    {
        self.viewModel.requestCategoryList {[weak self] (dataArray) in
            self?.collectionViewProtocol.categoryDataArray = dataArray
            self?.collection.reloadSections(NSIndexSet(indexesIn: NSRange(location: 0, length: 1)) as IndexSet)
        }
    }
    
    fileprivate func requestHot()
    {
        self.viewModel.requestHotList {[weak self] (array) in
            self?.hotArray = array
            self?.collectionViewProtocol.hotArray = array
            self?.collection.reloadSections(NSIndexSet(indexesIn: NSRange(location: 1, length: 1)) as IndexSet)
        }
    }
    
    fileprivate func requestRecommend()
    {
        self.viewModel.requestRecommendList {[weak self] (array) in
            self?.collectionViewProtocol.recommendArray = array
            self?.collection.reloadSections(NSIndexSet(indexesIn: NSRange(location: 2, length: 1)) as IndexSet)
        }

    }
    
    fileprivate func initNav()
    {
        self.transitioningDelegate = self

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
        label.text = "调酒师(热门职位搜索)"
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
        toVC.hotArray = self.hotArray
        let nav = ZJNavigationController(rootViewController: toVC)
        nav.transitioningDelegate = self
        
        self.present(nav, animated: true, completion: nil)
    }

}

extension ZJLearnHomeController:UIViewControllerTransitioningDelegate
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
