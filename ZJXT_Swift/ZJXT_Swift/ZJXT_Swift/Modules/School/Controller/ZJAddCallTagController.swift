//
//  ZJAddCallTagController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/9.
//  Copyright © 2017年 runer. All rights reserved.
//
//  约吧标签添加

import UIKit
import MBProgressHUD

class ZJAddCallTagController: SecondViewController
{
    var selectTagAction:((ZJSchoolTagModel)->Void)?
    
    fileprivate var selectIndex:Int?

    fileprivate var containView = UIView()  //为了scrollview的自动布局
    
    fileprivate var dataArray = [ZJSchoolTagModel]()
    
    fileprivate var colorArray = [UIColor.color(hex: "#f98f75"),
                                  UIColor.color(hex: "#757ae9"),
                                  UIColor.color(hex: "#ae8af5"),
                                  UIColor.color(hex: "#96dc5a"),
                                  UIColor.color(hex: "#69d4a4"),
                                  UIColor.color(hex: "#87b7ff"),
                                  UIColor.color(hex: "#f98f75")]
    
    fileprivate lazy var tagsView:HXTagsView = {[weak self] in
        let tagsView = HXTagsView(frame: CGRect(x: 5, y: 100, width: kScreenViewWidth - 10, height: 50))
        tagsView.layout.scrollDirection = UICollectionViewScrollDirection.vertical
        tagsView.isMultiSelect = false
        tagsView.tagAttribute.normalBackgroundColor = UIColor.white
        tagsView.tagAttribute.tagSpace = kHomeEdgeSpace
        tagsView.tagAttribute.borderWidth = 0.0
        tagsView.completion = {(array,index) in
            self?.selectIndex = index
        }
        
        return tagsView
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.requestData()
    }
        
    fileprivate func requestData()
    {
        BaseViewModel().post(url: kAllTagListURL, param: nil, MBProgressHUD: true, success: { (resp) in
            
            let dict = resp?["list"].arrayObject
            self.dataArray = ZJSchoolTagModel.mj_objectArray(withKeyValuesArray: dict) as! [ZJSchoolTagModel]
            
            //设置标题和标题颜色
            var titles = [String]()
            var colors = [UIColor]()
            for model in self.dataArray
            {
                titles.append(model.tagName!)
                colors.append(self.colorArray[Int(arc4random_uniform(UInt32(self.colorArray.count)))])
            }
            self.tagsView.tags = titles
            self.tagsView.tagAttribute.textColors = colors;
            
            self.initView()

            
        }, noData: nil, failure: nil)
    }
    
    fileprivate func initNav()
    {
        let rightItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(selectFinish))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func selectFinish()
    {
        if self.selectTagAction != nil
        {
            if self.selectIndex == nil
            {
                MBProgressHUD.show(error: "请选择标签")
                return
            }
            
            let model = self.dataArray[self.selectIndex!]
            self.selectTagAction!(model)
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    fileprivate func initView()
    {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        scrollView.addSubview(self.containView)
        self.containView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()  //纵向滑动就width等于UIScrollView，横向就height
        }
        
        let label1 = UILabel()
        label1.font = UIFont.systemFont(ofSize: 35)
        label1.text = "添加标签"
        self.containView.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(25)
        }
        
        let label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 16)
        label2.text = "添加一个适合的约吧标签。"
        label2.textColor = UIColor.color(hex: "#666666")
        self.containView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(label1.snp.bottom).offset(25)
        }
        
        self.containView.layoutIfNeeded()
        
        let height = HXTagsView.getHeightWithTags(self.tagsView.tags, layout: self.tagsView.layout, tagAttribute: self.tagsView.tagAttribute, width: self.tagsView.frame.size.width)
        self.tagsView.frame.origin.y = label2.frame.maxY + 35
        self.tagsView.frame.size.height = height
        
        self.containView.addSubview(self.tagsView)
        
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle(" 自定义标签", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setImage(IconFontUtils.imageSquare(code: "\u{e6da}", size: 15, color: UIColor.black), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(addTag), for: .touchUpInside)
        self.containView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(self.tagsView.snp.bottom).offset(kHomeEdgeSpace)
            make.height.equalTo(34)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-kHomeEdgeSpace*2)
        }
    }
    
    @objc fileprivate func addTag()
    {
        let toVC = ZJAddCallTagAddController()
        toVC.navTitle = "自定义标签"
        toVC.addAction = {[weak self] title in
        
            let model = ZJSchoolTagModel()
            model.tagName = title
            self?.dataArray.append(model)

            //设置标题和标题颜色
            var titles = [String]()
            var colors = [UIColor]()
            for model in (self?.dataArray)!
            {
                titles.append(model.tagName!)
                let idx = Int(arc4random_uniform(UInt32((self?.colorArray.count)!)))
                colors.append((self?.colorArray[idx])!)
            }

            self?.tagsView.tags = titles
            self?.tagsView.tagAttribute.textColors = colors;

            let height = HXTagsView.getHeightWithTags(self?.tagsView.tags, layout: self?.tagsView.layout, tagAttribute: self?.tagsView.tagAttribute, width: (self?.tagsView.frame.size.width)!)
            self?.tagsView.frame.size.height = height

            self?.tagsView.reloadData()
        }
        self.navigationController?.pushViewController(toVC, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
