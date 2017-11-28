//
//  ZJLearnVideoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//
// 课程搜索时的点击进入

import UIKit

class ZJLearnVideoController: SecondViewController {

    fileprivate var containView = UIView()
    
    fileprivate var player = BMPlayer(customControlView: CusBMPlayerControlView())
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#333333")
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#929292")
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var infoLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#929292")
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
        
        self.containView.addSubview(self.player)
        self.player.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        make.height.equalTo(self.containView.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        
        BMPlayerConf.shouldAutoPlay = false
        
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let asset = BMPlayerResource(url: URL(string: "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4")!)
        
        self.player.setVideo(resource: asset)
        
        self.containView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.player.snp.bottom).offset(kHomeEdgeSpace*2)
            make.left.equalToSuperview().offset(kHomeEdgeSpace)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
        }
        self.titleLabel.text = "每个妈妈都应该成为营养师"
        
        self.containView.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(kHomeEdgeSpace)
            make.left.equalToSuperview().offset(kHomeEdgeSpace)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
        }
        self.subTitleLabel.text = "北京大学公开课"

        
        self.containView.addSubview(self.infoLabel)
        self.infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.subTitleLabel.snp.bottom).offset(kHomeEdgeSpace)
            make.left.equalToSuperview().offset(kHomeEdgeSpace)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
            make.bottom.equalToSuperview().offset(-kHomeEdgeSpace*2)
        }
        self.infoLabel.attributedText = Utils.getAttributeStringWithString("这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情这是营养课的详情", lineSpace: 3)

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
