//
//  ZJCircleModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//
//  圈子

import UIKit

class ZJCircleModel: NSObject
{
    @objc var circleId:String?
    @objc var userId:String?
    @objc var contentText:String?   //内容
    @objc var categoryId:String?   // 1心情 2约吧
    @objc var tag:String?    //标签
    @objc var imageUrl1:String?
    @objc var imageUrl2:String?
    @objc var imageUrl3:String?
    @objc var imageUrl4:String?
    @objc var imageUrl5:String?
    @objc var imageUrl6:String?
    @objc var imageUrl7:String?
    @objc var imageUrl8:String?
    @objc var imageUrl9:String?
    @objc var imageNum:String?
    @objc var addressXY:String?   //地址经纬度
    @objc var addressText:String?   //地址
    @objc var isOfficial:String?    //是否官方
    @objc var isCertificate:String?  //是否认证
    @objc var isRealName:String?     //是否实名约吧
    @objc var createTime:String?
//    @objc var description:String?
    @objc var activityTime:String?
    @objc var activityAddress:String?
    @objc var praiseNumber:String?
    @objc var commentNumber:String?
    @objc var applyNumber:String?
    @objc var trueName:String?
    @objc var nickName:String?
    @objc var logo:String?
    @objc var isPraise:String?   //是否点赞，字符串 YES是 NO否
    @objc var isApply:String?    //是否参加该召集令，字符串 YES是 NO否
}
