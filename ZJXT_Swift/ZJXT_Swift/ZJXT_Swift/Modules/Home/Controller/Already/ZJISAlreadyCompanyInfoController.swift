//
//  ZJISAlreadyCompanyInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyCompanyInfoController: SecondViewController
{
    @IBOutlet var companyInfoBtn: UIButton!
    @IBOutlet var groupInfoBtn: UIButton!
    @IBOutlet var companyInfoLabel: UILabel!
    @IBOutlet var groupInfoLabel: UILabel!
    
    @IBAction func companyInfoBtnClicked(sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        if sender.isSelected
        {
            self.companyInfoLabel.numberOfLines = 0
        }
        else
        {
            self.companyInfoLabel.numberOfLines = 2
        }
    }
    @IBAction func groupBtnClicked(sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        if sender.isSelected
        {
            self.groupInfoLabel.numberOfLines = 0
        }
        else
        {
            self.groupInfoLabel.numberOfLines = 2
        }

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
