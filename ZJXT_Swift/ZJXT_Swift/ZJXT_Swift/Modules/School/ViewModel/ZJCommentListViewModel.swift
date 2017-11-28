//
//  ZJCommentListViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCommentListViewModel: BaseViewModel
{
    fileprivate var dataArray = [ZJCircleCommentSubModel]()
    fileprivate var model = ZJCircleCommentModel()
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    func requestList(commentId:String,page:Int,finish:((ZJCircleCommentModel,Bool)->Void)?)
    {
        var param = [String:Any]()
        param["commentId"] = commentId
        param["pageNumber"] = page
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kCircleCommentSubListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.dataArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValues = resp?["entity"].dictionaryObject
                
                self?.model = ZJCircleCommentModel.mj_object(withKeyValues: keyValues)
                self?.dataArray = (self?.dataArray)! + (self?.model.circleCommentSubList)!
                self?.model.circleCommentSubList = self?.dataArray
                
                finish!((self?.model)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.model.circleCommentSubList = [ZJCircleCommentSubModel]()
                    
                    if finish != nil
                    {
                        finish!(self.model,false)
                    }
                }
                else
                {
                    finish!(self.model,true)
                }
                
        }, failure: nil)
    }
}
