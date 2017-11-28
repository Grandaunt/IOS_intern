//
//  ZJMyApplyInfoCell2.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyInfoCell2: UITableViewCell {

    var model:ZJMyApplyHomeModel?{
        didSet{
            self.jobLabel.attributedText = Utils.getAttributeStringWithString(model?.companyPracticePost?.postName ?? "", lineSpace: 3)
            self.cityLabel.text = model?.companyPracticePost?.cityName ?? "无"
            self.startTimeLabel.text = model?.companyPracticePost?.postStartTime
            self.endTimeLabel.text = model?.companyPracticePost?.postEndTime
            self.addressLabel.attributedText = Utils.getAttributeStringWithString(model?.companyInfo?.companyAddress ?? "", lineSpace: 3)
        }
    }
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
