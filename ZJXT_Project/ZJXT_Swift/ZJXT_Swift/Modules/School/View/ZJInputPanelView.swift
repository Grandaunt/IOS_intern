//
//  ZJInputPanelView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//
//  键盘上的输入视图

import UIKit
import MBProgressHUD

fileprivate var TopicCommentToolBarMinHeight:CGFloat = 35


class ZJInputPanelView: UIView
{
    var inputDoneAction:((String)->Void)?  //点击发送以后
    
    fileprivate var keyboardHeight:CGFloat = 0  //保存键盘的高度
    
    fileprivate lazy var bottomToolBar:UIView = {   //上部的工具条
        let bottom = UIView()
        return bottom
    }()
    
    fileprivate lazy var textView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textAlignment = .left
        textView.textColor = UIColor.color(hex: "#323232")
        var insets = textView.textContainerInset
        insets.left = 10
        insets.right = 10
        textView.textContainerInset = insets
        textView.returnKeyType = .send
        textView.enablesReturnKeyAutomatically = true
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.layer.cornerRadius = 3.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.color(hex: "#FB9A4B").cgColor
        textView.backgroundColor = UIColor.color(hex: "#F5F5F5")
        textView.delegate = self
        textView.wzb_textViewHeightDidChanged = { height in
            self.bottomToolBarWillChangeHeight(height: height)
        }
        return textView
    }()

    class func inputPanelView() -> ZJInputPanelView
    {
        return ZJInputPanelView()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setupSubViews()
        self.addNotificationCenter()
        
    }
    
    func show()
    {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        self.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
            self.textView.becomeFirstResponder()
        }
        
    }
    
    func dismiss()
    {
        self.textView.resignFirstResponder()
        //之后后自动触发键盘监听，移除该视图
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化子视图
    fileprivate func setupSubViews()
    {
        self.setupControlView()
        self.setupBottomToolBar()
    }
    
    //设置control，让其被点击触发隐藏方法
    fileprivate func setupControlView()
    {
        let backgroundControl = UIControl()
        backgroundControl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        backgroundControl.addTarget(self, action: #selector(backgroundDidClicked(control:)), for: .touchUpInside)
        self.addSubview(backgroundControl)
        backgroundControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func setupBottomToolBar()
    {
        self.addSubview(self.bottomToolBar)
        self.bottomToolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(TopicCommentToolBarMinHeight)
            make.height.equalTo(TopicCommentToolBarMinHeight)
        }

        self.bottomToolBar.addSubview(self.textView)
        
        self.textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }

    }
    
    //添加监听
    fileprivate func addNotificationCenter()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notifiction:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //为了防止点击键盘上的收回按钮，control层不移除的bug
        NotificationCenter.default.addObserver(self, selector: #selector(keyboaderWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc fileprivate func backgroundDidClicked(control:UIControl)
    {
        self.dismiss()
    }
    
    @objc fileprivate func keyboardWillChangeFrame(notifiction:Notification)
    {
        let userInfo = notifiction.userInfo as! [String:Any]
        
        let endFrame:CGRect = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let beginFrame:CGRect = userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect
        let duration:CGFloat = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        let intValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! Int
        
        let options:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: UIViewAnimationOptions.RawValue((intValue << 16) | Int(UIViewAnimationOptions.beginFromCurrentState.rawValue)))
        
        weak var weakSelf = self
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: options, animations: {
            weakSelf?.willShowKeyboardWithFromFrame(fromFrame: beginFrame, toFrame: endFrame)
        }) { (finish) in
            
        }
    }
    
    @objc fileprivate func keyboaderWillHide()
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
            self.removeFromSuperview()
        }
    }
    
    fileprivate func willShowKeyboardWithFromFrame(fromFrame:CGRect,toFrame:CGRect)
    {
        if fromFrame.origin.y == UIScreen.main.bounds.size.height
        {
            //键盘弹起
            self.bottomToolBarWillChangeBottomHeight(bottomHeight: toFrame.size.height)
        }
        else if toFrame.origin.y == UIScreen.main.bounds.size.height
        {
            //键盘收回
            self.bottomToolBarWillChangeBottomHeight(bottomHeight: 0)
        }
        else
        {
            // bottomToolBar距离底部的高度
            self.bottomToolBarWillChangeBottomHeight(bottomHeight: toFrame.size.height)
        }
    }
    
    fileprivate func bottomToolBarWillChangeBottomHeight(bottomHeight:CGFloat)
    {
        //记录键盘高度
        self.keyboardHeight = bottomHeight
        
        var height = bottomHeight
        
        if bottomHeight <= 0
        {
            height = -1*kScreenViewHeight
        }
        
        self.bottomToolBar.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-1 * height)
        }
        
        // 键盘高度改变了也要去查看一下bottomToolBar的布局
//        self.bottomToolBarWillChangeHeight(height: self.getTextViewHeight(textView: self.textView))
        
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        self.layoutIfNeeded()
    }
    
    fileprivate func bottomToolBarWillChangeHeight(height:CGFloat)
    {
        var toHeight = height
        if height < TopicCommentToolBarMinHeight || self.textView.text.count == 0
        {
            toHeight = TopicCommentToolBarMinHeight
        }
        
        let maxHeight = kScreenViewHeight - self.keyboardHeight
        if toHeight > maxHeight
        {
            toHeight = maxHeight
        }
        
        self.bottomToolBar.snp.updateConstraints { (make) in
            make.height.equalTo(toHeight)
        }
        
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        self.layoutIfNeeded()
    }
        
    fileprivate func send()
    {
        if self.textView.text.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "回复内容不能为空")
            return
        }
        
        if self.inputDoneAction != nil
        {
            self.inputDoneAction!(self.textView.text)
        }
        self.dismiss()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
}

extension ZJInputPanelView:UITextViewDelegate
{
    //代理
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            self.send()
            return false
        }
        return true
    }
}
