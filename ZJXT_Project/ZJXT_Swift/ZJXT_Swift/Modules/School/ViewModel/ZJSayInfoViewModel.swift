//
//  ZJSayInfoViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/19.
//  Copyright © 2017年 runer. All rights reserved.
//
//  心情的详情

import UIKit

class ZJSayInfoViewModel: BaseViewModel
{
    fileprivate var commentArray = [ZJCircleCommentModel]()
    fileprivate var commentSubArray = [ZJCircleCommentSubModel]()
    fileprivate var applyArray = [ZJCircleApplyModel]()
    fileprivate var thumArray = [ZJCirclePraiseModel]()

    //请求圈子详情
    func requestData(circleId:String,finish:((ZJCircleModel)->Void)?)
    {
        var param = [String:Any]()
        param["circleId"] = circleId
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kCircleInfoURL, param: param, MBProgressHUD: true, success: { (resp) in
            
            let dict = resp?["entity"].dictionaryObject
            
            let circleInfoModel = ZJCircleModel.mj_object(withKeyValues: dict)
            
            if finish != nil
            {
                finish!(circleInfoModel!)
            }
            
        }, noData: nil, failure: nil)
    }
    
    
    //bool值是否是上拉无更多数据 true无更多数据，false还有数据
    //请求圈子主评论列表
    func requestCommentList(circleId:String,page:Int,finish:(([ZJCircleCommentModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["circleId"] = circleId
        param["pageNumber"] = page
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kCircleCommentListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.commentArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJCircleCommentModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJCircleCommentModel]
                
                self?.commentArray = (self?.commentArray)! + array
                
                finish!((self?.commentArray)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.commentArray.removeAll()
                    
                    if finish != nil
                    {
                        finish!(self.commentArray,false)
                    }
                }
                else
                {
                    finish!(self.commentArray,true)
                }
                
        }, failure: nil)
    }
    
    //请求圈子子评论列表
    func requestCommentSubList(commentId:String,page:Int,finish:(([ZJCircleCommentSubModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["commentId"] = commentId
        param["pageNumber"] = page
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kCircleCommentSubListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.commentSubArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJCircleCommentSubModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJCircleCommentSubModel]
                
                self?.commentSubArray = (self?.commentSubArray)! + array
                
                finish!((self?.commentSubArray)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.commentSubArray.removeAll()
                    
                    if finish != nil
                    {
                        finish!(self.commentSubArray,false)
                    }
                }
                else
                {
                    finish!(self.commentSubArray,true)
                }
                
        }, failure: nil)
    }
    
    //请求圈子申请列表
    func requestApplyList(circleId:String,page:Int,finish:(([ZJCircleApplyModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["circleId"] = circleId
        param["pageNumber"] = page
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kCircleApplyListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.applyArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJCircleApplyModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJCircleApplyModel]
                
                self?.applyArray = (self?.applyArray)! + array
                
                finish!((self?.applyArray)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.applyArray.removeAll()
                    
                    if finish != nil
                    {
                        finish!(self.applyArray,false)
                    }
                }
                else
                {
                    finish!(self.applyArray,true)
                }
                
        }, failure: nil)
    }
    
    //请求圈子点赞列表
    func requestThumList(circleId:String,page:Int,finish:(([ZJCirclePraiseModel],Bool)->Void)?)
    {
        var param = [String:Any]()
        param["circleId"] = circleId
        param["pageNumber"] = page
        param["userId"] = UserInfo.shard.userId
        
        self.post(url: kCircleThumListURL, param: param, MBProgressHUD: page == 1 ? true : false, success: {[weak self] (resp) in
            
            if page == 1
            {
                self?.thumArray.removeAll()
            }
            
            if finish != nil
            {
                let keyValuesArray = resp?["list"].arrayObject
                
                let array = ZJCirclePraiseModel.mj_objectArray(withKeyValuesArray: keyValuesArray) as! [ZJCirclePraiseModel]
                
                self?.thumArray = (self?.thumArray)! + array
                
                finish!((self?.thumArray)!,false)
            }
            
            
            
            }, noData: {
                
                //如果首页而且没数据证明是该接口无数据
                if page == 1
                {
                    self.thumArray.removeAll()
                    
                    if finish != nil
                    {
                        finish!(self.thumArray,false)
                    }
                }
                else
                {
                    finish!(self.thumArray,true)
                }
                
        }, failure: nil)
    }
}
