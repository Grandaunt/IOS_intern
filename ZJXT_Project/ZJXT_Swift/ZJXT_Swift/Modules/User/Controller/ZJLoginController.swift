//
//  ZJLoginController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/7.
//  Copyright © 2017年 runer. All rights reserved.
//

import MBProgressHUD

class ZJLoginController: SecondViewController
{

    var loginSuccessAction:(()->Void)?
    
    fileprivate var key:String?
    
    @IBOutlet fileprivate weak var mobileField: UITextField!
    @IBOutlet fileprivate weak var codeFiled: UITextField!
    @IBOutlet fileprivate weak var codeButton: UIButton!
    @IBOutlet fileprivate weak var loginBtn: UIButton!
    
    fileprivate var viewModel = ZJLoginViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }
    
    @IBAction func textFieldChanged(_ field: UITextField)
    {
        if field == self.mobileField
        {
//            if Utils.isPhoneNumber(phoneNumber: field.text!)
            if field.text!.count > 0
            {
                self.codeButton.isUserInteractionEnabled = true
                self.codeButton.backgroundColor = kTabbarBlueColor
                
                self.loginBtn.isUserInteractionEnabled = true
                self.loginBtn.backgroundColor = kTabbarBlueColor
                self.loginBtn.setTitleColor(UIColor.white, for: .normal)
            }
            else
            {
                self.codeButton.isUserInteractionEnabled = false
                self.codeButton.backgroundColor = UIColor.color(hex: "#BDBDBD")
                
                self.loginBtn.isUserInteractionEnabled = false
                self.loginBtn.backgroundColor = UIColor.color(hex: "#F2F2F2")
                self.loginBtn.setTitleColor(UIColor.color(hex: "#939393"), for: .normal)
                
            }
        }
    }
    
    //获取验证码
    @IBAction func codeAction(_ sender: UIButton)
    {
        self.viewModel.getCode(mobile: self.mobileField.text!) {[weak self] (key) in
            self?.view.endEditing(true)
            MBProgressHUD.show(info: "验证码已发送")
            Utils.startTime(btn: sender, time: 60)
            self?.key = key
        }
    }

    @IBAction func loginAction(_ sender: UIButton)
    {
        self.codeFiled.resignFirstResponder()
        self.mobileField.resignFirstResponder()
        
        if self.codeFiled.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请输入密码")
            self.codeFiled.becomeFirstResponder()
            return
        }
        
        self.viewModel.getOldUserInfo(userName: self.mobileField.text!, password: self.codeFiled.text!) {[weak self] in
            if self?.loginSuccessAction != nil
            {
                self?.loginSuccessAction!()
            }
            else
            {
                self?.navigationController?.popViewController(animated: true)
            }
        }

        
        //验证码的形式
//        if self.codeFiled.text?.trimAfterCount() == 0
//        {
//            MBProgressHUD.show(error: "请输入验证码")
//            self.codeFiled.becomeFirstResponder()
//            return
//        }
//        //为了测试帐号能登录，暂时不进行判断key值
//        //        if self.key == nil
//        //        {
//        //            MBProgressHUD.show(error: "请重新发送验证码")
//        //            self.codeFiled.becomeFirstResponder()
//        //            return
//        //        }
//
//        self.viewModel.getUserInfo(mobile: self.mobileField.text!, code: self.codeFiled.text!, key: self.key!)
//        {[weak self] in
//            if self?.loginSuccessAction != nil
//            {
//                self?.loginSuccessAction!()
//            }
//            else
//            {
//                self?.navigationController?.popViewController(animated: true)
//            }
//        }
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
