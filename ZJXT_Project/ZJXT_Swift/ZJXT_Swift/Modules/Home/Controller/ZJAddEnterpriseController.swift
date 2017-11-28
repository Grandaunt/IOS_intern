//
//  ZJAddEnterpriseController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/24.
//  Copyright © 2017年 runer. All rights reserved.
//
//  添加企业

import UIKit
import MBProgressHUD

class ZJAddEnterpriseController: SecondViewController
{

    var saveAction:((ZJInternshipJobModel)->Void)?
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
    }
    
    fileprivate func initNav()
    {
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func save()
    {
        if self.firstField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写企业名称")
            return
        }
        if self.secondField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写企业联系人")
            return
        }
        if self.thirdField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写企业电话")
            return
        }
        if self.fourField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写实习岗位")
            return
        }

        if self.saveAction != nil
        {
            let model = ZJInternshipJobModel()
            model.companyInfo = ZJInternshipCompanyModel()
            model.companyInfo?.companyName = self.firstField.text
            model.companyInfo?.companyContacts = self.secondField.text
            model.companyInfo?.companyTel = self.thirdField.text
            model.postName = self.fourField.text
            self.saveAction!(model)
            self.navigationController?.popViewController(animated: true)
        }
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
