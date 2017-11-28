//
//  NetworkRequest.swift
//  CX_Project
//
//  Created by User on 2017/7/26.
//  Copyright © 2017年 imagine. All rights reserved.
//
//  用Alamofire时的网络请求封装

import Alamofire
import SwiftyJSON
import UIKit

typealias Success = ((JSON?) -> Void)? //成功的闭包
typealias Failure = ((Error?)->Void)? //失败的闭包
typealias NoData = (()->Void)? //失败的闭包
typealias ProgressCus = ((Progress)->Void)? //上传或下载进度的闭包
typealias Destination = ((URL,URLResponse?)->URL)? //返回url的闭包
typealias DownLoadSuccess = ((URLResponse?, URL)->Void)? //下载成功的闭包

class NetworkRequest: NSObject {
    
    static let sharedInstance:NetworkRequest = {
        let instance = NetworkRequest()
        return instance
    }()
}

extension NetworkRequest
{
    func GET(URL URLString:String,param parameters:Dictionary<String, Any>?,success:Success,failure:Failure)
    {
        Alamofire.request(URLString, method: .get, parameters: parameters).responseJSON { (resp) in
            switch resp.result
            {
                case .success(let value):
                    if success != nil
                    {
                        let json = JSON(value as AnyObject)
                        success!(json)
                    }
                case .failure(let error):
                    if failure != nil
                    {
                        failure!(error)
                    }
            }
        }
    }
        
    func POST(URL URLString:String,param parameters:Dictionary<String, Any>?,success:Success,failure:Failure)
    {
        Alamofire.request(URLString, method: .post, parameters: parameters).responseJSON { (resp) in
            switch resp.result
            {
                case .success(let value):
                    if success != nil
                    {
                        let json = JSON(value as AnyObject)
                        success!(json)
                    }
                case .failure(let error):
                    if failure != nil
                    {
                        failure!(error)
                    }
                }
        }
    }
    
    func POSTOne(URL URLString:String,param parameters:Dictionary<String, Any>?,pic:UIImage,picName:String,progress: ProgressCus,success: Success,failure: Failure)
    {
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            let data = UIImageJPEGRepresentation(pic, 0.5)
            multipartFormData.append(data!, withName: picName, fileName: picName + ".jpg", mimeType: "image/jpeg")
//            multipartFormData.append(data!, withName: picName)
            
            //拼接参数
            if parameters == nil
            {
                return;
            }
            
            for (key,value) in parameters!
            {
                let str = value as? String
                multipartFormData.append((str?.data(using: String.Encoding.utf8))!, withName: key)
            }

        }, to: URLString, method: .post, headers: headers) { (encodingResult) in
            switch encodingResult
            {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            if success != nil
                            {
                                let json = JSON(value as AnyObject)
                                success!(json)
                            }
                        }
                    }
                    if progress != nil
                    {
                        progress!(upload.uploadProgress)
                    }
                case .failure(let encodingError):
                    if failure != nil
                    {
                        failure!(encodingError)
                    }
                }
        }
    }
    
    func POSTImages(URL URLString:String,param parameters:Dictionary<String, Any>?,picArray:[UIImage],picName:String,progress: ProgressCus,success: Success,failure: Failure)
    {
        let headers = ["content-type":"multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            //拼接图片数据流
            if picArray.count == 1
            {
                let img = picArray.first
                let data = UIImageJPEGRepresentation(img!, 0.5)!
                multipartFormData.append(data, withName: picName, fileName: picName + ".jpg", mimeType: "image/jpeg")
            }
            else
            {
                for (i,img) in picArray.enumerated()
                {
                    let data = UIImageJPEGRepresentation(img, 0.5)!
                    multipartFormData.append(data, withName: picName + "\(i)", fileName: picName + "\(i)" + ".jpg", mimeType: "image/jpeg")
                }

            }
            
            //拼接参数
            if parameters == nil
            {
                return;
            }
            
            for (key,value) in parameters!
            {
                let str = value as? String
                multipartFormData.append((str?.data(using: String.Encoding.utf8))!, withName: key)
            }
            
        },
         to: URLString,
         method: .post,
         headers: headers,
         encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                
//                upload.responseString(completionHandler: { (reponse) in
//                    log.info(reponse.result.value)
//
//                })
                
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        if success != nil
                        {
                            let json = JSON(value as AnyObject)
                            success!(json)
                        }
                    }
                }
                if progress != nil
                {
                    progress!(upload.uploadProgress)
                }
            case .failure(let encodingError):
                if failure != nil
                {
                    failure!(encodingError)
                }
            }
        }
        )
    }
    

    //上传数据
    func POSTData(URL URLString:String,param parameters:Dictionary<String, Any>,data:Data,commonFileName:String,progress: ProgressCus,success: Success,failure: Failure)
    {
        let headers = ["content-type":"multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: commonFileName)
            
        },
                         to: URLString,
                         headers: headers,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    if let value = response.result.value as? [String: AnyObject]{
                                        if success != nil
                                        {
                                            let json = JSON(value as AnyObject)
                                            success!(json)
                                        }
                                    }
                                }
                                if progress != nil
                                {
                                    progress!(upload.uploadProgress)
                                }
                            case .failure(let encodingError):
                                if failure != nil
                                {
                                    failure!(encodingError)
                                }
                            }
        }
        )

    }
}
