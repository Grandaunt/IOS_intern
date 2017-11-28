//
//  ZJCompanyPracticePost.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//
//  企业岗位

import UIKit

class ZJCompanyPracticePost: NSObject
{
    @objc var postId:String?
    @objc var companyId:String?
    @objc var postName:String?
    @objc var postNum:String?
    @objc var postDes:String?
    @objc var postStartTime:String? //发布时间 接收简历的开始时间
    @objc var postEndTime:String?   //发布时间 接收简历的开始时间
    @objc var postType:String?      //岗位类型 1：实习岗位；2：正式岗位 预留
    @objc var postLabel:String?     //岗位标签 每个最多10字，最多10个标签 “，”分割
    @objc var postPoints:String?    //岗位亮点
    @objc var postSpecialDes:String?   //岗位特殊说明
    @objc var postMoney:String?        //薪酬范围
    @objc var practiceStartTime:String?  //实习开始时间
    @objc var practiceEndTime:String?
    @objc var position:String?           //工作地
    @objc var intentionTrade:String?     //意向专业 一对多
    @objc var postSendNumber:String?     //发布量
    @objc var postClick:String?          //点击量
    @objc var isTrue:String?
    @objc var publisher:String?         //发布人（账号）
    @objc var provinceId:String?
    @objc var cityId:String?
    @objc var areaId:String?
    @objc var provinceName:String?
    @objc var cityName:String?
    @objc var areaName:String?
    @objc var schoolId:String?
    @objc var dictionaryWorkId:String?      //工作经验id
    @objc var dictionaryEducationId:String?  //学历要求id
    @objc var companyInfo:ZJApplyCompanyInfo?
    @objc var dictionaryIndstryId:String?
    @objc var dictionaryCapitalId:String?
}
