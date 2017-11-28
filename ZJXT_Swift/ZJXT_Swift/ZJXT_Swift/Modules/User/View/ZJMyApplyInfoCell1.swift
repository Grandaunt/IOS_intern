//
//  ZJMyApplyInfoCell1.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyInfoCell1: UITableViewCell {

    var model:ZJMyApplyHomeModel?{
        didSet{
            self.companyLabel.text = model?.companyInfo?.companyName
            self.applyTime.text = model?.applyTime
            self.reviewLabel.text = model?.checkTime
            self.persionLabel.text = model?.checker
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
            self.adviceLabel.text = model?.checkDes ?? "无"
        }
    }
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var persionLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var applyTime: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
