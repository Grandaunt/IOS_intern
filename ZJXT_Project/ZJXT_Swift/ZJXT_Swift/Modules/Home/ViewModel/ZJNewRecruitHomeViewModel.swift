//
//  ZJNewRecruitHomeViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/26.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJNewRecruitHomeViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJInternshipJobModel]()
    fileprivate var filterDataArray = [ZJInternshipJobModel]()

    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    func requestList(page:Int,finish:(([ZJInternshipJobModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["studentId"] = UserInfo.shard.userId
        param["postType"] = 2 //岗位类型：1：实习岗位 2：正式岗位
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
    
    func requestFilterList(para:(page:Int ,search:String?,postMoney:String?,workId:String?,capitalId:String?,indstryId:String?,educationId:String?,cityCode:String?)?,finish:(([ZJInternshipJobModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["postType"] = 2
        param["pageNumber"] = para?.page
        param["postName"] = para?.search
        param["postMoney"] = para?.postMoney
        param["dictionaryWorkId"] = para?.workId
        param["dictionaryCapitalId"] = para?.capitalId
        param["dictionaryIndstryId"] = para?.indstryId
        param["dictionaryEducationId"] = para?.educationId
        param["position"] = para?.cityCode
        
        
        self.post(url: kFileterRecruitListURL, param: param, MBProgressHUD: false, success: {[weak self] (resp) in
            if para?.page == 1
            {
                self?.filterDataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJInternshipJobModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJInternshipJobModel]
                
                self?.filterDataArray = (self?.filterDataArray)! + array
                
                finish!((self?.filterDataArray)!,false)
            }
        }, noData: {[weak self] in
            
            //如果首页而且没数据证明是该接口无数据
            if para?.page == 1
            {
                self?.filterDataArray.removeAll()
                
                if finish != nil
                {
                    finish!((self?.filterDataArray)!,false)
                }
            }
            else
            {
                finish!((self?.filterDataArray)!,true)
            }
            
        }) { (error) in
            
        }
    }

}
