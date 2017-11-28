//
//  ZJMyWeeklyJournalModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyWeeklyJournalModel: NSObject {

    @objc var weekReportId:String?
    @objc var practiceId:String?
    @objc var weekReportTime:String?   //周报发布时间
    @objc var weekpost:String?     //实习工作内容
    @objc var weekReportExperience:String?   //收获和体会
    @objc var nextWeekPlan:String?          //下周计划
    @objc var weekReportAddress:String?      //动态发布位置 经纬度 ，分割
    @objc var weekReportAddressText:String?
    @objc var mondayTime:String?   //周一时间
    @objc var sundayTime:String?          //周日时间
    @objc var mondayContent:String?
    @objc var tuesdayContent:String?
    @objc var wednesdayContent:String?
    @objc var thursdayContent:String?
    @objc var fridayContent:String?

    @objc var weekReportBackList:[ZJMyWeeklyJournalBackModel]?   //回复的信息
    
    override func mj_keyValuesDidFinishConvertingToObject() {
        self.weekReportBackList = ZJMyWeeklyJournalBackModel.mj_objectArray(withKeyValuesArray: self.weekReportBackList).copy() as? [ZJMyWeeklyJournalBackModel]
    }
}
