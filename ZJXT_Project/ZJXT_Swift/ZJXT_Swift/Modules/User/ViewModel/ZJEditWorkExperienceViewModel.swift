//
//  ZJEditWorkExperienceViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJEditWorkExperienceViewModel: BaseViewModel
{
    //添加，编辑实习经历
    func addPracticeExperience(model:ZJVCExperiencePracticeModel,finish:(()->Void)?)
    {
        if model.companyName?.trimAfterCount() == 0 || model.practicePost?.trimAfterCount() == 0 || model.practiceStartTime?.trimAfterCount() == 0 || model.practiceEndTime?.trimAfterCount() == 0 || model.practiceDes?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写完整")
            return
        }
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["companyName"] = model.companyName
        param["practiceId"] = model.practiceId  //编辑的时候
        param["practicePost"] = model.practicePost
        param["practiceStartTime"] = model.practiceStartTime
        param["practiceEndTime"] = model.practiceEndTime
        param["practiceDes"] = model.practiceDes
        self.post(url: kVCEditPracticeExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            
            if model.practiceId == nil
            {
                MBProgressHUD.show(info: "添加成功")
            }
            else
            {
                MBProgressHUD.show(info: "编辑成功")
            }
            
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }

            }
        }, noData: nil, failure: nil)
    }
    
    //删除实习经历
    func delPracticeExperience(model:ZJVCExperiencePracticeModel,finish:(()->Void)?)
    {
        var param = [String:Any]()
        param["practiceId"] = model.practiceId  //编辑的时候
        self.post(url: kVCDelPracticeExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            MBProgressHUD.show(info: "删除成功")
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
    
    //添加，编辑工作经历
    func addWorkExperience(model:ZJVCExperienceWorkModel,finish:(()->Void)?)
    {
        if model.companyName?.trimAfterCount() == 0 || model.workPost?.trimAfterCount() == 0 || model.workStartTime?.trimAfterCount() == 0 || model.workEndTime?.trimAfterCount() == 0 || model.workDes?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写完整")
            return
        }
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["companyName"] = model.companyName
        param["workId"] = model.workId  //编辑的时候
        param["workPost"] = model.workPost
        param["workStartTime"] = model.workStartTime
        param["workEndTime"] = model.workEndTime
        param["workDes"] = model.workDes
        self.post(url: kVCEditWorkExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            
            if model.workId == nil
            {
                MBProgressHUD.show(info: "添加成功")
            }
            else
            {
                MBProgressHUD.show(info: "编辑成功")
            }
            
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
    
    //删除工作经历
    func delWorkExperience(model:ZJVCExperienceWorkModel,finish:(()->Void)?)
    {
        var param = [String:Any]()
        param["workId"] = model.workId  //编辑的时候
        self.post(url: kVCDelWorkExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            MBProgressHUD.show(info: "删除成功")
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
    
    //添加，编辑教育经历
    func addEduExperience(model:ZJVCExperienceEducationModel,finish:(()->Void)?)
    {
        if model.schoolName?.trimAfterCount() == 0 || model.educationMajor?.trimAfterCount() == 0 || model.educationStartTime?.trimAfterCount() == 0 || model.educationEndTime?.trimAfterCount() == 0 || model.educationDes?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写完整")
            return
        }
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["schoolName"] = model.schoolName
        param["educationId"] = model.educationId  //编辑的时候
        param["educationMajor"] = model.educationMajor
        param["educationStartTime"] = model.educationStartTime
        param["educationEndTime"] = model.educationEndTime
        param["educationDes"] = model.educationDes
        self.post(url: kVCEditEduExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            
            if model.educationId == nil
            {
                MBProgressHUD.show(info: "添加成功")
            }
            else
            {
                MBProgressHUD.show(info: "编辑成功")
            }
            
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
    
    //删除教育经历
    func delEduExperience(model:ZJVCExperienceEducationModel,finish:(()->Void)?)
    {
        var param = [String:Any]()
        param["educationId"] = model.educationId  //编辑的时候
        self.post(url: kVCDelEduExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            MBProgressHUD.show(info: "删除成功")
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
    
    //添加，编辑项目经历
    func addProjectExperience(model:ZJVCExperienceProjectModel,finish:(()->Void)?)
    {
        if model.companyName?.trimAfterCount() == 0 || model.projectPost?.trimAfterCount() == 0 || model.projectStartTime?.trimAfterCount() == 0 || model.projectEndTime?.trimAfterCount() == 0 || model.projectDes?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写完整")
            return
        }
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["projectName"] = model.projectName
        param["projectId"] = model.projectId  //编辑的时候
        param["projectPost"] = model.projectPost
        param["projectStartTime"] = model.projectStartTime
        param["projectEndTime"] = model.projectEndTime
        param["projectDes"] = model.projectDes
        self.post(url: kVCEditProjectExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            
            if model.projectId == nil
            {
                MBProgressHUD.show(info: "添加成功")
            }
            else
            {
                MBProgressHUD.show(info: "编辑成功")
            }
            
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
    
    //删除项目经历
    func delProjectExperience(model:ZJVCExperienceProjectModel,finish:(()->Void)?)
    {
        var param = [String:Any]()
        param["projectId"] = model.projectId  //编辑的时候
        self.post(url: kVCDelProjectExpURL, param: param, MBProgressHUD: true, success: { (resp) in
            MBProgressHUD.show(info: "删除成功")
            if finish != nil
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    finish!()
                }
                
            }
        }, noData: nil, failure: nil)
    }
}
