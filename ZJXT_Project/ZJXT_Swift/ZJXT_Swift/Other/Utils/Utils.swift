//
//  Utils.swift
//  SwiftProject
//
//  Created by hxt on 2017/1/5.
//  Copyright © 2017年 hxt. All rights reserved.
//

import Foundation
import WebKit
import MBProgressHUD

class Utils: NSObject
{
    
    //计算文字的尺寸
    class func sizeText(text:String,font:UIFont,maxSize:CGSize) -> CGSize
    {
        let attrs:Dictionary = [NSAttributedStringKey.font:font]
        let attributeStr:NSAttributedString = NSAttributedString(string: text, attributes: attrs)
        return attributeStr.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
    }
    
    //检测密码是否符合规范，6-20数字与字母组合
    class func checkPassword(str:String?)->Bool
    {
        if str == nil
        {
            return false
        }
        
        let PASSWORD1 = "^[A-Za-z0-9\\!\\@\\#\\$\\%\\^\\&\\*\\.\\~\\,\\@\\{\\}\\-\\=\\_\\+\\|\\;\\:\\/\\']{6,20}$"//6-20数字和字母组合
        let PASSWORD2 = "^[0-9]{6,20}$"//全数字组合
        let regestextct1 = NSPredicate(format: "SELF MATCHES %@", PASSWORD1)
        let regestextct2 = NSPredicate(format: "SELF MATCHES %@", PASSWORD2)
        let res1 = regestextct1.evaluate(with: str)
        let res2 = regestextct2.evaluate(with: str)
        if res1 == true && res2 == false
        {
            return true
        }
        else
        {
            return false
        }

        
    }
    
    class func compareVersion(serverStr:String?,localStr:String?) -> Bool
    {
        var ret = false
        if serverStr == nil || serverStr?.count == 0 || localStr == nil || localStr?.count == 0
        {
            log.error("版本号有空值")
            return ret;
        }
        let serComps = serverStr?.components(separatedBy: ".")
        let locComps = localStr?.components(separatedBy: ".")
        //swift3.0 以后的遍历方法，推荐
        for (index,value) in (serComps?.enumerated())!
        {
            let numServer = Int(value)
            var numLocal:Int = -1
            if (locComps?.count)! > index {
                numLocal = Int((locComps?[index])!)!
            }
            if numServer! > numLocal {
                ret = true
                break
            }
            else if numServer! < numLocal
            {
                ret = false
                break
            }
        }
        return ret
    }
    
    //验证手机号
    class func isPhoneNumber(phoneNumber:String) -> Bool
    {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    class func isEmail(email:String) -> Bool
    {
        if email.trimAfterCount() == 0
        {
            return false
        }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: email)
        
        return isValid
    }
    
    //倒计时
    class func startTime(btn:UIButton,time:Int)
    {
        var timeout = time
        btn.backgroundColor = UIColor.color(hex: "#BDBDBD")
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler { 
            if timeout <= 0
            {
                timer.cancel()
                DispatchQueue.main.async {
                    btn.setTitle("发送验证码", for: UIControlState.normal)
                    btn.isUserInteractionEnabled = true
                    btn.backgroundColor = kTabbarBlueColor
                }
            }
            else
            {
                let seconds = timeout
                DispatchQueue.main.async {
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(1)
                    btn.setTitle(String(format: "%.2d秒", seconds), for: UIControlState.normal)
                    UIView.commitAnimations()
                    btn.isUserInteractionEnabled = false
                }
            }
            timeout = timeout - 1
        }
        timer.resume()
    }
    
    class func getCityIds(proviceCityCountry:Array<String>)->Array<Any>?
    {
        if proviceCityCountry.count != 3
        {
            return nil
        }
        let province = proviceCityCountry[0]
        let city = proviceCityCountry[1]
        let country = proviceCityCountry[2]
        let path = Bundle.main.path(forResource: "address.plist", ofType: nil)
        let addressDict = NSDictionary(contentsOfFile: path!) as! Dictionary<String, Any>
        let provinceArray = addressDict["province"] as! Array<Dictionary<String, Any>>
        var countryIdNotFound = true
        var retArray:Array<String>?
        for provinceDict in provinceArray {
            if self.compareProvince(province: province, provinceName: provinceDict["name"] as! String) {
                let provinceId = provinceDict["id"] as! String
                retArray?.append(provinceId)
                let cityArray = provinceDict["city"] as! Array<Dictionary<String,Any>>
                for cityDict in cityArray {
                    if self.compareCity(city: city, cityName: cityDict["name"] as! String) {
                        let cityId = cityDict["id"] as! String
                        retArray?.append(cityId)
                        let countryArray = cityDict["country"] as! Array<Dictionary<String, Any>>
                        for countryDict in countryArray
                        {
                            if self.compareCity(city: country, cityName: countryDict["name"] as! String) {
                                let countryId = countryDict["id"] as! String
                                retArray?.append(countryId)
                                countryIdNotFound = false
                                break
                            }
                        }
                    }
                }
            }
        }
        if retArray?.count == 2 && countryIdNotFound == true
        {
            retArray?.append("")
        }
        return retArray
    }
    
