//
//  ZJMyLogModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyLogModel: NSObject
{
    @objc var dayReportId:String?
    @objc var practiceId:String?
    @objc var dayReportTime:String?   //日志发布时间
    @objc var dayReportContent:String?     //实习工作内容
    @objc var dayReportExperience:String?   //收获和体会
    @objc var dayReportDes:String?          //备注
    @objc var dayReportAddress:String?      //动态发布位置 经纬度 ，分割
    @objc var videoPath:String?
    @objc var dayReportAddressText:String?   //动态发布位置
    @objc var dayReportType:String?          //日志内容类型 1：文本；2：语音
    @objc var dayReportBackList:[ZJMyLogBackModel]?   //回复的信息
    
    override func mj_keyValuesDidFinishConvertingToObject() {
        self.dayReportBackList = ZJMyLogBackModel.mj_objectArray(withKeyValuesArray: self.dayReportBackList).copy() as? [ZJMyLogBackModel]
    }
    
}
