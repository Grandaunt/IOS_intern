//
//  ZJInternshipJobModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJInternshipJobModel: NSObject
{
    @objc var postId:String?
    @objc var companyId:String?
    @objc var postName:String?
    @objc var postNum:String?
    @objc var postDes:String?
    @objc var postStartTime:String?  //发布时间
    @objc var postEndTime:String?     //接收简历截止时间
    @objc var postType:String?   //岗位类型：1：实习岗位 2：正式岗位
    @objc var postLabel:String?   //岗位标签
    @objc var postPoints:String?   //岗位亮点
    @objc var postSpecialDes:String?   //特殊说明
    @objc var postMoney:String?   //薪酬
    @objc var practiceStartTime:String?  //实习开始时间
    @objc var practiceEndTime:String?   //实习结束时间
    @objc var position:String?      //工作地
    @objc var intentionTrade:String?     //意向专业 一对多
    @objc var postSendNumber:String?    //发布量
    @objc var postClick:String?        //点击量
    @objc var postInvalidTime:String?   //岗位失效时间
    @objc var isTrue:String?   //是否可用 1：可用 0：不可用
    @objc var publisher:String?
    @objc var provinceId:String?
    @objc var cityId:String?
    @objc var areaId:String?
    @objc var provinceName:String?
    @objc var cityName:String?
    @objc var areaName:String?
    @objc var schoolId:String?
    @objc var dictionaryIndstryId:String?  //行业领域id
    @objc var dictionaryCapitalId:String?   //融资阶段id
    @objc var dictionaryEducationId:String?   //是否可用 1：可用 0：不可用
    @objc var dictionaryWorkId:String?   //是否可用 1：可用 0：不可用

    @objc var companyInfo:ZJInternshipCompanyModel?
    


    
}
