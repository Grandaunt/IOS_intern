//
//  IconFontUtils.swift
//  IconFont
//
//  Created by User on 2017/7/11.
//  Copyright © 2017年 midmirror. All rights reserved.
//

import UIKit
import Foundation

open class IconFontUtils: NSObject {
    
    static let instance = IconFontUtils.init()
    
    fileprivate var fontName: String = ""
    
    ///** 如果在 info.plist 中增加 Fonts provided by application这一项，就不需要该方法载入字体
    
    //直接调用AppDelegate里调用registerFont方法
    //fontName:第三方字体的名字
    public class func registerFont(_ fontName:String)
    {
        let realIconFontName = fontName + ".ttf"  //真实的字体名
        IconFontUtils.instance.fontName = fontName

        
        let fontPath = Bundle.main.path(forResource: realIconFontName, ofType: nil)
        
        let fileHandle : FileHandle = FileHandle(forReadingAtPath: fontPath!)!
        let data : Data = fileHandle.readDataToEndOfFile()
        
        let provider = CGDataProvider(data: data as CFData)
        let font = CGFont(provider!)
        
        var error: Unmanaged<CFError>?  //Unmanaged类型需要手动管理内容
        //真正注册字体的方法
        if !CTFontManagerRegisterGraphicsFont(font!, &error)
        {
            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            //抛出一个异常
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
    
    //获取图片
    // code:\u{e60a}这种形式
    public class func image(code: String, size: CGSize, color: UIColor) ->UIImage
    {
        let fontSize:CGFloat = size.width > size.height ? size.height : size.width
//        var attributes = [String:Any]()
//        attributes[NSAttributedStringKey.paragraphStyle] = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle //默认段落格式
//        attributes[NSAttributedStringKey.font] = UIFont(name: IconFontUtils.instance.fontName, size: fontSize)
//        attributes[NSAttributedStringKey.foregroundColor] = color
        
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let textRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.setFillColor(color.cgColor)
        
        let fontCode = code as NSString
        fontCode.draw(in: textRect, withAttributes: [NSAttributedStringKey.paragraphStyle:NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle,NSAttributedStringKey.font:UIFont(name: IconFontUtils.instance.fontName, size: fontSize)!,NSAttributedStringKey.foregroundColor:color])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //获取正方形图片
    public class func imageSquare(code: String, size: CGFloat,color: UIColor) ->UIImage
    {
        return image(code: code, size: CGSize(width: size, height: size),color: color)
    }
}
