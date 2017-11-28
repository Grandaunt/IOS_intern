//
//  Global.swift
//  RCSD_Swift
//
//  Created by User on 2017/5/11.
//  Copyright © 2017年 runner. All rights reserved.
//

import UIKit
import SnapKit
import MJExtension
import CoreData
import UserNotifications
import MBProgressHUD
import IQKeyboardManager
import IQKeyboardManagerSwift
import XCGLogger
import AlamofireImage
import MJRefresh


//可以用下面方式去声明全局变量，也可以用struct声明static let静态常量

/***************************服务器地址*******************************/

public let kDormainURL = "http://www.kzs1.cn/mainStudentWeb" //本地服务器    --朱良
public let kUploadImageURL = "http://image.tyunfarm.com/Home/SaveImage"    //图片上传服务器
//public let kDormainURL = "http://192.168.0.109/toumai/api/"    //本地服务器 -孙

public let kLoginURL = "\(kDormainURL)/userlogin/testLogin"        //登录
public let kLoginCodeURL = "\(kDormainURL)/userlogin/sendCode.do"        //验证码
public let kEditUserInfoURL = "\(kDormainURL)/userbaseinfo/editUserBaseInfo.do"   //修改用户信息
public let kVCInfoURL = "\(kDormainURL)/practiceInterface/getResumeInfo.do"       //简历信息
public let kVCEditUserInfoURL = "\(kDormainURL)/practiceInterface/addResumeinfo"       //简历信息
public let kVCPracitceListURL = "\(kDormainURL)/practiceInterface/getMyExperiencePractice.do" //实习经历列表
public let kVCEditPracticeExpURL = "\(kDormainURL)/practiceInterface/addExperiencePractice"  //添加编辑实习经历
public let kVCDelPracticeExpURL = "\(kDormainURL)/experiencepractice/delExperiencePractice.do" //删除实习经历

public let kVCWorkListURL = "\(kDormainURL)/practiceInterface/getMyExperiencework.do" //工作经历列表
public let kVCEditWorkExpURL = "\(kDormainURL)/practiceInterface/addExperiencework"  //添加编辑工作经历
public let kVCDelWorkExpURL = "\(kDormainURL)/experiencework/delExperiencework.do" //删除工作经历

public let kVCEduListURL = "\(kDormainURL)/practiceInterface/getMyExperienceEducation.do" //教育经历列表
public let kVCEditEduExpURL = "\(kDormainURL)/practiceInterface/addExperienceEducation"  //添加编辑教育经历
public let kVCDelEduExpURL = "\(kDormainURL)/experienceeducation/delExperienceEducation.do" //删除教育经历

public let kVCProjectListURL = "\(kDormainURL)/practiceInterface/getMyExperienceProject.do" //项目经历列表
public let kVCEditProjectExpURL = "\(kDormainURL)/practiceInterface/addExperienceProject"  //添加编辑项目经历
public let kVCDelProjectExpURL = "\(kDormainURL)/experienceproject/delExperienceProject.do" //删除项目经历

