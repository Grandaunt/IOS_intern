//
//  ZJCitysData.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/26.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
private let path:String? = {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    //    path?.append("/user.data")
    let filePath = (path! as NSString).appendingPathComponent("citys.data")
    return filePath
}()

class ZJCitysData: NSObject
{
    static var shard = { () -> ZJCitysData in 
        let share = ZJCitysData.init()
        let citys = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as? [ZJCityModel]
        share.citys = citys
        return share
    }()
    
    var citys:[ZJCityModel]?
    
    override init()
    {
        super.init()
    }
    
    class func save(citys:[ZJCityModel])
    {
        NSKeyedArchiver.archiveRootObject(citys, toFile: path!)
        ZJCitysData.shard.citys = citys
    }
}
