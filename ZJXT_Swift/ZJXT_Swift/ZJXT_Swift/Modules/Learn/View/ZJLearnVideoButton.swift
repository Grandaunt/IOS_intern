//
//  ZJLearnVideoButton.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnVideoButton: UIButton
{
     lazy var textLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
     lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    convenience init(title:String,time:String)
    {
        self.init(type: .custom)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        self.addSubview(self.textLabel)
        self.textLabel.text = title
        self.textLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        self.addSubview(self.timeLabel)
        self.timeLabel.text = time
        self.timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }

    }
}