public let kMyApplyListURL = "\(kDormainURL)/practiceInterface/getMyApplyList.do"      //我的申请列表
public let kMyLogListURL = "\(kDormainURL)/practiceInterface/getDayReportList.do"      //我的日志列表
public let kMyWeekListURL = "\(kDormainURL)/practiceInterface/getWeekReportList.do"      //我的周报列表
public let kMyQuestionListURL = "\(kDormainURL)/practiceInterface/getQuestionInfoList.do"      //我的问答列表
public let kAnswerQuestionURL = "\(kDormainURL)/practiceInterface/addQuestionAnswer"                //追加问答
public let kMyBusinessTripListURL = "\(kDormainURL)/practiceInterface/getTravelInfoList.do"       //出差列表
public let kMyEventListURL = "\(kDormainURL)/practiceInterface/getLeaveInfoList.do"       //请假列表
public let kMyCircelListURL = "\(kDormainURL)/circle/getMyCircleList.do"       //我的圈子列表
public let kDelMyCircleURL = "\(kDormainURL)/circle/delCircle.do"              //删除我的圈子
public let kLearnHomeCategoryListURL = "\(kDormainURL)/coursecategory/loadCourseCategoryList.do"  //在线学习首页分类
public let kLearnHomeHotListURL = "\(kDormainURL)/course/getHotCourseList"  //在线学习首页热门课程
public let kLearnHomeRecommendListURL = "\(kDormainURL)/course/getRecommendCourseList"  //在线学习首页推荐课程
public let kLearnCategoryCourseListURL = "\(kDormainURL)/course/getCourseList.do"   //获取不同分类的课程列表
public let kLearnGetAllCourseURL = "\(kDormainURL)/course/getCourseTypeAndCourse"   //获取所有分类
public let kLearnCourseInfoURL = "\(kDormainURL)/course/getCourseInfo.do"           //课程详情数据
public let kLearnSearchURL = "\(kDormainURL)/course/getCourseByName.do"    //搜索在线学习
public let kCircleHomeListURL = "\(kDormainURL)/circle/loadCircleList.do"           //圈子首页数据
public let kAddCircleURL = "\(kDormainURL)/circle/addCircle.do"           //圈子首页数据
public let kAllTagListURL = "\(kDormainURL)/tag/loadTagList"              //获取所有的标签
public let kCircleInfoURL = "\(kDormainURL)/circle/getCircleInfoById.do"      //圈子详情
public let kCircleCommentListURL = "\(kDormainURL)/circle/getCommentListByCircleId.do"  //圈子主评论列表
public let kCircleCommentSubListURL = "\(kDormainURL)/circle/getSubCommentListByCommentId.do"  //圈子子评论列表
public let kCircleThumListURL = "\(kDormainURL)/circle/getPraiseListByCircleId.do"  //圈子点赞列表
public let kCircleApplyListURL = "\(kDormainURL)/circle/getCircleApplyList.do"  //圈子报名列表
public let kCircleThumURL = "\(kDormainURL)/circle/addCirclePraise.do"   //点赞或者取消点赞
public let kAddCircleCommentURL = "\(kDormainURL)/circle/addCircleComment.do"   //圈子评论
public let kAddCircelCommentSubURL = "\(kDormainURL)/circle/addCircleCommentSub.do"  //对主评论进行评论
public let kAddCircleCommentThumURL = "\(kDormainURL)/circle/addCircleCommentPraise.do"  //对主评论进行点赞
public let kCircleApplyURL = "\(kDormainURL)/circle/addCircleApply.do"  //圈子申请

public let kHomeListURL = "\(kDormainURL)/circle/getNoticeList.do"      //首页列表数据
public let kHomeTextURL = "\(kDormainURL)/rollingnotice/getRollNoticeListByUserId.do"      //首页滚动数据

public let kISRecommendListURL = "\(kDormainURL)/practiceInterface/getRecommendPostAndCompanyList.do"  //申请实习的推荐实习列表
public let kJobApplyURL = "\(kDormainURL)/practiceInterface/addCompanyPracticeApply"   //全职申请
public let kApplyPlanURL = "\(kDormainURL)/practiceInterface/getPracticeByStudentId.do"  //当前学生的实习计划
public let kBaseListURL = "\(kDormainURL)/practiceInterface/getBaseAndPostList.do"      //基地实习的基地列表
public let kEnListURL = "\(kDormainURL)/practiceInterface/getPostAndCompanyPassList.do"      //自主实习的企业列表

public let kGetAllCitysURL = "\(kDormainURL)/recruit/getProvienceAndCity"     //获取所有城市
public let kGetTeacherURL = "\(kDormainURL)/practiceInterface/getTeacherListByPlanId.do"  //申请实习获取教师列表
public let kAddISApllyURL = "\(kDormainURL)/practiceInterface/addUserPractice"            //添加实习申请

public let kGetPraticeInfoURL = "\(kDormainURL)/practiceInterface/getUserPracticeByUserId.do" //根据userId获取实习情况

