//
//  BaseViewController.swift
//  RCSD_Swift
//
//  Created by hxt on 2017/5/11.
//  Copyright © 2017年 runner. All rights reserved.
//

class BaseViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
    }
    
//    override func viewWillAppear(_ animated: Bool)
//    {
//        super.viewWillAppear(animated)
//    }
//    
//    override func viewDidAppear(_ animated: Bool)
//    {
//        super.viewDidAppear(animated)
//    }

    func setNavigationBar(title:String,color:String) -> Void
    {
        self.navigationItem.title = title
        let color = UIColor.color(hex: color)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:color]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