    class func compareProvince(province:String,provinceName:String)->Bool
    {
        if (province.range(of: provinceName) != nil) || (provinceName.range(of: province) != nil)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    class func compareCity(city:String,cityName:String)->Bool
    {
        if (city.range(of: cityName) != nil) || (cityName.range(of: city) != nil)
        {
            return true
        }
        else
        {
            return false
        }
    }    
//    //颜色生成图片
//    class func image(color:UIColor)->UIImage
//    {
//        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(color.cgColor)
//        context?.fill(rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
    
    //点击方法图片
    class func becomeBigImage(atView:UIView,tap:UITapGestureRecognizer)
    {
        let tapImage = tap.view as! UIImageView
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: kScreenViewHeight - 64))
        image.isUserInteractionEnabled = true
        image.contentMode = UIViewContentMode.scaleAspectFit
        image.image = tapImage.image
        image.alpha = 0
        image.backgroundColor = UIColor.white
        atView.addSubview(image)
        atView.bringSubview(toFront: image)
        let hiddenTap = UITapGestureRecognizer(target: self, action: #selector(hiddenBigView(tap:)))
        image.addGestureRecognizer(hiddenTap)
        UIView.animate(withDuration: 0.7) { 
            image.alpha = 1
        }
    }
    
    //隐藏放大的图片
    @objc class func hiddenBigView(tap:UITapGestureRecognizer)
    {
        let tapImage = tap.view as! UIImageView
        UIView.animate(withDuration: 0.7, animations: { 
            tapImage.alpha = 0
        }) { (finished) in
            tapImage.removeFromSuperview()
        }
    }
    
    class func makePhone(phoneNumber:String,superView:UIView)
    {
        if phoneNumber.count == 0
        {
            return
        }
        
        let webView = WKWebView()
        let request = URLRequest(url:  URL(string: "tel://\(phoneNumber)")!)
        
        webView.load(request)
        superView.addSubview(webView)

    }
    
    class func removeComma(str:String) -> String?
    {
        if str.count == 0
        {
            return nil
        }
        
        let string = str.replacingOccurrences(of: ",", with: "")
        return string
    }
    
    class func numberOfString(number:NSNumber) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let str = formatter.string(from: number)
        return str!
    }
    
    class func lefTime(count:String) -> String
    {
        let string = NSString(string: count)
        
        let time = string.doubleValue
        
        
        let day = Int(time/(24*60*60))
        
        let h = Int((time/3600).truncatingRemainder(dividingBy: 24.0))
        
        let m = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60.0))
        
        return "\(day)天\(h)小时\(m)分\(sec)秒"
    }
    
    class func updateItmeForRow(createTimeString:String)->String
    {
        let currentTime = Date().timeIntervalSince1970
        
        let string = NSString(string: createTimeString)
        let createTime = string.doubleValue
        
//        let createTime  = TimeInterval(createTimeString)!/1000
        let time = currentTime-createTime
        let sec = time/60
        if sec < 60
        {
           return String(format: "%.0f分钟前", sec)
        }
        let hours = time/3600
        if hours < 24
        {
            return String(format: "%.0f小时前", hours)
        }
        let days = time/3600/24
        return String(format: "%.0f天前", days)
        
    }
    
    class func getCurrentVC() -> UIViewController?
    {
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        
        var tempView: UIView?
        
        for subview in window.subviews.reversed() {
            
            
            if subview.classForCoder.description() == "UILayoutContainerView"
            {
                
                tempView = subview
                
                break
            }
        }
        
        if tempView == nil
        {
            tempView = window.subviews.last
        }
        
        var nextResponder = tempView?.next
        
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController
        }
        
        while next{
            
            tempView = tempView?.subviews.first
            
            if tempView == nil {
                
                return nil
            }
            
            nextResponder = tempView!.next
        }
        
        return nextResponder as? UIViewController
    }
    