public let kGetSignInfoURL = "\(kDormainURL)/practiceInterface/getSignAndLeaveInfoList.do"   //获取签到界面的信息
public let kAddSignURL = "\(kDormainURL)/practiceInterface/addSigninfo"  //添加签到信息
public let kAddJournalURL = "\(kDormainURL)/practiceInterface/addDayReportinfo"  //添加日志信息
public let kAddWeeklyURL = "\(kDormainURL)/practiceInterface/addWeekReportInfo"   //添加周报
public let kAddLeaveURL = "\(kDormainURL)/practiceInterface/addLeaveInfo"         //添加请假
public let kAddTripURL = "\(kDormainURL)/practiceInterface/addTravelInfo"         //添加出差
public let kAddQuestionURL = "\(kDormainURL)/practiceInterface/addQuestionInfo"   //添加问题

public let kGetDimissionURL = "\(kDormainURL)/practiceInterface/transferPractice.do"  //获取转岗信息

public let kGetRecruitListURL = "\(kDormainURL)/practiceInterface/getRecommendPostAndCompanyList.do" //招聘主页列表
public let kFileterRecruitListURL = "\(kDormainURL)/practiceInterface/selectPostAndCompany.do" //招聘主页的筛选

public let kGetEduAndWorkURL = "\(kDormainURL)/recruit/eductionAndWork"   //获取筛选的学历和工作经验
public let kGetCapAndIndURL = "\(kDormainURL)/recruit/capitalAndIndstry"   //获取筛选的融资和类型


/****************************颜色定义***************************/
public let  kCellLineColor    = UIColor.color(hex: "#F5F5F8")      //cell的下划线颜色
public let  kNavColor         = UIColor.white                      //导航栏颜色
public let  kNavLineColor     = UIColor.color(hex: "#F94918")      //导航栏下面的线的颜色
public let  kBackgroundColor  = UIColor.color(hex: "#EFEFF4")      //界面颜
public let  kGrayTextColor    = UIColor.color(hex: "#818181")      //灰色字体
public let  kTabbarGrayColor  = UIColor.color(hex: "#929292")      //tabbar的灰色字体
public let  kTabbarBlueColor  = UIColor.color(hex: "#40AFFF")      //tabbar的蓝色字体


public let kLongButtonTextFont:CGFloat = 17

/****************************屏幕尺寸***************************/
public let kScreenViewWidth = UIScreen.main.bounds.size.width
public let kScreenViewHeight = UIScreen.main.bounds.size.height
public let kTableViewFrame = CGRect(x: 0, y: 0, width: kScreenViewWidth, height: kScreenViewHeight)

func scaleWidth(width:CGFloat)->CGFloat{ return ((width)/(320.0))*kScreenViewWidth}
func scaleCellHeight(height:CGFloat)->CGFloat{ return ((height)/(320.0))*kScreenViewWidth}
func scaleHeight(height:CGFloat) ->CGFloat { return ((height)/(480.0))*kScreenViewHeight }
func multiplieWidth(width:CGFloat) ->CGFloat{ return width/320  }

//重载字典的+=操作符
func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

/****************************控件高度***************************/
public let kStatusHeight:CGFloat = 20;
public let kNavigationBarHeight:CGFloat = 44;
public let kTabBarHeight:CGFloat = 49;

public let kHomeEdgeSpace:CGFloat = 10;   //主页两边的间隔

public let kJumpControllerTime:CGFloat = 2.0

public let kPageNum = 10

/****************************友盟相关***************************/

public let  USHARE_APPKEY = "59a7c19a75ca351ea5000f3a"
public let  QQAppID = "1106385498"
public let  QQAppKey = "dgF1HAhAEsUs1nwf"
public let  WXAppKey = "wx26addcee7bcbbb02"
public let  WXAppSecret = "4a3bfba2c6097faaedf7fcef837c5581"
public let  SinaAppKey = "257733286"
public let  SinaAppSecret = "871a1ed332466744516f0e4d61ff98e3"
public let  ZFBAppID = "2017072707919444"
public let  ZFBSellerID = "2088421685345071"  //支付宝商户账号
public let  WXBuID = "1482336922"         //微信商户id

