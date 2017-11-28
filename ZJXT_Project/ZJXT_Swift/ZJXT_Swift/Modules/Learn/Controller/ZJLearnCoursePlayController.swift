//
//  ZJLearnCoursePlayController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//
//  内容详情的课程播放

class ZJLearnCoursePlayController: SecondViewController {

    var model:ZJLearnCourseVideoModel?
    var models:[ZJLearnCourseVideoModel]?  //保存下面的视频数组
    
    fileprivate var btnArray = [ZJLearnVideoButton]()

    fileprivate var containView = UIView()
    
    fileprivate var mainScrollView = UIScrollView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initScrollView()
        self.initView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func initScrollView()
    {
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    fileprivate func initView()
    {
        let mainContainView = UIView()
        self.mainScrollView.addSubview(mainContainView)
        mainContainView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(-kStatusHeight)
            make.width.equalToSuperview()  //纵向滑动就width等于UIScrollView，横向就height
        }
        
        //添加视频控件
        let player = BMPlayer(customControlView: CusBMPlayerControlView())
        mainContainView.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        
        BMPlayerConf.shouldAutoPlay = false
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let res0 = BMPlayerResourceDefinition(url: URL(string: (self.model?.videoPath)!)!,definition: "")

        let asset = BMPlayerResource(name: "",
                                     definitions: [res0],
                                     cover: URL(string: (self.model?.videoImage)!))

        player.setVideo(resource: asset)
        
        //视频详情
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#333333")
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = self.model?.videoName
        mainContainView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(player.snp.bottom).offset(kHomeEdgeSpace*2)
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
        }
        
        let infoLabel = UILabel()
        infoLabel.textColor = UIColor.color(hex: "#929292")
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
        let leftStr = "课时" + (self.model?.orderNum ?? "")
        infoLabel.text = leftStr + " | " + (self.model?.summary ?? "")
        mainContainView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(kHomeEdgeSpace*1.5)
            make.left.right.equalTo(label)
        }
        
        let line = UIView()
        line.backgroundColor = kCellLineColor
        mainContainView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(kHomeEdgeSpace*1.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        //课时label
        let allLLabel = UILabel()
        allLLabel.textColor = UIColor.color(hex: "#333333")
        allLLabel.font = UIFont.systemFont(ofSize: 16)
        allLLabel.text = "全部课时"
        mainContainView.addSubview(allLLabel)
        allLLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(kHomeEdgeSpace*2)
            make.centerX.equalToSuperview()
        }
        
        //课时数目label
        let numLabel = UILabel()
        numLabel.textColor = kTabbarBlueColor
        numLabel.font = UIFont.systemFont(ofSize: 14)
        numLabel.text = "共\((self.models?.count ?? 0))节"
        mainContainView.addSubview(numLabel)
        numLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
            make.centerY.equalTo(allLLabel)
        }
        
        //缩略图左右滑动
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        mainContainView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(allLLabel.snp.bottom).offset(kHomeEdgeSpace*2)
            make.height.equalTo(60)
        }
        scrollView.addSubview(self.containView)
        self.containView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()  //纵向滑动就width等于UIScrollView，横向就height
        }
        
        let space:CGFloat = 15
        
        var preBtn:ZJLearnVideoButton?
        
        //为了防止缩略图点击时多次添加
        if self.btnArray.count > 0
        {
            self.btnArray.removeAll()
        }
        
        //遍历并添加视频缩略图
        for (index,m) in (self.models?.enumerated())!
        {
            let title = "[课时\(m.orderNum ?? "0")]" + m.videoName!
            let btn = ZJLearnVideoButton(title: title, time: "")
            btn.af_setBackgroundImage(for: .normal, url: URL(string: (m.videoImage)!)!, placeholderImage: kUserLogoPlaceHolder)
            btn.addTarget(self, action: #selector(videoBtnClicekd(btn:)), for: .touchUpInside)
            if m == self.model
            {
                btn.textLabel.textColor = kTabbarBlueColor
            }
            else
            {
                btn.textLabel.textColor = UIColor.white
            }
            self.containView.addSubview(btn)
            if index == 0
            {
                btn.snp.makeConstraints({ (make) in
                    make.left.equalToSuperview().offset(space)
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(btn.snp.height).multipliedBy(16.0/9.0)
                })
            }
            else
            {
                btn.snp.makeConstraints({ (make) in
                    make.left.equalTo((preBtn?.snp.right)!).offset(space)
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(btn.snp.height).multipliedBy(16.0/9.0)
                })
            }
            
            if index == (self.models?.count)! - 1 && index != 0
            {
                btn.snp.makeConstraints({ (make) in
                    make.left.equalTo((preBtn?.snp.right)!).offset(space)
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(btn.snp.height).multipliedBy(16.0/9.0)
                    make.right.equalToSuperview().offset(-space)
                })
                
            }
            preBtn = btn
            self.btnArray.append(btn)
        }
        
        //添加课程重点
        let pointLabel = UILabel()
        pointLabel.textColor = UIColor.color(hex: "#333333")
        pointLabel.font = UIFont.systemFont(ofSize: 16)
        pointLabel.text = "课程重点"
        mainContainView.addSubview(pointLabel)
        pointLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(kHomeEdgeSpace*2)
            make.centerX.equalToSuperview()
        }
        
        //分割字符串
        let str = self.model?.videoKeyPiont
        let b:CharacterSet=NSCharacterSet(charactersIn:",") as CharacterSet
        let strArray = str?.components(separatedBy: b)
        
        //遍历并添加label
        var preLabel:UILabel?
        for (index,title) in (strArray?.enumerated())!
        {
            let label = UILabel()
            label.textColor = UIColor.color(hex: "#929292")
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = " · " + title
            mainContainView.addSubview(label)
            
            //个数为1直接限制bottom
            if strArray?.count == 1
            {
                label.snp.makeConstraints({ (make) in
                    make.left.equalToSuperview().offset(20)
                    make.right.equalToSuperview().offset(-20)
                    make.top.equalTo(pointLabel.snp.bottom).offset(kHomeEdgeSpace*2)
                    make.bottom.equalToSuperview().offset(-kHomeEdgeSpace*2)
                })

            }
            else
            {
                if index == 0
                {
                    label.snp.makeConstraints({ (make) in
                        make.left.equalToSuperview().offset(20)
                        make.right.equalToSuperview().offset(-20)
                        make.top.equalTo(pointLabel.snp.bottom).offset(kHomeEdgeSpace*2)
                    })
                }
                else
                {
                    label.snp.makeConstraints({ (make) in
                        make.left.right.equalTo(preLabel!)
                        make.top.equalTo((preLabel?.snp.bottom)!).offset(kHomeEdgeSpace)
                    })
                }
                
                //最后一个时限制bottom
                if index == (strArray?.count)! - 1
                {
                    label.snp.makeConstraints({ (make) in
                        make.left.right.equalTo(preLabel!)
                        make.top.equalTo((preLabel?.snp.bottom)!).offset(kHomeEdgeSpace)
                        make.bottom.equalToSuperview().offset(-kHomeEdgeSpace*2)
                    })
                }
            }
            
            preLabel = label
        }
        
    }
    
    @objc fileprivate func videoBtnClicekd(btn:ZJLearnVideoButton)
    {
        let btnIndex = self.btnArray.index(of: btn)
        let modelIndex = self.models?.index(of: self.model!)
        if btnIndex != modelIndex
        {
            for view in self.mainScrollView.subviews
            {
                view.removeFromSuperview()
            }
            self.model = self.models?[btnIndex!]
            self.initView()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
