//
//  BaseViewModel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/10.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

let isLoading = "正在加载，请稍等"
let loadingSuccess = "加载成功"
let loadingFailed = "网络连接失败,请稍后再试"

class BaseViewModel: NSObject
{
    func get(url:String,param parameters:Dictionary<String, Any>?,MBProgressHUD isProgressHud:Bool, success:Success,noData:NoData,failure:Failure) -> Void
    {
        var loadingHud:MBProgressHUD?
        if  isProgressHud
        {
            loadingHud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            loadingHud?.mode = MBProgressHUDMode.indeterminate
        }
        
        NetworkRequest.sharedInstance.GET(URL: url, param: parameters, success: { (response) in
            if isProgressHud == true
            {
                loadingHud?.hide(animated: true)
            }
            
            var errorInfo = ""
            switch response!["code"].stringValue
            {
                case "1003":
                    errorInfo = "参数不全"
                case "450":
                    errorInfo = "不可重复提交"
                case "500":
                    if noData != nil
                    {
                        noData!()
                        return
                    }
                case "502":
                    errorInfo = "条件不符，不允许操作"
                case "505":
                    errorInfo = "执行异常"
                default:
                    errorInfo = ""
            }
            
            if errorInfo.count > 0
            {
                MBProgressHUD.show(error: errorInfo)
            }
            else
            {
                if success != nil
                {
                    success!(response)
                }
            }
        }) { (error) in
            log.error(error?.localizedDescription as Any)
            if isProgressHud == true
            {
                loadingHud?.hide(animated: true)
            }
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
            if failure != nil
            {
                failure!(error)
            }
            
        }
    }
    
    func post(url:String,param parameters:[String:Any]?,MBProgressHUD isProgressHud:Bool, success:Success,noData:NoData,failure:Failure) -> Void
    {
        var loadingHud:MBProgressHUD?
        if  isProgressHud
        {
            loadingHud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            loadingHud?.mode = MBProgressHUDMode.indeterminate
        }
        
        NetworkRequest.sharedInstance.POST(URL: url, param: parameters, success: { (response) in
            log.info(response)
            if isProgressHud == true
            {
                loadingHud?.hide(animated: true)
            }
            
            var errorInfo = ""
            switch response!["code"].stringValue
            {
                case "1003":
                    errorInfo = "参数不全"
                case "450":
                    errorInfo = "不可重复提交"
                case "500":
                    if noData != nil
                    {
                        noData!()
                        return
                    }
                case "502":
                    errorInfo = "条件不符，不允许操作"
                case "505":
                    errorInfo = "执行异常"
                case "300":
                    errorInfo = "已申请"
                default:
                    errorInfo = ""
            }
            
            if errorInfo.count > 0
            {
                MBProgressHUD.show(error: errorInfo)
            }
            else
            {
                if success != nil
                {
                    success!(response)
                }
            }
        }) { (error) in
            log.error(error?.localizedDescription as Any)
            if isProgressHud
            {
                loadingHud?.hide(animated: true)
                
            }
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
            
            if failure != nil
            {
                failure!(error)
            }
            
        }
    }
    
    func postImages(url URLString:String,param paramters:Dictionary<String, Any>,picArray:[UIImage],isProgressHud:Bool,commonFileName:String,progress:ProgressCus, success:Success,failure:Failure)
    {
        var loadingHud:MBProgressHUD?
        if  isProgressHud
        {
            loadingHud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            loadingHud?.mode = MBProgressHUDMode.indeterminate
        }
        
        NetworkRequest.sharedInstance.POSTImages(URL: URLString, param: paramters, picArray: picArray, picName:commonFileName, progress: progress, success: { (respondeObject) in
            log.info("返回数据:\(String(describing: respondeObject))")
            loadingHud?.hide(animated: true)
            if success != nil
            {
                success!(respondeObject)
            }
            
        }) { (error) in
            log.error(error?.localizedDescription as Any)
            if isProgressHud == true
            {
                loadingHud?.hide(animated: true)
            }
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
            
            if failure != nil
            {
                failure!(error)
            }
        }
    }
    
    func getJSONStringFromDictionary(dictionary:[String:Any]) -> String
    {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            log.error("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->[String:Any]
    {
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil
        {
            return dict as! [String:Any]
        }
        return [String:Any]()
        
        
    }
}
