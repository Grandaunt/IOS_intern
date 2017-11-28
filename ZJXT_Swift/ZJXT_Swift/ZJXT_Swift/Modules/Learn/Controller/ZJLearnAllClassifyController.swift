//
//  ZJLearnAllClassifyController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//
//  在线学习  全部分类

import UIKit

class ZJLearnAllClassifyController: SecondViewController {

    fileprivate var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    fileprivate lazy var collection:UICollectionView = {[weak self] in
        let collection = UICollectionView(frame: kTableViewFrame, collectionViewLayout: (self?.layout)!)
        collection.backgroundColor = UIColor.white
        collection.delegate = self?.collectionViewProtocol
        collection.dataSource = self?.collectionViewProtocol
        
        collection.register(UINib(nibName: "ZJLearnAllClassifyCell", bundle: nil), forCellWithReuseIdentifier: "ZJLearnAllClassifyCell")        
        
        collection.register(UINib(nibName: "ZJLearnAllClassifyHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ZJLearnAllClassifyHeaderView")
        collection.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        return collection
        }()
    
    fileprivate lazy var collectionViewProtocol:ZJLearnAllClassifyProtocol = {[weak self] in
        let cProtocol = ZJLearnAllClassifyProtocol()
        cProtocol.controller = self
        return cProtocol
    }()
    
    fileprivate var viewModel = ZJLearnAllClassifyViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.collection)
        self.collection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestData()
    }
    
    fileprivate func requestData()
    {
        self.viewModel.getAllCourse {[weak self] (dataArray) in
            self?.collectionViewProtocol.dataArray = dataArray
            self?.collection.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
