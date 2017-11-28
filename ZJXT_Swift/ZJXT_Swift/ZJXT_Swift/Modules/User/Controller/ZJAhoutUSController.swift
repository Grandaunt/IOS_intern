//
//  ZJAhoutUSController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/10.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJAhoutUSController: SecondViewController {

    @IBOutlet weak fileprivate var imgView: UIImageView!
    @IBOutlet weak fileprivate var titleLabel: UILabel!
    
    @IBOutlet weak fileprivate var versionLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let str = "你 有 什 么 样 的 梦 想\n决定了你在什么样的位置"
        
        let attrStr = NSMutableAttributedString(string: str)
        
        let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        ps.lineSpacing = 10
        attrStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: ps, range: NSRange(location: 0, length: attrStr.length))
        self.titleLabel.attributedText = attrStr
        self.versionLabel.text = "当前版本：" + self.getLocalVersion()
    }
    
    fileprivate func getLocalVersion() -> String
    {
        let infoDic = Bundle.main.infoDictionary
        let localVerison = infoDic?["CFBundleShortVersionString"] as! String
        return localVerison
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
