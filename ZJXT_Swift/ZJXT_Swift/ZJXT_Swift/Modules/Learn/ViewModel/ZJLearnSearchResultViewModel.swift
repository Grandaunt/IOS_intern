//
//  ZJLearnSearchResultViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/11/2.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnSearchResultViewModel: BaseViewModel
{
    func getResult(searchStr:String,finish:(([ZJLearnHomeCourseModel])->Void)?)
    {
        self.post(url: kLearnSearchURL, param: ["courseName":searchStr], MBProgressHUD: true, success: {(resp) in
            
            if finish != nil
            {
                let keyValues = resp?["list"].arrayObject
                
                let array = ZJLearnHomeCourseModel.mj_objectArray(withKeyValuesArray: keyValues)
                
                finish!(array as! [ZJLearnHomeCourseModel])
            }
        }, noData: {
            if finish != nil
            {
                finish!([ZJLearnHomeCourseModel]())
            }
            
        }, failure: nil)
    }
}
