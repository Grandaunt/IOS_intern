//
//  UserInfo.swift
//  RCSD_Swift
//
//  Created by hxt on 2017/5/12.
//  Copyright © 2017年 runner. All rights reserved.
//

import SwiftyJSON

private let ACOUNT = "com.runer.zjxt"

private let path:String? = {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
//    path?.append("/user.data")
    let filePath = (path! as NSString).appendingPathComponent("user.data")
    return filePath
}()

final class UserInfo: NSObject,NSCoding
{
    static var shard = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as? UserInfo ?? UserInfo.init()
    
    var userId:String?  //用户id
    var trueName:String?  //真实姓名
    var male:String?  //性别 1男0女
    var nickName:String?  //昵称
    var schoolId:String?  //学校id
    var intoSchool:String?  //入学年份
    var majorId:String?  //专业id
    var icon:String?  //暂时不用
    var departmentId:String?  //院系id
    var teacher:String?  //所属教师
    var groupId:String?  //所属组别
    var gradesId:String?  //班级id
    var leftSchool:String?  //离校时间
    var userBirth:String?  //生日
    var userIDCard:String?  //身份证号
    var userCode:String?  //学号
    var logo:String?  //头像
    var schoolName:String?  //学校名
    var majorName:String?  //专业名
    var departmentName:String?  //院系名
    var gradeName:String?  //班级名
    var isHasUserPractice:String?  //是否有实习 YES是NO否Auditing审核中
    var companyName:String?

    override init()
    {
        super.init()
    }
    
    init(dict:[String:JSON])
    {
        self.userId = dict["userId"]?.stringValue
        self.trueName = dict["trueName"]?.stringValue
        self.male = dict["male"]?.stringValue
        self.nickName = dict["nickName"]?.stringValue
        self.schoolId = dict["schoolId"]?.stringValue
        self.intoSchool = dict["intoSchool"]?.stringValue
        self.icon = dict["icon"]?.stringValue
        self.majorId = dict["majorId"]?.stringValue
        self.departmentId = dict["departmentId"]?.stringValue
        self.groupId = dict["groupId"]?.stringValue
        self.gradesId = dict["gradesId"]?.stringValue
        self.leftSchool = dict["leftSchool"]?.stringValue
        self.userBirth = dict["userBirth"]?.stringValue
        self.userIDCard = dict["userIDCard"]?.stringValue
        self.userCode = dict["userCode"]?.stringValue
        self.logo = dict["logo"]?.stringValue
        self.schoolName = dict["schoolName"]?.stringValue
        self.majorName = dict["majorName"]?.stringValue
        self.departmentName = dict["departmentName"]?.stringValue
        self.gradeName = dict["gradeName"]?.stringValue
        self.teacher = dict["teacher"]?.stringValue
        self.isHasUserPractice = dict["isHasUserPractice"]?.stringValue
        self.companyName = dict["companyName"]?.stringValue

    }
    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder)
    {
        
        aCoder.encode(self.userId, forKey:"userId")
        aCoder.encode(self.trueName, forKey:"trueName")
        aCoder.encode(self.male, forKey:"male")
        aCoder.encode(self.nickName, forKey:"nickName")
        aCoder.encode(self.schoolId, forKey:"schoolId")
        aCoder.encode(self.intoSchool, forKey:"intoSchool")
        aCoder.encode(self.icon, forKey:"icon")
        aCoder.encode(self.majorId, forKey:"majorId")
        aCoder.encode(self.departmentId, forKey:"departmentId")
        aCoder.encode(self.groupId, forKey:"groupId")
        aCoder.encode(self.gradesId, forKey:"gradesId")
        aCoder.encode(self.leftSchool, forKey:"leftSchool")
        aCoder.encode(self.userBirth, forKey:"userBirth")
        aCoder.encode(self.userIDCard, forKey:"userIDCard")
        aCoder.encode(self.userCode, forKey:"userCode")
        aCoder.encode(self.logo, forKey:"logo")
        aCoder.encode(self.schoolName, forKey:"schoolName")
        aCoder.encode(self.majorName, forKey:"majorName")
        aCoder.encode(self.departmentName, forKey:"departmentName")
        aCoder.encode(self.gradeName, forKey:"gradeName")
        aCoder.encode(self.teacher, forKey: "teacher")
        aCoder.encode(self.isHasUserPractice, forKey: "isHasUserPractice")
        aCoder.encode(self.companyName, forKey: "companyName")

    }
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder)
    {
        super.init()
        
        self.userId = aDecoder.decodeObject(forKey:"userId") as? String
        self.trueName = aDecoder.decodeObject(forKey:"trueName") as? String
        self.male = aDecoder.decodeObject(forKey:"male") as? String
        self.nickName = aDecoder.decodeObject(forKey:"nickName") as? String
        self.schoolId = aDecoder.decodeObject(forKey:"schoolId") as? String
        self.intoSchool = aDecoder.decodeObject(forKey:"intoSchool") as? String
        self.icon = aDecoder.decodeObject(forKey:"icon") as? String
        self.majorId = aDecoder.decodeObject(forKey:"majorId") as? String
        self.departmentId = aDecoder.decodeObject(forKey:"departmentId") as? String
        self.groupId = aDecoder.decodeObject(forKey:"groupId") as? String
        self.gradesId = aDecoder.decodeObject(forKey:"gradesId") as? String
        self.leftSchool = aDecoder.decodeObject(forKey:"leftSchool") as? String
        self.userBirth = aDecoder.decodeObject(forKey:"userBirth") as? String
        self.userIDCard = aDecoder.decodeObject(forKey:"userIDCard") as? String
        self.userCode = aDecoder.decodeObject(forKey:"userCode") as? String
        self.logo = aDecoder.decodeObject(forKey:"logo") as? String
        self.schoolName = aDecoder.decodeObject(forKey:"schoolName") as? String
        self.majorName = aDecoder.decodeObject(forKey:"majorName") as? String
        self.departmentName = aDecoder.decodeObject(forKey:"departmentName") as? String
        self.gradeName = aDecoder.decodeObject(forKey:"gradeName") as? String
        self.teacher = aDecoder.decodeObject(forKey: "teacher") as? String
        self.isHasUserPractice = aDecoder.decodeObject(forKey: "isHasUserPractice") as? String
        self.companyName = aDecoder.decodeObject(forKey: "companyName") as? String
    }
    
    class func saveUserInfo(user:UserInfo)
    {
        NSKeyedArchiver.archiveRootObject(user, toFile: path!)
        
        UserInfo.shard.userId = user.userId
        UserInfo.shard.trueName = user.trueName
        UserInfo.shard.male = user.male
        UserInfo.shard.nickName = user.nickName
        UserInfo.shard.schoolId = user.schoolId
        UserInfo.shard.intoSchool = user.intoSchool
        UserInfo.shard.icon = user.icon
        UserInfo.shard.majorId = user.majorId
        UserInfo.shard.departmentId = user.departmentId
        UserInfo.shard.groupId = user.groupId
        UserInfo.shard.gradesId = user.gradesId
        UserInfo.shard.leftSchool = user.leftSchool
        UserInfo.shard.userBirth = user.userBirth
        UserInfo.shard.userIDCard = user.userIDCard
        UserInfo.shard.userCode = user.userCode
        UserInfo.shard.logo = user.logo
        UserInfo.shard.schoolName = user.schoolName
        UserInfo.shard.majorName = user.majorName
        UserInfo.shard.departmentName = user.departmentName
        UserInfo.shard.gradeName = user.gradeName
        UserInfo.shard.teacher = user.teacher
        UserInfo.shard.isHasUserPractice = user.isHasUserPractice
        UserInfo.shard.companyName = user.companyName
    }
    
    class func delete() -> Bool
    {
        if !FileManager.default.fileExists(atPath: path!)
        {
            UserInfo.saveUserInfo(user: UserInfo())  //必须把原来的单例的数据清除
            return true
        }
        
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(atPath: path!)
        }catch{
            return false
        }
        
        UserInfo.saveUserInfo(user: UserInfo())  //必须把原来的单例的数据清除
        return true
    }
    
    class func isLogin() -> Bool
    {
        return (UserInfo.shard.userId != nil)
    }
    
