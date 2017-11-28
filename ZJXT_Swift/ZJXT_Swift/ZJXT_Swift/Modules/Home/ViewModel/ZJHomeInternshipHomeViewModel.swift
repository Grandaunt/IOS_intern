//
//  ZJHomeInternshipHomeViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeInternshipHomeViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJInternshipJobModel]()
    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    func requestList(page:Int,finish:(([ZJInternshipJobModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["studentId"] = UserInfo.shard.userId
        param["postType"] = 1 //岗位类型：1：实习岗位 2：正式岗位
        param["pageNumber"] = page
        
        self.post(url: kISRecommendListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJInternshipJobModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJInternshipJobModel]
                
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
