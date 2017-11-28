//
//  ZJLearnHomeClassModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//
//  在线学习首页的分类model

import UIKit

class ZJLearnHomeClassModel: NSObject
{
    @objc var courseCategoryId:String?
    @objc var categoryName:String?
    @objc var createTime:String?
    @objc var listIcon:String?
    @objc var img:UIImage?
    @objc var courseList:[ZJLearnHomeCourseModel]?
    
    
    //这样转换会转成oc的NSA'r'ra'y
//    override static func mj_objectClassInArray() -> [AnyHashable : Any]!
//    {
//        return ["courseList":"ZJLearnHomeCourseModel"]
//    }

    
    override func mj_keyValuesDidFinishConvertingToObject()
    {
        if self.courseList != nil
        {
            self.courseList = ZJLearnHomeCourseModel.mj_objectArray(withKeyValuesArray: self.courseList).copy() as? [ZJLearnHomeCourseModel]

        }
    }
}
