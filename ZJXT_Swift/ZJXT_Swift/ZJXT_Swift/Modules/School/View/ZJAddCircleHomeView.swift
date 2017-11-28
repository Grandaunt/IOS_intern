//
//  ZJAddCircleHomeView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJAddCircleHomeView: UIView
{
    var backAction:(()->Void)?
    var callAction:(()->Void)?   //我要约吧
    var sayAction:(()->Void)?    //我的心情
    fileprivate lazy var closeBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(IconFontUtils.imageSquare(code: "\u{e646}", size: 20, color: UIColor.color(hex: "#333333")), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var callBtn:UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 45
        btn.setBackgroundImage(UIImage(named:"school_call"), for: .normal)
        btn.addTarget(self, action: #selector(callBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var sayBtn:UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 45
        btn.setBackgroundImage(UIImage(named:"school_say"), for: .normal)
        btn.addTarget(self, action: #selector(sayBtnClicked), for: .touchUpInside)
        return btn
    }()

    override func draw(_ rect: CGRect)
    {
        self.addSubview(self.closeBtn)
        self.closeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusHeight + 11)
            make.width.height.equalTo(20)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
        }
        
        let label = UILabel()
        label.attributedText = Utils.getAttributeStringWithString("你若光明\n这个世界都不会黑暗", lineSpace: 3)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.color(hex: "#333333")
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(132)
            make.centerX.equalToSuperview()
        }
        
        
        self.addSubview(self.callBtn)
        self.callBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(kHomeEdgeSpace*5)
            make.width.height.equalTo(90)
            make.right.equalTo(self.snp.centerX).offset(-25)
        }
        
        let label1 = UILabel()
        label1.text = "我要约吧"
        label1.font = UIFont.systemFont(ofSize: 16)
        label1.textColor = UIColor.color(hex: "#666666")
        self.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(self.callBtn.snp.bottom).offset(kHomeEdgeSpace)
            make.centerX.equalTo(self.callBtn)
        }

        self.addSubview(self.sayBtn)
        self.sayBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.callBtn)
            make.width.height.equalTo(90)
            make.left.equalTo(self.snp.centerX).offset(25)
        }
        
        let label2 = UILabel()
        label2.text = "我的心情"
        label2.textColor = UIColor.color(hex: "#666666")
        self.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(self.callBtn.snp.bottom).offset(kHomeEdgeSpace)
            make.centerX.equalTo(self.sayBtn)
        }
    }
    
    @objc fileprivate func back()
    {
        if self.backAction != nil
        {
            self.backAction!()
        }
    }
    
    @objc fileprivate func sayBtnClicked()
    {
        if self.sayAction != nil
        {
            self.sayAction!()
        }
    }
    
    @objc fileprivate func callBtnClicked()
    {
        if self.callAction != nil
        {
            self.callAction!()
        }
    }
}
