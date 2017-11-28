//
//  ZJAddCommentController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/11.
//  Copyright © 2017年 runer. All rights reserved.
//
//  评论界面

import UIKit
import MBProgressHUD

class ZJAddCommentController: SecondViewController
{
    var circleId:String?
    var circleCommentId:String?  //如果传这个参数，就是对一级评论进行评论
    var toUser:String?
    var toUserId:String?
    
    var mainCommentSuccess:(()->Void)?  //主评论
    var subCommentSuccess:((String)->Void)?   //子评论
    
    fileprivate lazy var textView:UITextView = {
        let textView = UITextView()
        textView.wzb_placeholder = "写评论..."
        if self.toUser != nil
        {
            textView.wzb_placeholder = self.toUser
        }
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
    }
    
    fileprivate func initNav()
    {
        let rightItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(saveSay))
        rightItem.isEnabled = false
        rightItem.tintColor = UIColor.color(hex: "#cccccc")
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    fileprivate func initView()
    {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(kScreenViewHeight/3)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.color(hex: "#f9f9f9")
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let leftBtn = UIButton()
        leftBtn.setBackgroundImage(UIImage(named:"school_say_img_gray"), for: .normal)
        leftBtn.isEnabled = false
        bottomView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenViewWidth/6)
            make.centerY.equalToSuperview()
        }
        
        let centerBtn = UIButton()
        centerBtn.setBackgroundImage(UIImage(named:"school_say_at"), for: .normal)
        bottomView.addSubview(centerBtn)
        centerBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let rightBtn = UIButton()
        rightBtn.setBackgroundImage(UIImage(named:"school_say_emoj"), for: .normal)
        bottomView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenViewWidth/6*5)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc fileprivate func saveSay()
    {
        if self.textView.text == ""
        {
            MBProgressHUD.show(error: "请输入评论内容")
            return
        }
        
        if self.circleCommentId == nil   //对圈子进行评论
        {
            var param = [String:Any]()
            param["circleId"] = self.circleId
            param["userId"] = UserInfo.shard.userId
            param["comment"] = self.textView.text
            BaseViewModel().post(url: kAddCircleCommentURL, param: param, MBProgressHUD: true, success: { (resp) in
                MBProgressHUD.show(info: "评论成功")
                
                if self.mainCommentSuccess != nil
                {
                    self.mainCommentSuccess!()
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }, noData: nil, failure: nil)
        }
        else //对主评论进行评论
        {
            var param = [String:Any]()
            param["circleId"] = self.circleId
            param["userId"] = UserInfo.shard.userId
            param["comment"] = self.textView.text
            param["commentId"] = self.circleCommentId
            param["toUserId"] = self.toUserId
            BaseViewModel().post(url: kAddCircelCommentSubURL, param: param, MBProgressHUD: true, success: { (resp) in
                MBProgressHUD.show(info: "评论成功")

                if self.subCommentSuccess != nil
                {
                    self.subCommentSuccess!(self.textView.text!)
                }

                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }, noData: nil, failure: nil)

        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJAddCommentController:UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        if textView.text.count > 0
        {
            self.navigationItem.rightBarButtonItem?.tintColor = kTabbarBlueColor
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else
        {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.color(hex: "#cccccc")
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
