//
//  ZJLearnCourseInfoModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnCourseInfoModel: NSObject
{
    @objc var course:ZJLearnHomeCourseModel?    //课程信息
    @objc var courseVideo:[ZJLearnCourseVideoModel]?  //课程学习列表
    @objc var courseDescription:[ZJLearnCourseDescription]?   //课程详情列表
    
    override func mj_keyValuesDidFinishConvertingToObject()
    {
        if self.courseVideo != nil
        {
            self.courseVideo = ZJLearnCourseVideoModel.mj_objectArray(withKeyValuesArray: self.courseVideo).copy() as? [ZJLearnCourseVideoModel]
        }
        
        if self.courseDescription != nil
        {
            self.courseDescription = ZJLearnCourseDescription.mj_objectArray(withKeyValuesArray: self.courseDescription).copy() as? [ZJLearnCourseDescription]

        }
    }

}
