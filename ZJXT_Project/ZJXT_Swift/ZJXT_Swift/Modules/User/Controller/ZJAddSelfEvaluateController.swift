//
//  ZJAddSelfEvaluateController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/17.
//  Copyright © 2017年 runer. All rights reserved.
//
//  自我评价
import UIKit
import MBProgressHUD

class ZJAddSelfEvaluateController: SecondViewController
{
    var model:ZJVCResumeInfoModel?
    
    fileprivate lazy var textView:PlaceholderTextView = {
        let phTextView = PlaceholderTextView()
        phTextView.placeholder = "详细描述一下你自己，字数控制在100-800字"
        
        phTextView.placeholderLabel.textColor = UIColor.color(hex: "#CCCCCC")
        phTextView.placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        phTextView.font = UIFont.systemFont(ofSize: 16)
        phTextView.backgroundColor = UIColor.white
        phTextView.layer.masksToBounds = true
        phTextView.layer.cornerRadius = 3
        
        phTextView.maxLength = 800
        return phTextView
    }()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initNav()
        initView()
    }
    
    fileprivate func initNav()
    {
        //调整位置，以防往右偏移
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    fileprivate func initView()
    {
        let maskView = UIView()
        maskView.backgroundColor = UIColor.white
        self.view.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        maskView.addSubview(self.textView)
        
        if self.model?.resumeSelfDes != nil || self.model?.resumeSelfDes?.trimAfterCount() != 0
        {
            self.textView.text = self.model?.resumeSelfDes
        }
        
        self.textView.snp.makeConstraints({ (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
//            make.left.right.equalToSuperview()
        })
    }
    
    @objc fileprivate func save()
    {
        if (self.textView.text ?? "").trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写描述")
            return
        }
        
        var param = [String:Any]()
        param["userName"] = self.model?.userName
        param["resumeId"] = self.model?.resumeId
        param["userId"] = UserInfo.shard.userId
        param["resumeMale"] = self.model?.resumeMale
        param["resumepost"] = self.model?.resumepost
        param["resumeAddress"] = self.model?.resumeAddress
        param["resumeTel"] = self.model?.resumeTel
        param["resumeEmile"] = self.model?.resumeEmile
        param["resumeSelfDes"] = self.textView.text
        
        let model = BaseViewModel()
        model.post(url: kVCEditUserInfoURL, param: param, MBProgressHUD: true, success: { (_) in
            if self.model?.resumeSelfDes == nil
            {
                MBProgressHUD.show(info: "添加成功")
            }
            else
            {
                MBProgressHUD.show(info: "编辑成功")
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }, noData: nil, failure: nil)
    }

}