public let kURLTypeApp = "app"                //支付宝返回本应用
public let kAlipayRetSucceed = 9000           //支付宝支付成功返回结果

public let kKDNiaoBuId = "1289711"            //快递鸟的商户id
public let kKDNiaoAppKey = "3cc9c94a-5d16-41b9-ab1d-6168e4d8d64a"                 //快递鸟的appkey



/****************************极光相关***************************/

public let  channel = "AppStore"
public let  JPushAppKey = "0115f75737a330e794df4d89"

public let kAppStoreId = "1264346377"  //获取appstore的版本号所用
public let kAppStoreURLStr = "itms-apps://itunes.apple.com/cn/app/%E4%BA%BA%E6%89%8D%E5%B1%B1%E4%B8%9C/id1264346377?mt=8"        //打开appstore的url
public let kScoreAppStoreURL = "itms-apps://itunes.apple.com/app/id1264346377"


public let kModalDuration:CGFloat = 0.3   //模特切换的动画时间

public let kUUID = UIDevice.current.identifierForVendor?.uuidString
let SharedAppDelegate = UIApplication.shared.delegate as! AppDelegate



/***************************占位图*******************************/

public let kUserLogoPlaceHolder = UIImage(named:"user_log_placeHolder")  //用户头像占位图

/***************************保存路径*******************************/
public let kCitysPath:String? = {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    let filePath = (path! as NSString).appendingPathComponent("citys.plist")
    return filePath
}()




/***************************配置XCGLogger*******************************/
let log:XCGLogger = {
    let log = XCGLogger.default
    #if DEBUG
        
        //用系统的标准的ASL输出日志,即用NSLog进行输出，会向ASL写log，同时向Xcode的console(控制台)写log，而且同时会出现在Console.app中（Mac自带软件，用NSLog打出的log在其中全部可见）,数据较慢
        //        log.remove(destinationWithIdentifier: XCGLogger.Constants.baseConsoleDestinationIdentifier)
        //        log.add(destination: AppleSystemLogDestination(identifier: XCGLogger.Constants.systemLogDestinationIdentifier))
        //        log.logAppDetails()  //打印app的详情
        
        //仅仅向Xcode console进行输出，速度较快，debug以上的日志级别才在控制台输出，不输出到文件
        log.setup(level: .debug, showLogIdentifier: false, showFunctionName: true, showThreadName: false, showLevel: false, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel:nil)
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "hh:mm:ss"
        dataFormatter.locale = Locale.current
        log.dateFormatter = dataFormatter
    #else
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let logPath:URL = urls[urls.endIndex - 1]
        
        //level:设置什么级别以上的log可以在控制台输出。verbose<debug<info<warning<error<severe<none,级别原来越大，级别越小输出越详细
        //fileLevel:设置什么级别以上的log可以输出到文件中。
        //注意输出的本地文件每次程序启动就会被重新覆盖
        log.setup(level: .none, showLogIdentifier: true, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: logPath, fileLevel: .error)
        //默认log的输出是在当前线程中，发布模式下改为新开辟线程
        if let consoleLog = log.destination(withIdentifier:XCGLogger.Constants.baseConsoleDestinationIdentifier) as? ConsoleDestination {
            consoleLog.logQueue = XCGLogger.logQueue
        }
    #endif
    
    //Xcode8以后不能用XcodeColors插件，只能用emoji
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: " 💢💢 ", postfix: "", to: .verbose)
    emojiLogFormatter.apply(prefix: " 🔹🔹 ", postfix: "", to: .debug)
    emojiLogFormatter.apply(prefix: " ℹ️ℹ️ ", postfix: "", to: .info)
    emojiLogFormatter.apply(prefix: " ⚠️⚠️ ", postfix: "", to: .warning)
    emojiLogFormatter.apply(prefix: " ❌❌ ", postfix: "", to: .error)
    emojiLogFormatter.apply(prefix: " 💣💣 ", postfix: "", to: .severe)
    log.formatters = [emojiLogFormatter]
    
    return log
}()

