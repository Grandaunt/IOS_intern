//
//  ZJMyQuestionModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyQuestionModel: NSObject
{
    @objc var questionId:String?
    @objc var questionTitle:String?
    @objc var questionContent:String?
    @objc var questionUserId:String?
    @objc var questionTime:String?
    @objc var isOver:String?   //是否解决 0：否 1：是
    @objc var questionLevel:String?  //问题难度：1：普通 2：重要
    @objc var questionToUserId:String?  //
    @objc var questionType:String?      //问题类型
    @objc var questionAnswerList:[ZJMyQuestionAnswerModel]?
    
    override func mj_keyValuesDidFinishConvertingToObject()
    {
        if self.questionAnswerList != nil
        {
            self.questionAnswerList = ZJMyQuestionAnswerModel.mj_objectArray(withKeyValuesArray: self.questionAnswerList).copy() as? [ZJMyQuestionAnswerModel]
        }
    }

}
