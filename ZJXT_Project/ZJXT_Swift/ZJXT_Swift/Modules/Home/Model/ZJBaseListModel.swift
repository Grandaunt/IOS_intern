//
//  ZJBaseListModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//
//  基地

import UIKit

class ZJBaseListModel: NSObject
{
    @objc var baseId:String?
    @objc var baseName:String?
    @objc var companyId:String?
    @objc var companyName:String?
    @objc var baseIcon:String?
    @objc var baseDes:String?
    @objc var schoolId:String?
    @objc var departmentId:String?
    @objc var baselevel:String?  //基地级别1：校级 2：院系级
    @objc var address:String?
    @objc var contact:String?
    @objc var contactPhone:String?
    @objc var basePostList:[ZJBasePostModel]?
    @objc var practicePlan:ZJInternshipPlanModel?
    
    override func mj_keyValuesDidFinishConvertingToObject()
    {
        if self.basePostList != nil
        {
            self.basePostList = ZJBasePostModel.mj_objectArray(withKeyValuesArray: self.basePostList).copy() as? [ZJBasePostModel]
        }
        else
        {
            self.basePostList = [ZJBasePostModel]()
        }
    }

}
