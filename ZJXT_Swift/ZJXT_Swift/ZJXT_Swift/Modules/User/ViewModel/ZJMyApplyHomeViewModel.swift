//
//  ZJMyApplyHomeViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyHomeViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJMyApplyHomeModel]()
    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    func requestList(page:Int,finish:(([ZJMyApplyHomeModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["StudentId"] = UserInfo.shard.userId
        param["pageNumber"] = page
        
        self.post(url: kMyApplyListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJMyApplyHomeModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJMyApplyHomeModel]
                
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
