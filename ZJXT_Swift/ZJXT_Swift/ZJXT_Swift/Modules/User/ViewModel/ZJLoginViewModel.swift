//
//  ZJLoginViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/10.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJLoginViewModel: BaseViewModel
{
    //用户名密码登录的形式
    func getOldUserInfo(userName:String,password:String,popAction:(()->Void)?)
    {
        self.post(url: kLoginURL, param: ["UserName":userName,"Password":password], MBProgressHUD: true, success: { (response) in
            
            var dict = response?["entity"]["userLogin"]["userBaseInfo"].dictionaryValue
            
            let value = response?["entity"]["isHasUserPractice"]
            
            let companyNameValue = response?["entity"]["userPracticeInfo"]["companyName"]
            
            dict!["isHasUserPractice"] = value
            dict!["companyName"] = companyNameValue
            
            let model = UserInfo(dict: dict!)
            UserInfo.saveUserInfo(user: model)
            
            if popAction != nil
            {
                popAction!()
            }
            
        }, noData: {
            MBProgressHUD.show(error: "无此用户")
        }, failure: nil)
    }
    
    //手机号验证码登录的形式
    func getUserInfo(mobile:String,code:String,key:String,popAction:(()->Void)?)
    {        
        self.post(url: kLoginURL, param: ["mobile":mobile,"smsCode":code,"key":key], MBProgressHUD: true, success: { (response) in
            
            var dict = response?["entity"]["userLogin"]["userBaseInfo"].dictionaryValue
            
            let value = response?["entity"]["isHasUserPractice"]
            
            let companyNameValue = response?["entity"]["userPracticeInfo"]["companyName"]
            
            dict!["isHasUserPractice"] = value
            dict!["companyName"] = companyNameValue
            
            let model = UserInfo(dict: dict!)
            UserInfo.saveUserInfo(user: model)
            
            if popAction != nil
            {
                popAction!()
            }
            
        }, noData: {
            MBProgressHUD.show(error: "无此用户")
        }, failure: nil)
    }
    
    //获取验证码
    func getCode(mobile:String,finish:((String)->Void)?)
    {
        self.post(url: kLoginCodeURL, param: ["mobile":mobile], MBProgressHUD: false, success: { (response) in
            
            let key = response?["key"].stringValue
            
            if finish != nil
            {
                finish!(key!)
            }
            
        }, noData: {
        }, failure: nil)
    }
}
