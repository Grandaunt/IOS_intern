//
//  ZJVCResumeInfoModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//
//  简历里的基本信息

import UIKit

class ZJVCResumeInfoModel: NSObject
{
    @objc var resumeId:String?
    @objc var userId:String?
    @objc var userName:String?
    @objc var resumeMale:String?  //性别 1男0女
    @objc var resumeTrade:String? //行业方向
    @objc var companyId:String?   //公司id
    @objc var companyName:String?  //公司名
    @objc var resumepost:String?   //当前职位
    @objc var resumeCityID:String?  //工作地区id
    @objc var resumeAddress:String?  //工作地址
    @objc var resumeTel:String?      //联系方式
    @objc var resumeEmile:String?    //邮箱
    @objc var resumeUserIcon:String?  //头像
    @objc var resumeTime:String?      //更新时间
    @objc var userStatus:String?      //状态 0在校 2毕业
    @objc var resumeSelfDes:String?  //自我介绍
}
