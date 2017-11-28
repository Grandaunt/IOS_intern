//
//  ZJMyLogCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyLogCell: UITableViewCell {

    var model:ZJMyLogModel?{
        didSet{
            self.timeLabel.text = model?.dayReportTime
            self.companyLabel.text = UserInfo.shard.companyName
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var commitBtn: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.commitBtn.setImage(IconFontUtils.imageSquare(code: "\u{e657}", size: 15, color: kTabbarBlueColor), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
