//
//  ZJVCExperienceEducationModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//
//  教育经历

import UIKit

class ZJVCExperienceEducationModel: NSObject
{
    @objc var educationId:String?
    @objc var userId:String?
    @objc var schoolId:String?
    @objc var schoolName:String?   //学校名称
    @objc var educationMajor:String?   //专业
    @objc var educationLevel:String?   //学历
    @objc var educationStartTime:String?//开始时间
    @objc var educationEndTime:String?//结束时间
    @objc var educationDes:String?//经历描述
    @objc var isTrue:String?//是否认证
}
