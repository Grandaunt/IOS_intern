//
//  ZJHomeBaseInternShipInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//
//  基地实习详情

import UIKit

class ZJHomeBaseInternShipInfoController: SecondViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()

    }
    
    fileprivate func initNav()
    {
        let img = IconFontUtils.imageSquare(code: "\u{e7f1}", size: 20, color: UIColor.color(hex: "#929292")).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let rightItem = UIBarButtonItem(image: img, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightItem
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
