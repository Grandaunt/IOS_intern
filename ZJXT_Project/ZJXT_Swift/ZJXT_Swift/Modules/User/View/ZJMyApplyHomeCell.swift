//
//  ZJMyApplyHomeCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyHomeCell: UITableViewCell
{

    var model:ZJMyApplyHomeModel?{
        didSet{
            
            self.logoImgView.af_setImage(withURL: URL(string: (model?.companyInfo?.companyIcon)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.companyLabel.text = model?.companyInfo?.companyName
            self.timeLabel.text = model?.applyTime
            self.otherTimeLabel.text = "审批时间：" + (model?.checkTime ?? "")
            self.persionLabel.text = "审批人：" + (model?.checker ?? "")
            self.persionLabel.isHidden = true
            
            if model?.applyType == "1"
            {
                self.typeLabel.text = "申请类别：实习"
            }
            else
            {
                self.typeLabel.text = "申请类别：全职"
            }
            
            if model?.applyStatus == "1"
            {
                self.stateLabel.text = "正在审核"
                self.stateLabel.textColor = UIColor.color(hex: "#40afff")

            }
            else if model?.applyStatus == "2"
            {
                self.stateLabel.text = "进入面试"
                self.stateLabel.textColor = UIColor.color(hex: "#ed7f2e")

            }
            else if model?.applyStatus == "3"
            {
                self.stateLabel.text = "面试成功"
                self.stateLabel.textColor = UIColor.color(hex: "#ff3d3d")

            }
            else
            {
                self.stateLabel.text = "申请驳回"
                self.stateLabel.textColor = UIColor.color(hex: "#2cb95a")
            }

        }
    }
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var otherTimeLabel: UILabel!
    @IBOutlet weak var persionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