//    class func share(title:String,desc:String,image:String,url:String,controller:UIViewController)
//    {
//        //不显示标题
//        UMSocialShareUIConfig.shareInstance().shareTitleViewConfig.isShow = false
//        //不显示pageControl
//        UMSocialShareUIConfig.shareInstance().sharePageControlConfig.isShow = false
//        UMSocialShareUIConfig.shareInstance().shareCancelControlConfig.isShow = false
//        //设置每行最多5个
//        UMSocialShareUIConfig.shareInstance().sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 5
//        
//        //设置分享面板的图标顺序
//        UMSocialUIManager.setPreDefinePlatforms([UMSocialPlatformType.wechatSession.rawValue,UMSocialPlatformType.wechatTimeLine.rawValue,UMSocialPlatformType.QQ.rawValue,UMSocialPlatformType.qzone.rawValue,UMSocialPlatformType.sina.rawValue])
//        
//        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
//            let messageObject = UMSocialMessageObject()
//            let imageURL = URL(string: image)
//            let shareObject = UMShareWebpageObject.shareObject(withTitle: title, descr: desc, thumImage:imageURL)
//            shareObject?.webpageUrl = url
//            messageObject.shareObject = shareObject
//            
//            UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: controller, completion: { (data, error) in
//                
//            })
//            
//        }
//    }
    
    //行间距
    class func getAttributeStringWithString(_ string: String,lineSpace:CGFloat) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStye = NSMutableParagraphStyle()
        
        //调整行间距
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(string as CFString!))
        attributedString .addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStye, range: rang)
        return attributedString
        
    }
    
    class func timesnapAddNowDate(countdown:Double) -> String
    {
        let nowTimeSnap = Date().timeIntervalSince1970
        
        let after = nowTimeSnap + countdown
        
        let timeInterval:TimeInterval = TimeInterval(after)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        //格式话输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-M-d HH:mm:ss"
        
        return dformatter.string(from: date)
    }
    
    //秒转成播放时间
    class func getFormatPlayTime(secounds:TimeInterval)->String{
        if secounds.isNaN{
            return "00:00"
        }
        var Min = Int(secounds / 60)
        let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
        var Hour = 0
        if Min>=60 {
            Hour = Int(Min / 60)
            Min = Min - Hour*60
            return String(format: "%02d:%02d:%02d", Hour, Min, Sec)
        }
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    //生成请求参数
    class func createRequestParam(params:[String:Any]?,c:String,a:String) -> [String:Any]?
    {
        let timesnamp = String(format: "%lld", Date().timeIntervalSince1970*1000)
        
        //参数拼接，加密
        let str = "\(a)\(c)\(timesnamp)sunrock"
        let password = str.md5()
        let passwordStr = password.md5()
        
        //post请求参数（字典）
        var dic = [String:Any]()
        dic["openid"] = "1"
        dic["c"] = c
        dic["a"] = a
        dic["timesnamp"] = timesnamp
        dic["sign"] = passwordStr
        
        if params == nil
        {
            return dic
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted) else {
            log.error("json转换失败")
            return nil
        }
        
        dic["param"] = String(data: data, encoding: .utf8)
        
        return dic
        
    }
    
//    //支付宝支付
//    class func chargeZFB(amount:String,orderId:String,notifyURL:String,viewController:UIViewController)
//    {
//        let appID = ZFBAppID
//        let privateKey = SharedAppDelegate.zfbPrivateKey
//        //收款支付宝账户
//        let seller = ZFBSellerID
//        
//        if appID.characters.count == 0 || privateKey?.characters.count == 0 || seller.characters.count == 0 {
//            let action = UIAlertAction(title: "确定", style: .cancel, handler: { (alertAction) in
//                
//            })
//            let alertController = UIAlertController(title: "提示", message: "暂时无法进行支付宝支付。", preferredStyle: .alert)
//            alertController.addAction(action)
//            viewController.present(alertController, animated: true, completion: nil)
//        }
//        
//        let order = Order()
//        order.app_id = appID
//        order.method = "alipay.trade.app.pay"
//        order.charset = "utf-8"
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        order.timestamp = formatter.string(for: Date())
//        
//        order.version = "1.0"
//        order.sign_type = "RSA"
//        order.notify_url = notifyURL
//        order.biz_content = BizContent()
//        order.biz_content.subject = "金科云谷订单"
//        order.biz_content.body = "金科云谷"
//        order.biz_content.total_amount = amount
//        order.biz_content.timeout_express = "30m"
//        order.biz_content.seller_id = seller
//        order.biz_content.out_trade_no = orderId
//        
//        let orderInfo = order.orderInfoEncoded(false)
//        let orderInfoEncoded = order.orderInfoEncoded(true)
//        log.info("ZFBOrder:\(orderInfo ?? "暂无订单信息")")
//        
//        let signer = RSADataSigner(privateKey: privateKey)
//        
//        let signerStr = signer?.sign(orderInfo)
//        if signerStr != nil {
//            let infoDic = Bundle.main.infoDictionary
//            let urlTypes = infoDic?["CFBundleURLTypes"] as! [[String:Any]]
//            var appName:String = ""
//            for urlType in urlTypes {
//                if urlType["CFBundleURLName"] as! String == kURLTypeApp {
//                    appName = (urlType["CFBundleURLSchemes"] as! [String]).first!
//                }
//            }
//            
//            let orderString = "\(orderInfoEncoded!)@sign=\(signerStr!)"
//            SharedAppDelegate.payVC = viewController
////            SharedAppDelegate.orderId = orderId
//            
//            AlipaySDK.defaultService().payOrder(orderString, fromScheme: appName, callback: { (resultDic) in
////                log.info("支付宝返回信息:\(resultDic)")
//                let strTitle = "支付结果"
//                var strMsg = ""
//                
//                if Int(resultDic?["resultStatus"] as! String) == kAlipayRetSucceed
//                {
//                    strMsg = "支付结果：成功"
//                }
//                else
//                {
//                    strMsg = "支付结果：失败"
//                }
//                let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//                let alertController = UIAlertController(title: strTitle, message: strMsg, preferredStyle: .alert)
//                alertController.addAction(action)
//                viewController.present(alertController, animated: true, completion: nil)
//                
//            })
//        }
//    }
//    
//    //该方法加密等在本地进行
//    class func chargeWxPay(amount:String,orderNum:String,orderId:String,notifyURL:String,viewController:UIViewController)
//    {
//        if notifyURL.characters.count == 0 {
//            let action = UIAlertAction(title: "确定", style: .cancel, handler: { (alertAction) in
//                
//            })
//            let alertController = UIAlertController(title: "提示", message: "暂时无法进行微信支付。", preferredStyle: .alert)
//            alertController.addAction(action)
//            viewController.present(alertController, animated: true, completion: nil)
//            return
//        }
//        if WXApi.isWXAppInstalled() ==  false {
//            let action = UIAlertAction(title: "确定", style: .cancel, handler: { (alertAction) in
//                
//            })
//            let alertController = UIAlertController(title: "您没有安装微信", message: "请先安装微信后再进行支付    ", preferredStyle: .alert)
//            alertController.addAction(action)
//            viewController.present(alertController, animated: true, completion: nil)
//            return
//        }
//        
//        let nonceStr = arc4random()
//        var packageParams = [String:Any]()
//        
//        packageParams["appid"] = WXAppKey
//        packageParams["mch_id"] = WXBuID
//        packageParams["device_info"] = "APP-01"
//        packageParams["nonce_str"] = nonceStr
//        packageParams["trade_type"] = "APP"
//        packageParams["body"] = orderNum
//        packageParams["notify_url"] = notifyURL
//        packageParams["out_trade_no"] = orderId
//        packageParams["spbill_create_ip"] = "192.168.1.1"
//        packageParams["total_fee"] = amount
//        
//        let prePayid = getPrePayid(prePayParams: packageParams)
//        
//        if prePayid != nil {
//            var package:String?
//            var time_stamp:String?
//            var nonce_str:String?
//            //设置支付参数
//            //时间戳
//            let date = Date()
//            time_stamp = "\(date.timeIntervalSince1970)"
//            nonce_str = WXUtil.md5(time_stamp!)
//            
//            //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
//            package = "Sign=WXPay"
//            //第二次签名必须带的参数列表
//            var signParams = [String:Any]()
//            signParams["appid"] = WXAppKey
//            signParams["noncestr"] = nonce_str
//            signParams["package"] = package
//            signParams["partnerid"] = WXBuID
//            signParams["timestamp"] = time_stamp
//            signParams["prepayid"] = prePayid
//            
//            let sign = createMd5Sign(dict: signParams)
//            
//            //调起微信支付
//            let req = PayReq()
//            req.openID = WXAppKey
//            req.partnerId = WXBuID
//            req.prepayId = prePayid
//            req.nonceStr = nonce_str
//            req.timeStamp = UInt32(time_stamp!)!
//            req.package = package
//            req.sign = sign   //该sign是对获取prepayid以后设置的全部字段进行二次签名
//            
//            SharedAppDelegate.payVC = viewController
////            SharedAppDelegate.orderId = orderId
//            
//            let res = WXApi.send(req)
//            if res == false {
//                let alertController = UIAlertController(title: "提示", message: "未安装微信，或微信启动失败", preferredStyle: .alert)
//                viewController.present(alertController, animated: true, completion: nil)
//                viewController.perform(#selector(dissmissAlert(alert:)), with: alertController, afterDelay: 2.0)
//            }
//        }
//        else
//        {
//            log.error("获取prePayid失败")
//        }
//    }
//    
//    //该方法加密等都在服务器进行
//    class func chargeWxPay(prepayid:String,noncestr:String,timestamp:uint,sign:String,controller:UIViewController?, payModel:CXOrderDetailModel?)
//    {
//        if WXApi.isWXAppInstalled() ==  false
//        {
//            MBProgressHUD.show(error: "请先安装微信后再进行支付")
//            return
//        }
//        
//        //调起微信支付
//        let req = PayReq()
//        req.openID = WXAppKey
//        req.partnerId = WXBuID
//        req.prepayId = prepayid
//        req.nonceStr = noncestr
//        
////        var times:UInt32 = 0
////        _ = (Scanner.localizedScanner(with: timestamp) as AnyObject).scanHexInt32(&times)
//        req.timeStamp = timestamp
//        req.package = "Sign=WXPay"
//        req.sign = sign   //该sign是对获取prepayid以后设置的全部字段进行二次签名
//        
//        let _ = WXApi.send(req)
//        
//        SharedAppDelegate.payVC = controller
//        SharedAppDelegate.payModel = payModel
//    }
    
    @objc private func dissmissAlert(alert:UIAlertController)
    {
        alert.dismiss(animated: true, completion: nil)
    }
    
//    class func getPrePayid(prePayParams:[String:Any]) -> String?
//    {
//        var prePayid:String?
//        let send = genPackage(packageParams: prePayParams)
//        let res = WXUtil.httpSend("https://api.mch.weixin.qq.com/pay/unifiedorder", method: "POST", data: send)
//        //        let resStr = String(data: res!, encoding: String.Encoding.utf8)
//        
//        let xml = XMLHelper()
//        xml.startParse(res!)
//        
//        let resParams = xml.getDict() as NSDictionary as! [String:Any]
//        //判断返回
//        var return_code = resParams["return_code"] as! String
//        let result_msg = resParams["result_msg"] as! String
//        
//        if return_code == "SUCCESS" {
//            //生成返回数据的签名
//            let sign = createMd5Sign(dict: resParams)
//            let send_sign = resParams["sign"] as! String
//            
//            //验证签名的正确性
//            if sign == send_sign {
//                if return_code == "SUCCESS" {
//                    //验证业务处理状态
//                    prePayid = resParams["prepay_id"] as? String
//                    return_code = "0"
//                }
//            }
//        }
//        else
//        {
//            log.error("error:\(result_msg)")
//        }
//        return prePayid
//    }
//    class func genPackage(packageParams:[String:Any]) -> String
//    {
//        var sign = ""
//        var reqPars = ""
//        //生成签名
//        sign = createMd5Sign(dict: packageParams)
//        //生成xml的package
//        let keys = Array(packageParams.keys)
//        reqPars.append("<xml>\n")
//        for categoryId in keys {
//            reqPars.append("<\(categoryId)>\(packageParams[categoryId] as! String)</\(categoryId)>\n")
//        }
//        reqPars.append("<sign>\(sign)\n</xml>")
//        return reqPars
//    }
    
//    //创建package签名
//    class func createMd5Sign(dict:[String:Any]) -> String
//    {
//        var contentString = ""
//        let keys = Array(dict.keys)
//        
//        //按字母顺序排列
//        let sortedArray = keys.sorted { (obj1, obj2) -> Bool in
//            if obj1.compare(obj2) == ComparisonResult.orderedAscending
//            {
//                return true
//            }
//            else
//            {
//                return false
//            }
//        }
//        
//        //拼接字符串
//        for categoryId in sortedArray {
//            if (dict[categoryId] as! String) != "" && categoryId != "sign" && categoryId != "key" {
//                contentString.append("\(categoryId)=\(dict[categoryId] as! String)&")
//            }
//        }
//        contentString.append("key=\(SharedAppDelegate.wxPrivateKey!)")
//        
//        //得到md5 sign签名
//        let md5Sign = WXUtil.md5(contentString)
//        
//        return md5Sign!
//    }
    
    //字典转json
    class func getJSONStringFromDictionary(dictionary:[String:Any]) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            log.error("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
    //字符串转字典
    func getDictionaryFromJSONString(jsonString:String) ->[String:Any]
    {
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! [String:Any]
        }
        return [String:Any]()
        
        
    }

//    //该方法加密等在本地进行
//    class func chargeWxPay(amount:String,orderNum:String,orderId:String,notifyURL:String,viewController:UIViewController)
//    {
//        if notifyURL.characters.count == 0 {
//            let action = UIAlertAction(title: "确定", style: .cancel, handler: { (alertAction) in
//                
//            })
//            let alertController = UIAlertController(title: "提示", message: "暂时无法进行微信支付。", preferredStyle: .alert)
//            alertController.addAction(action)
//            viewController.present(alertController, animated: true, completion: nil)
//            return
//        }
//        if WXApi.isWXAppInstalled() ==  false {
//            let action = UIAlertAction(title: "确定", style: .cancel, handler: { (alertAction) in
//                
//            })
//            let alertController = UIAlertController(title: "您没有安装微信", message: "请先安装微信后再进行支付    ", preferredStyle: .alert)
//            alertController.addAction(action)
//            viewController.present(alertController, animated: true, completion: nil)
//            return
//        }
//        
//        let nonceStr = arc4random()
//        var packageParams = [String:Any]()
//        
//        packageParams["appid"] = WXAppKey
//        packageParams["mch_id"] = WXBuID
//        packageParams["device_info"] = "APP-01"
//        packageParams["nonce_str"] = nonceStr
//        packageParams["trade_type"] = "APP"
//        packageParams["body"] = orderNum
//        packageParams["notify_url"] = notifyURL
//        packageParams["out_trade_no"] = orderId
//        packageParams["spbill_create_ip"] = "192.168.1.1"
//        packageParams["total_fee"] = amount
//        
//        let prePayid = getPrePayid(prePayParams: packageParams)
//        
//        if prePayid != nil {
//            var package:String?
//            var time_stamp:String?
//            var nonce_str:String?
//            //设置支付参数
//            //时间戳
//            let date = Date()
//            time_stamp = "\(date.timeIntervalSince1970)"
//            nonce_str = WXUtil.md5(time_stamp!)
//            
//            //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
//            package = "Sign=WXPay"
//            //第二次签名必须带的参数列表
//            var signParams = [String:Any]()
//            signParams["appid"] = WXAppKey
//            signParams["noncestr"] = nonce_str
//            signParams["package"] = package
//            signParams["partnerid"] = WXBuID
//            signParams["timestamp"] = time_stamp
//            signParams["prepayid"] = prePayid
//            
//            let sign = createMd5Sign(dict: signParams)
//            
//            //调起微信支付
//            let req = PayReq()
//            req.openID = WXAppKey
//            req.partnerId = WXBuID
//            req.prepayId = prePayid
//            req.nonceStr = nonce_str
//            req.timeStamp = UInt32(time_stamp!)!
//            req.package = package
//            req.sign = sign   //该sign是对获取prepayid以后设置的全部字段进行二次签名
//            
//            SharedAppDelegate.payVC = viewController
//            //            SharedAppDelegate.orderId = orderId
//            
//            let res = WXApi.send(req)
//            if res == false {
//                let alertController = UIAlertController(title: "提示", message: "未安装微信，或微信启动失败", preferredStyle: .alert)
//                viewController.present(alertController, animated: true, completion: nil)
//                viewController.perform(#selector(dissmissAlert(alert:)), with: alertController, afterDelay: 2.0)
//            }
//        }
//        else
//        {
//            log.error("获取prePayid失败")
//        }
//    }
//    
//    //该方法加密等都在服务器进行
//    class func chargeWxPay(prepayid:String,noncestr:String,timestamp:uint,sign:String,controller:UIViewController?, payModel:TMOrderDetailModel?)
//    {
//        if WXApi.isWXAppInstalled() ==  false
//        {
//            MBProgressHUD.show(error: "请先安装微信后再进行支付")
//            return
//        }
//        
//        //调起微信支付
//        let req = PayReq()
//        req.openID = WXAppKey
//        req.partnerId = WXBuID
//        req.prepayId = prepayid
//        req.nonceStr = noncestr
//        
//        //        var times:UInt32 = 0
//        //        _ = (Scanner.localizedScanner(with: timestamp) as AnyObject).scanHexInt32(&times)
//        req.timeStamp = timestamp
//        req.package = "Sign=WXPay"
//        req.sign = sign   //该sign是对获取prepayid以后设置的全部字段进行二次签名
//        
//        let _ = WXApi.send(req)
//        
//        SharedAppDelegate.payVC = controller
//        SharedAppDelegate.payModel = payModel
//    }
//    
//    class func getPrePayid(prePayParams:[String:Any]) -> String?
//    {
//        var prePayid:String?
//        let send = genPackage(packageParams: prePayParams)
//        let res = WXUtil.httpSend("https://api.mch.weixin.qq.com/pay/unifiedorder", method: "POST", data: send)
//        //        let resStr = String(data: res!, encoding: String.Encoding.utf8)
//        
//        let xml = XMLHelper()
//        xml.startParse(res!)
//        
//        let resParams = xml.getDict() as NSDictionary as! [String:Any]
//        //判断返回
//        var return_code = resParams["return_code"] as! String
//        let result_msg = resParams["result_msg"] as! String
//        
//        if return_code == "SUCCESS" {
//            //生成返回数据的签名
//            let sign = createMd5Sign(dict: resParams)
//            let send_sign = resParams["sign"] as! String
//            
//            //验证签名的正确性
//            if sign == send_sign {
//                if return_code == "SUCCESS" {
//                    //验证业务处理状态
//                    prePayid = resParams["prepay_id"] as? String
//                    return_code = "0"
//                }
//            }
//        }
//        else
//        {
//            log.error("error:\(result_msg)")
//        }
//        return prePayid
//    }
//    class func genPackage(packageParams:[String:Any]) -> String
//    {
//        var sign = ""
//        var reqPars = ""
//        //生成签名
//        sign = createMd5Sign(dict: packageParams)
//        //生成xml的package
//        let keys = Array(packageParams.keys)
//        reqPars.append("<xml>\n")
//        for categoryId in keys {
//            reqPars.append("<\(categoryId)>\(packageParams[categoryId] as! String)</\(categoryId)>\n")
//        }
//        reqPars.append("<sign>\(sign)\n</xml>")
//        return reqPars
//    }
//    
//    //创建package签名
//    class func createMd5Sign(dict:[String:Any]) -> String
//    {
//        var contentString = ""
//        let keys = Array(dict.keys)
//        
//        //按字母顺序排列
//        let sortedArray = keys.sorted { (obj1, obj2) -> Bool in
//            if obj1.compare(obj2) == ComparisonResult.orderedAscending
//            {
//                return true
//            }
//            else
//            {
//                return false
//            }
//        }
//        
//        //拼接字符串
//        for categoryId in sortedArray {
//            if (dict[categoryId] as! String) != "" && categoryId != "sign" && categoryId != "key" {
//                contentString.append("\(categoryId)=\(dict[categoryId] as! String)&")
//            }
//        }
//        contentString.append("key=\(SharedAppDelegate.wxPrivateKey!)")
//        
//        //得到md5 sign签名
//        let md5Sign = WXUtil.md5(contentString)
//        
//        return md5Sign!
//    }
//
//    //支付宝支付
//    class func chargeZFB(orderStr:String,viewController:UIViewController)
//    {
//        SharedAppDelegate.payVC = viewController
//        
//        let infoDic = Bundle.main.infoDictionary
//        let urlTypes = infoDic?["CFBundleURLTypes"] as! [[String:Any]]
//        var appName:String = ""
//        for urlType in urlTypes {
//            if urlType["CFBundleURLName"] != nil
//            {
//                if urlType["CFBundleURLName"] as! String == kURLTypeApp {
//                    appName = (urlType["CFBundleURLSchemes"] as! [String]).first!
//                }
//                
//            }
//        }
//        
//        AlipaySDK.defaultService().payOrder(orderStr, fromScheme: appName, callback: { (resultDic) in
//            
//            let strTitle = "支付结果"
//            var strMsg = ""
//            
//            if Int(resultDic?["resultStatus"] as! String) == kAlipayRetSucceed
//            {
//                strMsg = "支付结果：成功"
//            }
//            else
//            {
//                strMsg = "支付结果：失败"
//            }
//            let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//            let alertController = UIAlertController(title: strTitle, message: strMsg, preferredStyle: .alert)
//            alertController.addAction(action)
//            viewController.present(alertController, animated: true, completion: nil)
//            
//        })
//    }
//    
//    class func chargeZFB(biz_content:[String:Any],timestamp:String,sign:String,notifyURL:String,viewController:UIViewController)
//    {
//        
//        let info = Bundle.main.infoDictionary
//        
//        let rsa2PrivateKey = info?["zfbPrivateKey"] as! String
//        
//        let order = Order()
//        order.app_id = ZFBAppID
//        order.method = "alipay.trade.app.pay"
//        order.charset = "UTF-8"
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        order.timestamp = formatter.string(from: Date())
//        
//        order.version = "1.0"
//        order.sign_type = "RSA2"
//        order.notify_url = notifyURL
//        order.biz_content = BizContent()
//        order.biz_content.subject = biz_content["subject"] as! String
//        order.biz_content.body = biz_content["body"] as! String
//        order.biz_content.total_amount = biz_content["total_amount"] as! String
//        order.biz_content.timeout_express = biz_content["timeout_express"] as! String
//        order.biz_content.seller_id = ZFBSellerID
//        order.biz_content.out_trade_no = biz_content["out_trade_no"] as! String
//        order.biz_content.product_code = biz_content["product_code"] as! String
//        
//        let orderInfoEncoded = order.orderInfoEncoded(true)
//        
//        let orderInfo = order.orderInfoEncoded(false)
//        
//        var signedString:String?
//        let signer = RSADataSigner(privateKey: rsa2PrivateKey)
//        
//        signedString = signer?.sign(orderInfo, withRSA2: true)
//        
//        if signedString != nil
//        {
//            let orderString = "\(orderInfoEncoded!)&sign=\(signedString!)"
//            
//            SharedAppDelegate.payVC = viewController
//            
//            let infoDic = Bundle.main.infoDictionary
//            let urlTypes = infoDic?["CFBundleURLTypes"] as! [[String:Any]]
//            var appName:String = ""
//            for urlType in urlTypes {
//                if urlType["CFBundleURLName"] != nil
//                {
//                    if urlType["CFBundleURLName"] as! String == kURLTypeApp {
//                        appName = (urlType["CFBundleURLSchemes"] as! [String]).first!
//                    }
//                    
//                }
//            }
//            
//            AlipaySDK.defaultService().payOrder(orderString, fromScheme: appName, callback: { (resultDic) in
//                //                log.info("支付宝返回信息:\(resultDic)")
//                let strTitle = "支付结果"
//                var strMsg = ""
//                
//                if Int(resultDic?["resultStatus"] as! String) == kAlipayRetSucceed
//                {
//                    strMsg = "支付结果：成功"
//                }
//                else
//                {
//                    strMsg = "支付结果：失败"
//                }
//                let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//                let alertController = UIAlertController(title: strTitle, message: strMsg, preferredStyle: .alert)
//                alertController.addAction(action)
//                viewController.present(alertController, animated: true, completion: nil)
//                
//            })
//        }
//    }
}


    
//    //去除换行符
//    class func ReplacingNewLineAndWhitespaceCharacters(dataStr:String) -> String?
//    {
//        let scanner = Scanner(string: dataStr)
//        scanner.charactersToBeSkipped = nil
//        let result = NSMutableString()
//        var temp:String?
//        let newLineAndWhitespaceCharacters = CharacterSet.whitespacesAndNewlines
//        while scanner.isAtEnd == false
//        {
//            temp = ""
//            scanner.scanUpToCharacters(from: newLineAndWhitespaceCharacters, into: NSString(string: temp!))
//            if temp != ""
//            {
//                result.append(temp!)
//            }
//            //替换换行符
//            if scanner.scanCharacters(from: newLineAndWhitespaceCharacters, into: nil) {
//                if result.length > 0 && scanner.isAtEnd == false {
//                    result.append(" ")
//                }
//            }
//            return result as String
//        }
//    }
