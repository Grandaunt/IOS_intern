//
//  ZJHomeInternshipJobCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeInternshipJobCell: UITableViewCell {

    var model:ZJInternshipJobModel?{
        didSet{
            if model?.companyInfo?.companyIcon == nil
            {
                self.imgView.image = kUserLogoPlaceHolder
            }
            else
            {
                self.imgView.af_setImage(withURL: URL(string: (model?.companyInfo?.companyIcon)!)!, placeholderImage: kUserLogoPlaceHolder)

            }
            self.jobLabel.text = model?.postName
            self.companyLabel.text = model?.companyInfo?.companyName
            self.timeLabel.text = model?.postStartTime
            self.moneyLabel.text = model?.postMoney
            
            if model?.postType == "1"
            {
                let str = "实习|" + (model?.intentionTrade ?? "") + (model?.postNum ?? "0")
                self.infoLabel.text = str + "人"
            }
            else
            {
                let str = "全职|" + (model?.intentionTrade ?? "") + (model?.postNum ?? "0")
                self.infoLabel.text = str + "人"
            }
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
