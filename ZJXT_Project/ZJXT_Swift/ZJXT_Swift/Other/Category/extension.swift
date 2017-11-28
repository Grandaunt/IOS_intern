//
//  extension.swift
//  RCSD_Swift
//
//  Created by hxt on 2017/5/11.
//  Copyright © 2017年 runner. All rights reserved.
//

import Foundation
import MBProgressHUD
//模仿oc的colorWithHexString方法
extension UIColor {
    
    class func color(hex:String) ->UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if cString.hasPrefix("0X")
        {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String
{
    static func jsonStringFrom(jsonObject:Any?)->String
    {
        
        let data = try? JSONSerialization.data(withJSONObject: jsonObject!, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = NSString(data: data!, encoding: Encoding.utf8.rawValue)
        return (strJson as String?)!
    }
    
    func base64() -> String
    {
        let data = self.data(using: String.Encoding.utf8)
        
        let base64Str = data?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        
        return base64Str == nil ? "" : base64Str!
        
    }
    
    func md5() -> String
    {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    
    func isNumber() -> Bool
    {
        let number = Double(self)
        if number == nil
        {
            return false
        }
        return true
    }
    
    func formatterPrice() -> String
    {
        let price = Double(self)
        return String(format: "%.2f", price == nil ? "0.00" : price!)
    }
    
    func trimAfterCount() -> Int {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    
    static func safeStr(_ str:String?) ->String
    {
        if str == nil
        {
            return ""
        }
        else
        {
            return str!
        }
    }

}

extension MBProgressHUD{
    //显示信息
    class func show(text:String,icon:String,view:UIView?)
    {
        var hud:MBProgressHUD?
        if view == nil
        {
            hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        }
        else
        {
            hud = MBProgressHUD.showAdded(to: view!, animated: true)
        }
        hud?.label.font = UIFont.systemFont(ofSize: 15)
        hud?.label.text = text
        
        hud?.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/\(icon)"))
        hud?.mode = MBProgressHUDMode.customView
        hud?.removeFromSuperViewOnHide = true
        hud?.hide(animated: true, afterDelay: 0.8)
    }
    
    class func show(error:String,view:UIView?)
    {
        self.show(text: error, icon: "error.png", view: view)
    }
    
    class func show(success:String,view:UIView?)
    {
        self.show(text: success, icon: "success.png", view: view)
    }
    
    @discardableResult
    class func show(message:String,view:UIView?)->MBProgressHUD
    {
        var hud:MBProgressHUD?
        
        if view == nil
        {
            hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        }
        else
        {
            hud = MBProgressHUD.showAdded(to: view!, animated: true)
        }
        hud?.label.text = message
        hud?.label.font = UIFont.systemFont(ofSize: 15)
        hud?.removeFromSuperViewOnHide = true
//        hud?.dimBackground = true
        return hud!
    }
    
    class func show(success:String)
    {
        self.show(message: success, view: nil)
    }
    
    class func show(error:String)
    {
        self.show(error: error, view: nil)
    }
    
    //主要用于成功以后的提醒
    class func show(info:String)
    {
        self.show(error: info, view: nil)
    }

    
    class func show(message:String)
    {
        self.show(message: message, view: nil)
    }
    
    class func hideHUD(for view:UIView?)
    {
        self.hide(for: view!, animated: true)
    }
    
    class func hideHUD()
    {
        self.hideHUD(for: nil)
    }
}

extension UIBarButtonItem
{
    class func item(img:UIImage,target:Any?,action: Selector) -> UIBarButtonItem
    {
        let btn = UIButton(type:.custom)
        btn.setImage(img, for: .normal)
        btn.sizeToFit()
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        let containView = UIView(frame: btn.bounds)
        containView.addSubview(btn)
        
        return UIBarButtonItem(customView: containView)
    }
}

extension UIImage
{    
    class func image(_ color:UIColor) ->UIImage
    {
        return self.image(color: color, size: CGSize(width: 1, height: 1))
    }
    
    class func image(color:UIColor,size:CGSize) ->UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }


}
public extension UIFont
{
    class func systemFont(pxSize:CGFloat) ->UIFont
    {
        let pt = pxSize/(96/72)
        let font = UIFont.systemFont(ofSize: pt)
        return font
    }
    class func systemFont(remSize:CGFloat) -> UIFont
    {
        let pxSize = remSize * 16
        return systemFont(pxSize:pxSize)
    }
    
//    override open class func initialize() {
//        let imp = class_getInstanceMethod(self.classForCoder(), #selector(systemFont(ofSize:)))
//        let myImp = class_getInstanceMethod(self.classForCoder(), #selector(cus_systemFont(ofSize:)))
//        method_exchangeImplementations(imp, myImp)
//    }
//    class func cus_systemFont(ofSize fontSize:CGFloat) -> UIFont
//    {
//        let sizeScale = ((kScreenViewHeight > 568) ? kScreenViewHeight/568 : 1)
//        return cus_systemFont(ofSize: fontSize * sizeScale)
//    }

}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension Array {
    // Code taken from https://stackoverflow.com/a/26174259/1975001
    // Further adapted to work with Swift 2.2
    /// Removes objects at indexes that are in the specified `NSIndexSet`.
    /// - parameter indexes: the index set containing the indexes of objects that will be removed
    public mutating func removeAtIndexes(indexes: NSIndexSet) {
        for i in indexes.reversed() {
            self.remove(at: i)
        }
    }
}

extension Date
{
    //计算指定月天数
    static func getDaysInMonth( year: Int, month: Int) -> Int
    {
        let calendar = Calendar.current
        
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        
        let startDate = calendar.date(from: startComps)!
        let endDate = calendar.date(from: endComps)!
        
        let diff = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return diff.day!
    }
    
    static func getCurrentWeek() -> (startTime:String,endTime:String)
    {
        let date = Date()
        let calendar = Calendar.current
                
        let comp = calendar.dateComponents([Calendar.Component.weekday], from: date)
        let weekDay = comp.weekday
        
        var left = 0  //距离周一差几天
        var right = 0  //距离周天差几天
        
        switch weekDay!
        {
        case 1:  //周天
            left = 6
            right = 0
        case 2:
            left = 0
            right = 6
        case 3:
            left = 1
            right = 5
        case 4:
            left = 2
            right = 4
        case 5:
            left = 3
            right = 3
        case 6:
            left = 4
            right = 2
        case 7://周六
            left = 5
            right = 1
        default:
            break
        }
        
        let leftNum = 24*60*60*left
        let rightNum = 24*60*60*right
        
        let startDate = Date(timeIntervalSinceNow: TimeInterval(-leftNum))
        let endDate = Date(timeIntervalSinceNow: TimeInterval(+rightNum))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return (dateFormatter.string(from: startDate),dateFormatter.string(from: endDate))

        
    }
    
}


//用于广告图
//extension UIApplication{
//    
//    
//    private static let runOnce:Void = {
//        let _ = XHLaunchAdManager.shareManager
//    }()
//    
//    
//    open override var next: UIResponder?{
//        UIApplication.runOnce
//        return super.next
//    }
//}


