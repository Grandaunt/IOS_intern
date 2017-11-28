//
//  LoginInputTextField.swift
//  RCSD_Swift
//
//  Created by hxt on 2017/5/12.
//  Copyright © 2017年 runner. All rights reserved.
//
//  登录界面的输入框

import UIKit

class LoginInputTextField: UITextField {
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var iconRect = super.leftViewRect(forBounds: bounds)
        iconRect.origin.x = iconRect.origin.x + 15
//        iconRect.size.width = iconRect.size.width - 3
//        iconRect.size.height = iconRect.size.height - 3
        return iconRect
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 35, y: 0, width: bounds.size.width, height: bounds.size.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 35, y: 0, width: bounds.size.width, height: bounds.size.height)
    }
}
