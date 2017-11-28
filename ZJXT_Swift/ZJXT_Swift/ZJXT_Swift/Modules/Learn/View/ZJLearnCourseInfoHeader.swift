//
//  ZJLearnCourseInfoHeader.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnCourseInfoHeader: UIView
{
    var applyTestAction:(()->Void)?
    fileprivate lazy var imgView = UIImageView()
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var btn:UIButton = {
       let btn = UIButton()
        btn.setTitle("  申请考试  ", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.color(hex: "#00CE34")
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        return btn
    }()

    convenience init(frame:CGRect,img:UIImage,title:String,subTitle:String)
    {
        self.init(frame: frame)
        
        self.addSubview(self.imgView)
        self.imgView.layer.masksToBounds = true
        self.imgView.contentMode = .scaleAspectFit
        self.imgView.isUserInteractionEnabled = true
        self.imgView.image = img
        self.imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.imgView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*3)
            make.bottom.equalTo(self.snp.centerY).offset(-kHomeEdgeSpace)
        }
        
        self.imgView.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.snp.centerY).offset(kHomeEdgeSpace*5)
        }
        
        self.imgView.addSubview(self.btn)
        self.btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-kHomeEdgeSpace)
        }
    }
    
    @objc fileprivate func btnClicked()
    {
        if self.applyTestAction != nil
        {
            self.applyTestAction!()
        }
    }
}
