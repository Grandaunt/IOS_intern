//
//  AFNetworkingTool.swift
//  SwiftProject
//
//  Created by hxt on 2017/1/3.
//  Copyright © 2017年 hxt. All rights reserved.
//
//  用AFN时封装的网络请求工具

//import AFNetworking

//typealias Success = ((Any?) -> Void)? //成功的闭包
//typealias Failure = ((Error?)->Void)? //失败的闭包
//typealias ProgressCus = ((Progress)->Void)? //上传或下载进度的闭包
//typealias Destination = ((URL,URLResponse?)->URL)? //返回url的闭包
//typealias DownLoadSuccess = ((URLResponse?, URL)->Void)? //下载成功的闭包
//
//let timeInterval:Double = 20
//
//class AFNetworkingTool: NSObject {
//    
//    //单例,静态属性。
//    static let shared:AFHTTPSessionManager = {
//        let manager = AFHTTPSessionManager();
//        var contentTypes:Set = manager.responseSerializer.acceptableContentTypes!
//        contentTypes.insert("text/html")
//        contentTypes.insert("text/plain")
////        manager.requestSerializer = AFHTTPRequestSerializer()
////        manager.responseSerializer = AFHTTPResponseSerializer()
//        manager.responseSerializer.acceptableContentTypes = contentTypes
//        manager.requestSerializer.timeoutInterval = timeInterval
//        return manager;
//    }()
//    
//    /// 网络监测(在什么网络状态)
//    ///
//    /// - Parameters:
//    ///   - unknown: 未知网络
//    ///   - notReachable: 无网络
//    ///   - reachableViaWWAN: 蜂窝数据网
//    ///   - reachableViaWiFi: wifi网络
//    class func networkStatus(unknown: (()->Void)?,notReachable: (()->Void)?,reachableViaWWAN: (()->Void)?,reachableViaWiFi: (()->Void)?)->Void{
//        let manager = AFNetworkReachabilityManager.shared()
//        manager.setReachabilityStatusChange { (status) in
//            switch status
//            {
//            case .unknown:
//                unknown!()
//            case .notReachable:
//                notReachable!()
//            case .reachableViaWiFi:
//                reachableViaWiFi!()
//            case .reachableViaWWAN:
//                reachableViaWWAN!()
//            }
//        }
//        manager.startMonitoring()
//    }
//    
//    
//    /// 封装的get请求
//    ///
//    /// - Parameters:
//    ///   - URLString: 请求的链接
//    ///   - parameters: 请求的参数1
//    ///   - success: 请求成功的回调
//    ///   - failure: 请求失败的回调
//    class func GET(URL URLString:String,param parameters:Dictionary<String, Any>?,success:Success,failure:Failure){
//        
//        AFNetworkingTool.shared.get(URLString, parameters: parameters, progress: nil, success: { (dataTask, responseObject) in
//            if responseObject != nil
//            {
//                success!(responseObject)
//            }
//        }) { (dataTask, error) in
//            failure!(error)
//        }?.resume()
//        
//    }
//    
//    //封装的post请求
//    class func POST(URL URLString:String,param parameters:Dictionary<String, Any>?,success:Success,failure:Failure){
//        
//        AFNetworkingTool.shared.post(URLString, parameters: parameters, progress: nil, success: { (dataTask, responseObject) in
//            if responseObject != nil
//            {
//
//                success!(responseObject)
//            }
//        }) { (dataTask, error) in
//            
//            failure!(error)
//        }?.resume()
//    }
//    
//    //图片上传
//    class func POST(URL URLString:String,param parameters:Dictionary<String, Any>,picArray:Array<Any>,commonFileName:String,progress: ProgressCus,success: Success,failure: Failure)
//    {
//        AFNetworkingTool.shared.post(URLString, parameters: parameters, constructingBodyWith: { (fromData) in
//            let count = picArray.count
//            var fileName = ""
//            var data = Data()
//            for i in 0..<count
//            {
//               fileName = "\(commonFileName)\(i)"
//                let image:UIImage = picArray[i] as! UIImage
//                data = UIImageJPEGRepresentation(image, 0.5)!
//                fromData.appendPart(withFileData: data, name: fileName, fileName: fileName+".jpg", mimeType: "image/jpeg")
//            }
//        }, progress: progress, success: { (dataTask, responseObject) in
//            if responseObject != nil
//            {
//                success!(responseObject)
//            }
//        }) { (dataTask, error) in
//            
//            failure!(error)
//            }?.resume()
//    }
//    
//    //图片上传
//    class func POSTOne(URL URLString:String,param parameters:Dictionary<String, Any>,pic:UIImage,commonFileName:String,progress: ProgressCus,success: Success,failure: Failure)
//    {
//        AFNetworkingTool.shared.post(URLString, parameters: parameters, constructingBodyWith: { (fromData) in
//            let data = UIImageJPEGRepresentation(pic, 0.5)!
//            fromData.appendPart(withFileData: data, name: commonFileName, fileName: commonFileName + ".jpg", mimeType: "image/jpeg")
//            
//        }, progress: progress, success: { (dataTask, responseObject) in
//            if responseObject != nil
//            {
//                success!(responseObject)
//            }
//        }) { (dataTask, error) in
//            
//            failure!(error)
//            }?.resume()
//    }
//
//    
//    //上传数据
//    class func POST(URL URLString:String,param parameters:Dictionary<String, Any>,data:Data,commonFileName:String,contentType:String,progress: ProgressCus,success: Success,failure: Failure)
//    {
//        AFNetworkingTool.shared.post(URLString, parameters: parameters, constructingBodyWith: { (fromData) in
//            fromData.appendPart(withFileData: data, name: commonFileName, fileName: commonFileName, mimeType: contentType)
//        }, progress: progress, success: { (dataTask, responseObject) in
//            if responseObject != nil
//            {
//                success!(responseObject)
//            }
//        }) { (dataTask, error) in
//            
//            failure!(error)
//            }?.resume()
//    }
//    
//    //下载
//    class func download(URL URLString:String, progress: ProgressCus,destination: Destination, success: DownLoadSuccess,failure: Failure)->URLSessionDownloadTask?
//    {
//        let request:URLRequest = URLRequest.init(url: URL.init(string: URLString)!)
//        let task:URLSessionDownloadTask = AFNetworkingTool.shared.downloadTask(with: request, progress: progress, destination:destination) { (response, filePath, error) in
//            if error != nil
//            {
//                failure!(error)
//            }
//            else
//            {
//                success!(response, filePath!)
//            }
//        }
//        task.resume()
//        
//        return task
//    }
//
//}
