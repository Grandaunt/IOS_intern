//
//  ZJHomeViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJHomeListModel]()
    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    func requestList(page:Int,finish:(([ZJHomeListModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["pageNumber"] = page
        
        self.post(url: kHomeListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJHomeListModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJHomeListModel]
                
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
    
    func requestText(finish:(([ZJHomeTextModel])->Void)?)
    {
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kHomeTextURL, param: param, MBProgressHUD: false, success: {(resp) in
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJHomeTextModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJHomeTextModel]
                
                finish!(array)
            }
            }, noData: {
                
                let array = [ZJHomeTextModel]()
                finish!(array)
                
        }, failure: nil)
    }
}
