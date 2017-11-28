//
//  ZJNavigationController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/21.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJNavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        //注意Info.plist文件view controller -base status bar属性必须为NO,表示启动时候application设置的状态栏优先级高于viewcontroller,同时不会执行preferredStatusBarStyle方法，然后执行代码设置的颜色
        UIApplication.shared.statusBarStyle = .default
        self.navigationBar.setBackgroundImage(UIImage.image(kNavColor), for: UIBarMetrics.default)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        //右滑返回手势
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        //隐藏tabbar
        if self.viewControllers.count > 0
        {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        //在这里设置返回按钮
        let img = IconFontUtils.imageSquare(code: "\u{e679}", size: 20, color: kTabbarBlueColor)
        self.navigationBar.backIndicatorTransitionMaskImage = img
        self.navigationBar.backIndicatorImage = img

        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backItem
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        return self.viewControllers.count > 0
    }

}
