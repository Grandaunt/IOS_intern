//
//  ZJISAlreadySignInView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//
//  已签到的弹窗视图

import UIKit

class ZJISAlreadySignInView: UIView
{
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var alertView:UIView = {[weak self] in
        let alertView = UIView()
        alertView.center = (self?.center)!
        alertView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 4
        return alertView
    }()

    
    //注意：传入的contentView必须设置了frame
    convenience init(attr:NSMutableAttributedString?)
    {
        let window = UIApplication.shared.keyWindow
        self.init(frame: (window?.bounds)!)
        if attr != nil
        {
            self.titleLabel.attributedText = attr!
        }
        
    }
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.alertView)
        self.alertView.snp.makeConstraints { (make) in
            make.width.equalTo(238)
            make.center.equalToSuperview()
            make.height.equalTo(88)
        }
        
        self.alertView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    private func hide()
    {
        let controller = Utils.getCurrentVC()
        for view in (controller?.navigationController?.view.subviews)!.reversed()
        {
            if view is ZJISAlreadySignInView
            {
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }, completion: { (finished) in
                    view.removeFromSuperview()
                })
                break
            }
        }
    }
    
    class func hidden()
    {
        let controller = Utils.getCurrentVC()
        for view in (controller?.navigationController?.view.subviews)!.reversed()
        {
            if view is ZJISAlreadySignInView
            {
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }, completion: { (finished) in
                    view.removeFromSuperview()
                })
                break
            }
        }

    }
    
    class func show(title:NSMutableAttributedString?)
    {
        //如果添加到window上，能保证在最上层，但是如果present时该视图没消失，那么该视图还是在最上层
        //        let window = UIApplication.shared.keyWindow
        //        let alertView = TMAlertView(title: title, contentView: contentView)
        //        alertView.alpha = 0
        //        window?.addSubview(alertView)
        //        alertView.snp.makeConstraints { (make) in
        //            make.edges.equalToSuperview()
        //        }
        //        UIView.animate(withDuration: 0.3) {
        //            alertView.alpha = 1
        //        }
        
        let controller = Utils.getCurrentVC()
        
        let alertView = ZJISAlreadySignInView(attr:title)
//        alertView.titleLabel.attributedText = title
        alertView.alpha = 0
        controller?.navigationController?.view?.addSubview(alertView)
        alertView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        UIView.animate(withDuration: 0.3) {
            alertView.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.hidden()
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
