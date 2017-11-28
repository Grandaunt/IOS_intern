//
//  ZJAddCallTagAddController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/9.
//  Copyright © 2017年 runer. All rights reserved.
//
//  添加标签

import UIKit

class ZJAddCallTagAddController: SecondViewController
{
    var addAction:((String)->Void)?
    
    fileprivate lazy var textFiled:UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 40)
        field.placeholder = "输入你的标签"
        return field
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
    }
    
    fileprivate func initNav()
    {
        let rightItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func add()
    {
        if self.addAction != nil
        {
            self.addAction!(self.textFiled.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }

    fileprivate func initView()
    {
        self.view.addSubview(self.textFiled)
        self.textFiled.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(25)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.color(hex: "#cccccc")
        self.view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.textFiled)
            make.height.equalTo(1)
            make.top.equalTo(self.textFiled.snp.bottom).offset(15)
        }
        
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#929292")
        label.text = "自定义标签最多8个字"
        label.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.textFiled)
            make.top.equalTo(line.snp.bottom).offset(25)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
