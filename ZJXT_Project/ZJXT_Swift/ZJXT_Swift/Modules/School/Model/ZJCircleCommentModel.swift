//
//  ZJCircleCommentModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//
//  主评论

import UIKit

class ZJCircleCommentModel: NSObject
{
    @objc var circleCommentId:String?
    @objc var circleId:String?
    @objc var userId:String?
    @objc var comment:String?
    @objc var commentDate:String?
    @objc var commentNumber:String?  //子评论数量
    @objc var praiseNumber:String?    //评论点赞数目
    @objc var firstSubCommentName:String?  //第一个评论的人名称
    @objc var isPraise:String?
    @objc var trueName:String?
    @objc var nickName:String?
    @objc var logo:String?
    
    @objc var circleCommentSubList:[ZJCircleCommentSubModel]?
    
    override func mj_keyValuesDidFinishConvertingToObject() {
        
        if self.circleCommentSubList != nil
        {
            self.circleCommentSubList = ZJCircleCommentSubModel.mj_objectArray(withKeyValuesArray: self.circleCommentSubList).copy() as? [ZJCircleCommentSubModel]

        }
        else
        {
            self.circleCommentSubList = [ZJCircleCommentSubModel]()
        }
    }

}
