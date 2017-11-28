//
//  SecondViewController.swift
//  RCSD_Swift
//
//  Created by hxt on 2017/5/11.
//  Copyright © 2017年 runner. All rights reserved.
//

import MarqueeLabel
import MarqueeLabelSwift

typealias NavDimissAction = () -> Void

private let TitleViewMaxHeight:CGFloat = 34
private let TitleViewMaxWidth:CGFloat = scaleWidth(width: 170)  // 如果过大，会盖住右边的按钮(店铺详情)


class SecondViewController: BaseViewController
{

    var navDismissAction:NavDimissAction?
    var navTitle:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.subviews.first?.alpha = 1;
        self.initSecondNavBar(title: self.navTitle)
    }
    
    func initSecondNavBar(title:String)
    {
//        let backBuuton = UIButton(type: .custom)
//        backBuuton.frame = CGRect(x: 0, y: 3, width: 30, height: 30)
//        backBuuton.addTarget(self, action: #selector(backUP), for: .touchUpInside)
//        let image = UIImageView(frame: CGRect(x: 0, y: 4, width: 20, height: 20))
//        image.image = IconFontUtils.imageSquare(code: "\u{e679}", size: 20, color: kTabbarBlueColor)
//        backBuuton.addSubview(image)
//        
//        let left = UIBarButtonItem(customView: backBuuton)
//        //调整位置，以防往右偏移
//        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        spaceItem.width = -10
//        self.navigationItem.leftBarButtonItems = [spaceItem,left]
        
        let width:CGFloat = Utils.sizeText(text: title, font: UIFont.systemFont(ofSize: 17), maxSize: CGSize(width: CGFloat(MAXFLOAT), height: TitleViewMaxHeight)).width
        
        var label:UILabel?
        
        if width <= TitleViewMaxWidth
        {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 5, width: width, height: TitleViewMaxHeight))
            titleLabel.textColor = UIColor.color(hex: "#333333")
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            titleLabel.textAlignment = .center
            label = titleLabel
        }
        else
        {
            let titleLabel = MarqueeLabel(frame: CGRect(x: 0, y: 5, width: TitleViewMaxWidth, height: TitleViewMaxHeight))
            titleLabel?.textColor = UIColor.color(hex: "#333333")
            titleLabel?.text = title
            titleLabel?.font = UIFont.systemFont(ofSize: 17)
            titleLabel?.textAlignment = .center
            titleLabel?.marqueeType = .MLContinuous
            titleLabel?.scrollDuration = 10.0
            titleLabel?.isUserInteractionEnabled = false
            label = titleLabel
        }
        self.navigationItem.titleView = label;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backUP()
    {
        if self.navDismissAction != nil {
            self.navDismissAction!()
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) 已经释放")
        #endif
    }
}
