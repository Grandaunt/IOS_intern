//
//  ZJLearnClassifyInfoViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/17.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnClassifyInfoViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJLearnHomeCourseModel]()
    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    func requestList(categoryId:String,page:Int,finish:(([ZJLearnHomeCourseModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["CategoryId"] = categoryId
        param["pageNumber"] = page
        
        self.post(url: kLearnCategoryCourseListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJLearnHomeCourseModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJLearnHomeCourseModel]
                
                self?.dataArray = (self?.dataArray)! + array
                
                finish!((self?.dataArray)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.dataArray.removeAll()
                    
                    if finish != nil
                    {
                        finish!(self.dataArray,false)
                    }
                }
                else
                {
                    finish!(self.dataArray,true)
                }
                
        }, failure: nil)
    }
}
