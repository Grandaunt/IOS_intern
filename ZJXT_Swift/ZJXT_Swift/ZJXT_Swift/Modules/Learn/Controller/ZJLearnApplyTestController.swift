//
//  ZJLearnApplyTestController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/18.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class ZJLearnApplyTestController: SecondViewController
{

    var urlStr:String?
    var htmlStr:String?
    
    fileprivate var webView = WKWebView()
    
    //网页进度条
    fileprivate var progressView:UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 44-2, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = kTabbarBlueColor
        return progressView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = kBackgroundColor
        self.navigationController?.navigationBar.addSubview(self.progressView)
        
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-49)
        }
        
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 2
        btn.backgroundColor = kTabbarBlueColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle("申请考试", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(apply), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*2)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*2)
            make.bottom.equalToSuperview().offset(-7)
            make.height.equalTo(35)
        }
        
        //添加观察者
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        if self.urlStr != nil
        {
            let request = URLRequest(url: URL(string: self.urlStr!)!)
            self.webView.load(request)
        }
        
        if self.htmlStr != nil
        {
            self.webView.loadHTMLString(self.htmlStr!, baseURL: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.progressView.removeFromSuperview()
    }
    
    @objc fileprivate func apply()
    {
        MBProgressHUD.show(info: "已提交申请")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if (keyPath == "estimatedProgress")
        {
            self.progressView.isHidden = webView.estimatedProgress == 1
            self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    //网页加载完成时
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        self.progressView.setProgress(0.0, animated: false)
        //        self.navigationItem.title = webView.title
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.progressView.reloadInputViews()
    }
}
