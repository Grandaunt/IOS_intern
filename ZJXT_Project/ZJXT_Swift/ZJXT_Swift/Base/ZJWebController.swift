//
//  ZJWebController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import WebKit

class ZJWebController: SecondViewController
{
    var urlStr:String?
    
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
            make.edges.equalToSuperview()
        }
        //添加观察者
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        if self.urlStr != nil
        {
            let request = URLRequest(url: URL(string: self.urlStr!)!)
            self.webView.load(request)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.progressView.removeFromSuperview()
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
