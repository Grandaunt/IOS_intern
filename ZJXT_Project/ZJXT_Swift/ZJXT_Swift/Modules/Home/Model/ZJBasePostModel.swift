//
//  ZJBasePostModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//
//  基地的岗位

import UIKit

class ZJBasePostModel: NSObject
{
    @objc var postId:String?
    @objc var baseId:String?
    @objc var postName:String?
    @objc var postNum:String?
    @objc var postPay:String?
    @objc var postOrder:String?
    @objc var postDes:String?    //职位要求
    @objc var postDuty:String?  //职位职责
    @objc var welfare:String?    //实习福利
    @objc var isTrue:String?    //是否可用
}
