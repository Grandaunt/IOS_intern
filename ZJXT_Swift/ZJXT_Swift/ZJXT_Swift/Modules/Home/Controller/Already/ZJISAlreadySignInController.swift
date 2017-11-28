//
//  ZJISAlreadySignInController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//
//  签到界面

import UIKit
import FSCalendar
import MBProgressHUD

class ZJISAlreadySignInController: SecondViewController
{
    var model:ZJUserHasPracticeModel?
    @IBOutlet weak var calendar: FSCalendar!
    
    fileprivate var dataArray = [ZJISAlreadySignModel]()
    
    fileprivate var gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initCalendar()
        self.initData()
    }
    
    fileprivate func initData()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        
        let dayNum = Date.getDaysInMonth(year: Int(year)!, month: Int(month)!)
        
        let startTime = year + "-" + month + "-" + "01"
        let endTime = year + "-" + month + "-" + "\(dayNum)"
        self.requestData(startTime: startTime, endTime: endTime)
    }
    
    fileprivate func requestData(startTime:String,endTime:String)
    {
        var param = [String:Any]()
        param["startDate"] = startTime
        param["endDate"] = endTime
        param["userId"] = UserInfo.shard.userId
        BaseViewModel().post(url: kGetSignInfoURL, param: param, MBProgressHUD: false, success: { (resp) in
            let array = resp?["list"].arrayObject
            self.dataArray = ZJISAlreadySignModel.mj_objectArray(withKeyValuesArray: array) as! [ZJISAlreadySignModel]
            self.calendar.reloadData()
        }, noData: {
            self.dataArray = [ZJISAlreadySignModel]()
            self.calendar.reloadData()
        }, failure: nil)
    }
    
    fileprivate func initCalendar()
    {
        self.calendar.dataSource = self
        self.calendar.delegate = self
        let lineView = self.calendar.value(forKey: "bottomBorder") as? UIView
        lineView?.backgroundColor = UIColor.clear
        
        let line1View = self.calendar.value(forKey: "topBorder") as? UIView
        line1View?.backgroundColor = UIColor.clear
        
    }
    
    //签到按钮点击事件
    @IBAction func signInBtnClicked(_ sender: UIButton)
    {
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["signType"] = 1
        param["practiceId"] = self.model?.userPracticeId
        
        let loadingHud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        loadingHud.mode = MBProgressHUDMode.indeterminate
        
        //此处需要不同的弹窗，所以需要单独请求
        NetworkRequest.sharedInstance.POST(URL: kAddSignURL, param: param, success: { (response) in
            log.info(response)
            loadingHud.hide(animated: true)
            
            if response!["code"].stringValue == "200"
            {
                MBProgressHUD.show(info: "签到成功")
            }
            else
            {
                ZJISAlreadySignInView.show(title: Utils.getAttributeStringWithString("    今日已签到\n明天继续加油哦", lineSpace: 10))

            }
            
        }) { (error) in
            loadingHud.hide(animated: true)
            let nsError = error! as NSError
            if nsError.code == NSURLErrorNotConnectedToInternet
            {
                MBProgressHUD.show(error: "请先连接网络")
                
            }
            else if nsError.code == NSURLErrorTimedOut
            {
                MBProgressHUD.show(error: "网络请求超时")
            }
            else
            {
                MBProgressHUD.show(error: "网络请求错误")
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJISAlreadySignInController:FSCalendarDataSource,FSCalendarDelegate
{
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor?
//    {
//        var color:UIColor?
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        let dateStr = formatter.string(from: date)
//        for model in self.dataArray
//        {
//            let modelDateStr = model.signDateTime
//
//            let fmter = DateFormatter()
//            fmter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//            let modelDate = fmter.date(from: modelDateStr!)
//
//            let modelDateString = formatter.string(from: modelDate!)
//
//            if modelDateString == dateStr
//            {
//                if model.signType == "1"
//                {
//                    color = kTabbarBlueColor
//                }
//                else if model.signType == "2"
//                {
//                    color = UIColor.color(hex: "#ffd663")
//                }
//                else
//                {
//                    color = UIColor.color(hex: "#929292")
//                }
//                break
//            }
//        }
//        return color
//    }
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int
//    {
//        var num = 0
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        let dateStr = formatter.string(from: date)
//
//        for model in self.dataArray
//        {
//            let modelDateStr = model.signDateTime
//            let fmter = DateFormatter()
//            fmter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//            let modelDate = fmter.date(from: modelDateStr!)
//
//            let modelDateString = formatter.string(from: modelDate!)
//
//            if modelDateString == dateStr
//            {
//                num = 1
//                break
//            }
//        }
//        return num
//    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage?
    {
        var img:UIImage?
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let dateStr = formatter.string(from: date)
        for model in self.dataArray
        {
            let modelDateStr = model.date

            let fmter = DateFormatter()
            fmter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            
            var modelDate = fmter.date(from: modelDateStr!)
            
            if modelDate == nil
            {
                fmter.dateFormat = "yyyy-MM-dd"
                modelDate = fmter.date(from: modelDateStr!)
            }

            let modelDateString = formatter.string(from: modelDate!)

            if modelDateString == dateStr
            {
                if model.type == "1"
                {
                    img = UIImage(named:"leave_img")
                }
                else if model.type == "2"
                {
                    img = UIImage(named:"trip_img")
                }
                else
                {
                    img = UIImage(named:"sign_img")
                }
            }
        }
        return img
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        let date = calendar.currentPage
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        
        let dayNum = Date.getDaysInMonth(year: Int(year)!, month: Int(month)!)
        
        let startTime = year + "-" + month + "-" + "01"
        let endTime = year + "-" + month + "-" + "\(dayNum)"
        self.requestData(startTime: startTime, endTime: endTime)
    }
}

