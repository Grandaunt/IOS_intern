//
//  ZJUserInfoViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/11.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJUserInfoViewModel: BaseViewModel
{
    func update(nickName:String?,img:UIImage?,icon:UIImage?,finish:(()->Void)?)
    {
        if icon == nil && img != nil
        {
            self.postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [img!], isProgressHud: false, commonFileName: "logo", progress: nil, success: {[weak self] (resp) in
                
                //保存
                let userInfo = UserInfo.shard
                userInfo.logo = resp?["url"].stringValue
                UserInfo.saveUserInfo(user: userInfo)
                
                var param = [String:Any]()
                param["userId"] = UserInfo.shard.userId
                param["nickName"] = nickName
                param["logo"] = resp?["url"].stringValue
                    
                    self?.post(url: kEditUserInfoURL, param: param, MBProgressHUD: true, success: { (response) in
                        MBProgressHUD.show(info: "修改成功")
                        let userInfo = UserInfo.shard
                        userInfo.nickName = nickName
                        userInfo.logo = resp?["url"].stringValue
                        UserInfo.saveUserInfo(user: userInfo)
                        if finish != nil
                        {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                finish!()
                            }
                        }
                    }, noData: nil, failure: nil)
                }, failure: nil)
        }
        else if icon != nil && img == nil
        {
            self.postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [icon!], isProgressHud: false, commonFileName: "icon", progress: nil, success: {[weak self] (res) in
                
                var param = [String:Any]()
                param["userId"] = UserInfo.shard.userId
                param["nickName"] = nickName
                param["icon"] = res?["url"].stringValue
                
                self?.post(url: kEditUserInfoURL, param: param, MBProgressHUD: true, success: { (response) in
                    MBProgressHUD.show(info: "修改成功")
                    
                    let userInfo = UserInfo.shard
                    userInfo.nickName = nickName
                    userInfo.icon = res?["url"].stringValue
                    UserInfo.saveUserInfo(user: userInfo)
                    if finish != nil
                    {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            finish!()
                        }
                    }
                }, noData: nil, failure: nil)
            }, failure: nil)
        }
        else
        {
            self.postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [img!], isProgressHud: false, commonFileName: "logo", progress: nil, success: {[weak self] (resp) in
                
                //保存
                let userInfo = UserInfo.shard
                userInfo.logo = resp?["url"].stringValue
                UserInfo.saveUserInfo(user: userInfo)
                
                self?.postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [icon!], isProgressHud: false, commonFileName: "icon", progress: nil, success: { (res) in
                    
                    //保存
                    let userInfo = UserInfo.shard
                    userInfo.icon = res?["url"].stringValue
                    UserInfo.saveUserInfo(user: userInfo)
                    
                    var param = [String:Any]()
                    param["userId"] = UserInfo.shard.userId
                    param["nickName"] = nickName
                    param["logo"] = resp?["url"].stringValue
                    param["icon"] = res?["url"].stringValue
                    
                    self?.post(url: kEditUserInfoURL, param: param, MBProgressHUD: true, success: { (response) in
                        MBProgressHUD.show(info: "修改成功")
                        let userInfo = UserInfo.shard
                        userInfo.logo = resp?["url"].stringValue
                        userInfo.nickName = nickName
                        UserInfo.saveUserInfo(user: userInfo)
                        if finish != nil
                        {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                finish!()
                            }
                        }
                    }, noData: nil, failure: nil)
                }, failure: nil)
                }, failure: nil)
        }
    }
}