//    var userId:String
//    var userLogoStr:String
//    fileprivate var is_makeup:String    //是否完成一次明价出价并获得出局收益：0未完成，1已完成
//    fileprivate var is_dark_learn:String  //是否学习暗价规则：0未学，1已学
//
//    static let instance = UserInfo.init()
//
//    private override init()
//    {
//        let userId = SAMKeychain.password(forService: "userId", account: ACOUNT)
//        self.userId = userId == nil ? "" : userId!
//        let userLogoStr = SAMKeychain.password(forService: "userLogoStr", account: ACOUNT)
//        self.userLogoStr = userLogoStr == nil ? "" :userLogoStr!
//
//        let isMakeUp = SAMKeychain.password(forService: "ismakeup", account: ACOUNT)
//        self.is_makeup = isMakeUp == nil ? "" : isMakeUp!
//
//        let isDarkLearn = SAMKeychain.password(forService: "isdarklearn", account: ACOUNT)
//        self.is_dark_learn = isDarkLearn == nil ? "" : isDarkLearn!
//
//    }
//
//    class func save(userId:String)
//    {
//        if userId.trimAfterCount() > 0
//        {
//            SAMKeychain.setPassword(userId, forService: "userId", account: ACOUNT)
//            UserInfo.instance.userId = userId
//        }
//    }
//
//    class func save(userLogoStr:String)
//    {
//        if userLogoStr.trimAfterCount() > 0
//        {
//            SAMKeychain.setPassword(userLogoStr, forService: "userLogoStr", account: ACOUNT)
//            UserInfo.instance.userLogoStr = userLogoStr
//        }
//    }
//
//    class func save(makeup:String)
//    {
//        if makeup.trimAfterCount() > 0
//        {
//            SAMKeychain.setPassword(makeup, forService: "ismakeup", account: ACOUNT)
//            UserInfo.instance.is_makeup = makeup
//        }
//    }
//
//    class func save(darkLearn:String)
//    {
//        if darkLearn.trimAfterCount() > 0
//        {
//            SAMKeychain.setPassword(darkLearn, forService: "isdarklearn", account: ACOUNT)
//            UserInfo.instance.is_dark_learn = darkLearn
//        }
//    }
//
//    class func delete()
//    {
//        SAMKeychain.deletePassword(forService: "userId", account: ACOUNT)
//        UserInfo.instance.userId = ""
//
//        SAMKeychain.deletePassword(forService: "userLogoStr", account: ACOUNT)
//        UserInfo.instance.userLogoStr = ""
//    }
//
//    //判断是否登录
//    class func isLogined() -> Bool
//    {
//        if UserInfo.instance.userId.trimAfterCount() > 0
//        {
//            return true;
//        }
//        return false
//    }
//
//    class func isDarkLearn() -> Bool
//    {
//        if UserInfo.instance.is_dark_learn == "1"
//        {
//            return true
//        }
//        return false
//    }
//
//    class func isMakeUp() -> Bool
//    {
//        if UserInfo.instance.is_makeup == "1"
//        {
//            return true
//        }
//        return false
//
//    }

}
