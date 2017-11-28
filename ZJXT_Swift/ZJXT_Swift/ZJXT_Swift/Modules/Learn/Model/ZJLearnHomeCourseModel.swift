//
//  ZJLearnHomeCourseModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnHomeCourseModel: NSObject
{
    @objc var courseId:String?
    @objc var categoryId:String?
    @objc var categoryName:String?
    @objc var courseName:String?
    @objc var description1:String?      //课程描述
    @objc var visitePresonNum:String?  //访问次数
    @objc var topBackgroundImageUrl:String? //顶部背景图片
    @objc var listViewImageUrl:String?  //列表页示意图
    @objc var createTime:String?
    @objc var comeFrom:String?   //来源
    @objc var testTip:String?  //考试须知
    @objc var isHeat:String?  //1：推荐，0：不是推荐
    @objc var isAdvice:String?  //1：推荐，0：不是推荐
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]!
    {
        return ["description1":"description"]
    }
}
