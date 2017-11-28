//
//  ZJLearnHomeViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnHomeViewModel: BaseViewModel
{
    //请求首页分类，只需要第一页
    func requestCategoryList(finish:(([ZJLearnHomeClassModel])->Void)?)
    {
        var param = [String:Any]()
        param["pageNumber"] = 1
        
        self.post(url: kLearnHomeCategoryListURL, param: param, MBProgressHUD: true, success: {(resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJLearnHomeClassModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJLearnHomeClassModel]
                
                
                finish!(array)
            }
            }, noData: {
                
        }, failure: nil)
    }
    
    //请求首页热门课程
    func requestHotList(finish:(([ZJLearnHomeCourseModel])->Void)?)
    {
        self.post(url: kLearnHomeHotListURL, param: nil, MBProgressHUD: true, success: {(resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJLearnHomeCourseModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJLearnHomeCourseModel]
                
                
                finish!(array)
            }
        }, noData: {
            
        }, failure: nil)
    }
    
    //请求首页推荐课程
    func requestRecommendList(finish:(([ZJLearnHomeCourseModel])->Void)?)
    {
        self.post(url: kLearnHomeRecommendListURL, param: nil, MBProgressHUD: true, success: {(resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJLearnHomeCourseModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJLearnHomeCourseModel]
                
                
                finish!(array)
            }
        }, noData: {
            
        }, failure: nil)
    }
}
