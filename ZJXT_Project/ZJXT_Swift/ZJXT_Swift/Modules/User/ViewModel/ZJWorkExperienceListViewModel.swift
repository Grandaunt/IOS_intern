//
//  ZJWorkExperienceListViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJWorkExperienceListViewModel: BaseViewModel
{
    //获取实习经历列表
    func getPracticeList(finish:(([ZJVCExperiencePracticeModel])->Void)?,noData:(()->Void)?)
    {
        self.post(url: kVCPracitceListURL, param: ["userId":UserInfo.shard.userId!], MBProgressHUD: true, success: { (resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let dataArray = ZJVCExperiencePracticeModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJVCExperiencePracticeModel]
                finish!(dataArray)
            }
            
        }, noData: {
            if noData != nil
            {
                noData!()
            }
        }, failure: nil)
    }
    
    //获取工作经历列表
    func getWorkList(finish:(([ZJVCExperienceWorkModel])->Void)?,noData:(()->Void)?)
    {
        self.post(url: kVCWorkListURL, param: ["userId":UserInfo.shard.userId!], MBProgressHUD: true, success: { (resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let dataArray = ZJVCExperienceWorkModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJVCExperienceWorkModel]
                finish!(dataArray)
            }
            
        }, noData: {
            if noData != nil
            {
                noData!()
            }
        }, failure: nil)
    }
    
    //获取教育经历列表
    func getEduList(finish:(([ZJVCExperienceEducationModel])->Void)?,noData:(()->Void)?)
    {
        self.post(url: kVCEduListURL, param: ["userId":UserInfo.shard.userId!], MBProgressHUD: true, success: { (resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let dataArray = ZJVCExperienceEducationModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJVCExperienceEducationModel]
                finish!(dataArray)
            }
            
        }, noData: {
            if noData != nil
            {
                noData!()
            }
        }, failure: nil)
    }
    
    //获取教育经历列表
    func getProjectList(finish:(([ZJVCExperienceProjectModel])->Void)?,noData:(()->Void)?)
    {
        self.post(url: kVCProjectListURL, param: ["userId":UserInfo.shard.userId!], MBProgressHUD: true, success: { (resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let dataArray = ZJVCExperienceProjectModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJVCExperienceProjectModel]
                finish!(dataArray)
            }
            
        }, noData: {
            if noData != nil
            {
                noData!()
            }
        }, failure: nil)
    }
}
