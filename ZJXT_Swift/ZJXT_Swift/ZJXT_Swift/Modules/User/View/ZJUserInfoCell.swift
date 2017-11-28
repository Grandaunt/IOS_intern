//
//  ZJUserInfoCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/7.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJUserInfoCell: BaseTableViewCell
{
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.color(hex: "#333333")
        return label;
    }()
    
    lazy var textField:UITextField = {
        
        let textField = UITextField()
        textField.textColor = UIColor.color(hex: "#666666")
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textAlignment = .right
        return textField
    }()
    
    lazy var manBtn:UIButton = {[weak self] in
        let btn = UIButton()
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e6d7}", size: 15, color: UIColor.color(hex: "#d8d8d8")), for: .normal)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e656}", size: 15, color: kTabbarBlueColor), for: .selected)
        btn.setTitleColor(UIColor.color(hex: "#666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(" 男", for: .normal)
        btn.addTarget(self, action: #selector(sexBtnCilcked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var womanBtn:UIButton = {[weak self] in
        let btn = UIButton()
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e6d7}", size: 15, color: UIColor.color(hex: "#d8d8d8")), for: .normal)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e656}", size: 15, color: kTabbarBlueColor), for: .selected)
        btn.setTitleColor(UIColor.color(hex: "#666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(" 女", for: .normal)
        btn.addTarget(self, action: #selector(sexBtnCilcked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.bottomLineStyle = .fill
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.textField)
        self.contentView.addSubview(self.manBtn)
        self.contentView.addSubview(self.womanBtn)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview()
        }
        self.textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
        }
        
        self.womanBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
        }
        
        self.manBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.womanBtn.snp.left).offset(-17)
        }
    }
    
    //MARK:- 类方法实例化
    static fileprivate let CELLID = "ZJUserInfoCell"
    class func cellWithTableView(_ tableView:UITableView) -> ZJUserInfoCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: CELLID) as? ZJUserInfoCell
        if cell == nil
        {
            cell = ZJUserInfoCell(style: UITableViewCellStyle.default, reuseIdentifier: CELLID)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    @objc fileprivate func sexBtnCilcked(btn:UIButton)
    {
        btn.isSelected = true
        if btn == self.manBtn
        {
            self.womanBtn.isSelected = false
        }
        else
        {
            self.manBtn.isSelected = false
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
