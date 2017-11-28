//
//  ZJVCExperiencePracticeModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//
//  实习经历

import UIKit

class ZJVCExperiencePracticeModel: NSObject
{
    @objc var practiceId:String?
    @objc var userId:String?
    @objc var userPracticeId:String?
    @objc var companyId:String?
    @objc var companyName:String?
    @objc var practicePost:String?    //职位
    @objc var practiceStartTime:String?
    @objc var practiceEndTime:String?
    @objc var practiceDes:String?    //项目描述
    @objc var practiceExperienceType:String?  //实习类型 0未认证 1系统认证
    @objc var isTrue:String?    //是否认证
}
