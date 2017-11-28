//
//  ZJLearnCourseInfoViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnCourseInfoViewModel: BaseViewModel
{
    //请求首页热门课程
    func requestInfo(carouseId:String,finish:((ZJLearnCourseInfoModel)->Void)?)
    {
        self.post(url: kLearnCourseInfoURL, param: ["courseId":carouseId], MBProgressHUD: true, success: {(resp) in
            
            if finish != nil
            {
                let keyValues = resp?["entity"].dictionaryObject
                
                let model = ZJLearnCourseInfoModel.mj_object(withKeyValues: keyValues)
                
                finish!(model!)
            }
         }, noData: {
            
        }, failure: nil)
    }
}
