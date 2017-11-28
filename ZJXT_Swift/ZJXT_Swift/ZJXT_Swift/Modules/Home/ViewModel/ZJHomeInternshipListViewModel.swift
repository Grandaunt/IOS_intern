//
//  ZJHomeInternshipListController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeInternshipListViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJBaseListModel]()
    fileprivate var dataArr = [ZJInternshipJobModel]()
    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    //请求基地列表
    func requestBaseList(page:Int,finish:(([ZJBaseListModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["StudentId"] = UserInfo.shard.userId
        param["pageNumber"] = page
        
        self.post(url: kBaseListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJBaseListModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJBaseListModel]
                
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
    
    func requestEnList(page:Int,finish:(([ZJInternshipJobModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["StudentId"] = UserInfo.shard.userId
        param["pageNumber"] = page
        
        self.post(url: kEnListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJInternshipJobModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJInternshipJobModel]
                
                self?.dataArr = (self?.dataArr)! + array
                
                finish!((self?.dataArr)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.dataArr.removeAll()
                    
                    if finish != nil
                    {
                        finish!(self.dataArr,false)
                    }
                }
                else
                {
                    finish!(self.dataArr,true)
                }
                
        }, failure: nil)
    }
}
