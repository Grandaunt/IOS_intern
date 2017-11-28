//
//  ZJISAlreadyHomeCompanyCel.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJISAlreadyHomeCompanyCell: UITableViewCell {

    var model:ZJUserHasPracticeModel?{
        didSet{
            if model?.companyLogo == nil
            {
                self.imgView.image = kUserLogoPlaceHolder
            }
            else
            {
                self.imgView.af_setImage(withURL: URL(string: (model?.companyLogo)!)!, placeholderImage: kUserLogoPlaceHolder)
                
            }
            self.imgView.image = kUserLogoPlaceHolder
            self.nameLabel.text = model?.companyName
            let str = "实习时间：" + (model?.basePlanStartTime ?? "")
            self.timeLabel.text = str + "~" + (model?.basePlanEndTime ?? "")
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
