//
//  ZJApplyCompanyInfo.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJApplyCompanyInfo: NSObject
{
    @objc var companyId:String?
    @objc var companyName:String?
    @objc var authenType:String?  //认证类型 0未认证 1学校认证 2平台认证
    @objc var companyDes:String?
    @objc var position:String?    //位置
    @objc var scale:String?       //规模
    @objc var companyAddress:String?
    @objc var companyTel:String?
    @objc var companyIcon:String?
    @objc var companyNick:String?   //企业昵称
    @objc var companyCityId:String?
    @objc var companyProvinceId:String?
    @objc var companyTime:String?   //企业成立时间
    @objc var companyContent:String?  //详情
    @objc var companyContacts:String?  //企业联系人
    @objc var isTrue:String?   //是否可用 1是 0否
    @objc var dictionaryIndstryId:String?   //行业领域id
    @objc var dictionaryCapitalId:String?    //融资阶段id
    @objc var companyImg1:String?            //营业执照照片
    @objc var companyImg2:String?            //组织结构代码证图片
}
