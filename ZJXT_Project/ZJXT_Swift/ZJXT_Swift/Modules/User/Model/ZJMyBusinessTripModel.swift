//
//  ZJMyBusinessTripModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/16.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyBusinessTripModel: NSObject {
    @objc var leaveId:String?
    @objc var applyTime:String?
    @objc var leaveDes:String?
    @objc var leaveStartTime:String?
    @objc var leaveEndTime:String?
    @objc var leaveToAddress:String?
    @objc var practiceId:String?
    @objc var checker:String?
    @objc var checkTime:String?
    @objc var checkStatus:String? //审核状态 1：待审核 2：请假批准 3：请假驳回 4：主动
    @objc var checkDes:String?
    @objc var leaveType:String?   //1 请假 2出差
    @objc var userTel:String?
}
