//
//  ZJCityModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCityModel: NSObject,NSCoding
{
    @objc var firstChar:String?
    @objc var CODE:String?
    @objc var cityName:String?
    @objc var parentCode:String?
    @objc var cityLevel:String?
    
    override init()
    {
        super.init()
    }
    
    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder)
    {
        aCoder.encode(self.firstChar, forKey:"firstChar")
        aCoder.encode(self.CODE, forKey:"CODE")
        aCoder.encode(self.cityName, forKey:"cityName")
        aCoder.encode(self.parentCode, forKey:"parentCode")
        aCoder.encode(self.cityLevel, forKey:"cityLevel")

    }
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder)
    {
        super.init()
        self.firstChar = aDecoder.decodeObject(forKey:"firstChar") as? String
        self.CODE = aDecoder.decodeObject(forKey:"CODE") as? String
        self.cityName = aDecoder.decodeObject(forKey:"cityName") as? String
        self.parentCode = aDecoder.decodeObject(forKey:"parentCode") as? String
        self.cityLevel = aDecoder.decodeObject(forKey:"cityLevel") as? String

    }
}
