//
//  ZJVCHomeModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/12.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的简历的model

import UIKit

class ZJVCHomeModel: NSObject
{
    @objc var resumeinfo:ZJVCResumeInfoModel?
    @objc var experienceEducationList:[ZJVCExperienceEducationModel]?
    @objc var experiencePracticeList:[ZJVCExperiencePracticeModel]?
    @objc var experienceProjectList:[ZJVCExperienceProjectModel]?
    @objc var experienceworkList:[ZJVCExperienceWorkModel]?
    
//    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
//        return ["experienceEducationList":"ZJVCExperienceEducationModel",
//                "experiencePracticeList":"ZJVCExperiencePracticeModel",
//                "experienceProjectList":"ZJVCExperienceProjectModel",
//                "experienceworkList":"ZJVCExperienceWorkModel"]
//    }
    
    override func mj_keyValuesDidFinishConvertingToObject() {
        self.experienceEducationList = ZJVCExperienceEducationModel.mj_objectArray(withKeyValuesArray: self.experienceEducationList).copy() as? [ZJVCExperienceEducationModel]
        self.experiencePracticeList = ZJVCExperiencePracticeModel.mj_objectArray(withKeyValuesArray: self.experiencePracticeList).copy() as? [ZJVCExperiencePracticeModel]
        self.experienceProjectList = ZJVCExperienceProjectModel.mj_objectArray(withKeyValuesArray: self.experienceProjectList).copy() as? [ZJVCExperienceProjectModel]
        self.experienceworkList = ZJVCExperienceWorkModel.mj_objectArray(withKeyValuesArray: self.experienceworkList).copy() as? [ZJVCExperienceWorkModel]

    }
}
