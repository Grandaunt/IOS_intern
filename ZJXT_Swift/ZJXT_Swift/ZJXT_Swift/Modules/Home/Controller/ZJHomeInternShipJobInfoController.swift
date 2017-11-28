//
//  ZJHomeInternShipJobInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeInternShipJobInfoController: SecondViewController
{

    var model:ZJInternshipJobModel?
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postMoneyLabel: UILabel!
    @IBOutlet weak var needNumLabel: UILabel!
    @IBOutlet weak var workAddressLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
    }
    
    fileprivate func initView()
    {
        self.logoImgView.af_setImage(withURL: URL(string: (self.model?.companyInfo?.companyIcon)!)!, placeholderImage: kUserLogoPlaceHolder)
        self.postLabel.text = self.model?.postName
        self.companyLabel.text = self.model?.companyInfo?.companyName
        self.timeLabel.text = (self.model?.postStartTime ?? "") + "~" + (self.model?.postEndTime ?? "")
        self.postMoneyLabel.text = self.model?.postMoney
        self.needNumLabel.text = (self.model?.postNum ?? "0") + "人"
        self.workAddressLabel.text = self.model?.position
        self.startTimeLabel.text = "开始时间：" + (self.model?.postStartTime ?? "")
        self.endTimeLabel.text = "结束时间：" + (self.model?.postEndTime ?? "")
        self.contactLabel.text = "联系人:" + (self.model?.companyInfo?.companyContacts ?? "")
        self.phoneBtn.setTitle(self.model?.companyInfo?.companyTel, for: .normal)
        self.infoLabel.attributedText = Utils.getAttributeStringWithString(self.model?.postDes ?? "", lineSpace: 3)

    }
    
    fileprivate func initNav()
    {
        let img = IconFontUtils.imageSquare(code: "\u{e7f1}", size: 20, color: UIColor.color(hex: "#929292")).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let rightItem = UIBarButtonItem(image: img, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightItem
    }

    @IBAction func applyBtnClicked(_ sender: UIButton)
    {
        let toVC = ZJVCHomeController()
        toVC.navTitle = "我的简历"
        toVC.isFromIndiv = false
        toVC.postId = self.model?.postId
        toVC.applyType = self.model?.postType
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
