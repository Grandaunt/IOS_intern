//
//  ZJMyApplyHomeModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyHomeModel: NSObject
{
    @objc var companyApplyId:String?  //申请id
    @objc var userId:String?  //用户id
    @objc var postId:String?  //职位id
    @objc var applyTime:String?  //申请时间
    @objc var applyStatus:String?  //申请状态 1：未处理；2：已通知面试；3：已确认通过；4：已失效
    @objc var checker:String?  //审核人ID
    @objc var checkTime:String?  //审核时间
    @objc var checkDes:String?  //审核意见
    @objc var companyInfo:ZJApplyCompanyInfo?  //企业信息
    @objc var companyPracticePost:ZJCompanyPracticePost?  //申请id
    @objc var applyType:String?  //1:实习申请；2：全职申请
}
