//
//  AppDelegate.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/6.
//  Copyright © 2017年 runer. All rights reserved.
//

import IQKeyboardManager
import IQKeyboardManagerSwift
import AlamofireNetworkActivityIndicator

public let kKeyfirstLoadG = "firstLoadG"  //记录第一次登录
fileprivate let kValueIsFirst = "isFirst"      //是第一次登录

@UIApplicationMain
class AppDelegate: UIResponder
{

    var window: UIWindow?
    var tbc:UITabBarController?
    
    private var guideWindow:UIWindow?
    
    //设置bar
    fileprivate func configApprearence()
    {
        let nav = UINavigationBar.appearance()
        nav.barTintColor = kNavColor
        nav.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.color(hex: "#333333"),NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)]
        nav.isTranslucent = false

        //设置导航栏的黑边
        //(注意)如果想设置黑边的颜色，必须先设置backgroundImage，不然没有效果
//        nav.setBackgroundImage(UIImage.image(color: kNavColor, size: CGSize(width: kScreenViewWidth, height: 1)), for: .default)
//        nav.shadowImage = UIImage.image(color: kNavLineColor, size: CGSize(width: kScreenViewWidth, height: 1))
        
        let allTabbar = UITabBar.appearance()
        allTabbar.isTranslucent = false
        allTabbar.shadowImage = UIImage()
        
        //设置tabbar的选中字体颜色 unselectedItemTintColor是未选中的字体颜色，但是只能ios10以后使用
//        allTabbar.tintColor = kTabbarBlueColor;
        //只能通过这种方式设置未选中的字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:kTabbarGrayColor],for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:kTabbarBlueColor],for: .selected)
    }
    
    open func initTabBarController()
    {
        
        if UserInfo.isLogin()
        {
            self.tbc = UITabBarController()
            let to0VC = ZJHomeController()
            let tab0VC = ZJNavigationController(rootViewController: to0VC)
            
            let to1VC = ZJLearnHomeController()
            let tab1VC = ZJNavigationController(rootViewController: to1VC)
            
            let to2VC = ZJSchoolHomeController()
            let tab2VC = ZJNavigationController(rootViewController: to2VC)
            
            let to3VC = ZJUserHomeController()
            let tab3VC = ZJNavigationController(rootViewController: to3VC)
            
            self.tbc?.viewControllers = [tab0VC,tab1VC,tab2VC,tab3VC]
            
            self.window?.rootViewController = self.tbc
            self.tbc?.selectedIndex = 0
            
            for (index,value) in (self.tbc?.tabBar.items?.enumerated())!
            {
                let normalImage = UIImage(named: String("tabbar\(index)_unselect"))
                value.image = normalImage;
                let selectedImage = UIImage(named: String("tabbar\(index)_select"))
                value.selectedImage = selectedImage
                switch index
                {
                case 0:
                    value.title = "主页"
                case 1:
                    value.title = "在线学习"
                case 2:
                    value.title = "校园圈子"
                case 3:
                    value.title = "我的"
                default:break
                }
            }
        }
        else
        {
            let loginVC = ZJLoginController()
            loginVC.navTitle = "登录"
            loginVC.loginSuccessAction = {
                self.initTabBarController()
            }
            let nav = ZJNavigationController(rootViewController: loginVC)
            
            self.window?.rootViewController = nav
        }
        
        
    }
    
    fileprivate func setStaticGuidePage()
    {
        self.guideWindow = UIWindow(frame: UIScreen.main.bounds)
        self.guideWindow?.rootViewController = UIViewController()
        self.guideWindow?.rootViewController?.view.backgroundColor = UIColor.white
        self.guideWindow?.rootViewController?.view.isUserInteractionEnabled = false
        self.guideWindow?.windowLevel = UIWindowLevelStatusBar + 2;
        self.guideWindow?.isHidden = false
        self.guideWindow?.alpha = 1
        let imageArray = ["guideImage1.png","guideImage2.png","guideImage3.png"];
        let guidePage = DHGuidePageHUD(frame: (self.guideWindow?.frame)!, imageNameArray: imageArray, buttonIsHidden: false)
        guidePage?.delegate = self;
        self.guideWindow?.addSubview(guidePage!)
    }
}

extension AppDelegate:UIApplicationDelegate,DHGuidePageHUDDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        application.applicationIconBadgeNumber = 0
        
        self.initTabBarController()
        self.configApprearence()
        
        //初始化IQKeyboardManager
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false;
        
        //载入IconFont
        IconFontUtils.registerFont("iconfont")
        
        //初始化网络加载指示器
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 1.0
        NetworkActivityIndicatorManager.shared.completionDelay = 0.2
        
        //这里考虑用全局变量，但是必须声明成var，所以未改
        if UserDefaults.standard.object(forKey: kKeyfirstLoadG) == nil
        {
            _ = UserInfo.delete()   //首次登录需要把keyChain的数据删除
            UserDefaults.standard.set(kValueIsFirst, forKey: kKeyfirstLoadG)
            UserDefaults.standard.synchronize()
            self.setStaticGuidePage()
        }
                
        self.window?.makeKeyAndVisible()

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication)
    {

    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {

    }
    
    func applicationWillEnterForeground(_ application: UIApplication)
    {

    }
    
    func applicationDidBecomeActive(_ application: UIApplication)
    {

    }
    
    func applicationWillTerminate(_ application: UIApplication)
    {

    }
    
    func dhGuidePageHUDHideAction(_ hud: DHGuidePageHUD!)
    {
        UIView.animate(withDuration: 2.0, animations: {
            self.guideWindow?.alpha = 0
        }) { (finished) in
            self.guideWindow?.removeFromSuperview()
            self.guideWindow = nil;
        }
    }

}

