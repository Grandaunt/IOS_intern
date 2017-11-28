//
//  ZJLearnAllClassifyViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnAllClassifyViewModel: BaseViewModel
{
    func getAllCourse(finish:(([ZJLearnHomeClassModel])->Void)?)
    {
        self.post(url: kLearnGetAllCourseURL, param: nil, MBProgressHUD: true, success: {(resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJLearnHomeClassModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJLearnHomeClassModel]
                finish!(array)
            }
        }, noData: {
            
        }, failure: nil)
    }
}
