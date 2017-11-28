//
//  ZJVCHomeViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJVCHomeViewModel: BaseViewModel
{
    func getVCInfo(info:((ZJVCHomeModel?)->Void)?)
    {
        self.post(url: kVCInfoURL, param: ["StudentId":UserInfo.shard.userId!], MBProgressHUD: true, success: { (resp) in
            
            let dict = resp?["entity"].dictionaryObject
            
            let model = ZJVCHomeModel.mj_object(withKeyValues: dict)
            
            if info != nil
            {
                info!(model)
            }
            
        }, noData: {
            
        }) { (error) in
            
        }
    }
    
    func editUserInfo(img:UIImage?,model:ZJVCResumeInfoModel)
    {
        if img == nil
        {
            var param = [String:Any]()
            param["userName"] = model.userName
            param["resumeId"] = model.resumeId
            param["userId"] = UserInfo.shard.userId
            param["resumeMale"] = model.resumeMale
            param["resumepost"] = model.resumepost
            param["resumeAddress"] = model.resumeAddress
            param["resumeTel"] = model.resumeTel
            param["resumeEmile"] = model.resumeEmile
            param["resumeSelfDes"] = model.resumeSelfDes
            
            //这里应该传头像 ResumeUserIcon
            self.post(url: kVCEditUserInfoURL, param: param, MBProgressHUD: true, success: { (res) in
                MBProgressHUD.show(info: "修改成功")
            }, noData: nil, failure: nil)
        }
        else
        {
            self.postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [img!], isProgressHud: false, commonFileName: "logo", progress: nil, success: {[weak self] (resp) in
                
                var param = [String:Any]()
                param["userName"] = model.userName
                param["resumeId"] = model.resumeId
                param["userId"] = UserInfo.shard.userId
                param["resumeMale"] = model.resumeMale
                param["resumepost"] = model.resumepost
                param["resumeAddress"] = model.resumeAddress
                param["resumeTel"] = model.resumeTel
                param["resumeEmile"] = model.resumeEmile
                param["resumeSelfDes"] = model.resumeSelfDes
                param["resumeUserIcon"] = resp?["url"].stringValue
                
                //这里应该传头像 ResumeUserIcon
                self?.post(url: kVCEditUserInfoURL, param: param, MBProgressHUD: true, success: { (res) in
                    MBProgressHUD.show(info: "修改成功")
                }, noData: nil, failure: nil)
                
                }, failure: nil)
        }
    }
}
