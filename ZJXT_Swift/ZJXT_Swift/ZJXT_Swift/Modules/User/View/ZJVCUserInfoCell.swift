//
//  ZJVCUserInfoCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJVCUserInfoCell: UITableViewCell
{
    var editUserInfoAction:((ZJVCResumeInfoModel)->Void)?
    var model:ZJVCResumeInfoModel?{
        didSet{
            self.nameField.text = model?.userName
            
            if model?.resumeMale != nil
            {
                if model?.resumeMale == "1"
                {
                    self.sexField.text = "男"
                    self.manBtn.isSelected = true
                    self.womanBtn.isSelected = false
                }
                else
                {
                    self.sexField.text = "女"
                    self.manBtn.isSelected = true
                    self.womanBtn.isSelected = false
                }
            }
            self.workField.text = model?.resumepost
            
            self.addressField.text = model?.resumeAddress
            
            
            self.phoneField.text = model?.resumeTel
            
            
            self.emailField.text = model?.resumeEmile
        }
    }

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var workField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    lazy var manBtn:UIButton = {[weak self] in
        let btn = UIButton()
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e6d7}", size: 15, color: UIColor.color(hex: "#d8d8d8")), for: .normal)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e656}", size: 15, color: kTabbarBlueColor), for: .selected)
        btn.setTitleColor(UIColor.color(hex: "#666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(" 男", for: .normal)
        btn.addTarget(self, action: #selector(sexBtnCilcked(btn:)), for: .touchUpInside)
        btn.isSelected = true
        btn.isHidden = true
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
        btn.isHidden = true
        return btn
    }()

    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //如果在xib中直接设置无边框，会导致输入字体下沉
        self.nameField.borderStyle = .none
        self.sexField.borderStyle = .none
        self.workField.borderStyle = .none
        self.addressField.borderStyle = .none
        self.phoneField.borderStyle = .none
        self.emailField.borderStyle = .none
        
        self.contentView.addSubview(self.manBtn)
        self.contentView.addSubview(self.womanBtn)
        self.manBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.sexField)
            make.left.equalTo(self.sexField).offset(10)
        }
        self.womanBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.manBtn)
            make.left.equalTo(self.manBtn.snp.right).offset(15)
        }

    }

    @IBAction func editBtnClicked(_ sender: UIButton)
    {
        if !sender.isSelected
        {
            self.sexField.isHidden = true
            self.manBtn.isHidden = false
            self.womanBtn.isHidden = false
            
            self.nameField.isEnabled = true
            self.workField.isEnabled = true
            self.addressField.isEnabled = true
            self.phoneField.isEnabled = true
            self.emailField.isEnabled = true
            self.nameField.becomeFirstResponder()
        }
        else
        {
            //这里进行保存处理
            
            if self.editUserInfoAction != nil
            {
                let m = ZJVCResumeInfoModel()
                m.userName = self.nameField.text
                m.resumeMale = self.manBtn.isSelected ? "1" : "0"
                m.resumepost = self.workField.text
                m.resumeAddress = self.addressField.text
                m.resumeTel = self.phoneField.text
                m.resumeEmile = self.emailField.text
                
                self.editUserInfoAction!(m)
            }
            
            self.sexField.isHidden = false
            self.manBtn.isHidden = true
            self.womanBtn.isHidden = true
            
            self.nameField.isEnabled = false
            self.workField.isEnabled = false
            self.addressField.isEnabled = false
            self.phoneField.isEnabled = false
            self.emailField.isEnabled = false
            
            if self.manBtn.isSelected
            {
                self.sexField.text = "男"
            }
            else
            {
                self.sexField.text = "女"
            }
        }
        
        sender.isSelected = !sender.isSelected
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
