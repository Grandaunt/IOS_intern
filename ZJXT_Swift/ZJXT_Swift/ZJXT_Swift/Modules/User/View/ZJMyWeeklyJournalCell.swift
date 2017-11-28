//
//  ZJMyWeeklyJournalCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyWeeklyJournalCell: UITableViewCell {

    var model:ZJMyWeeklyJournalModel?{
        didSet{
            self.timeLabel.text = model?.weekReportTime
            self.otherTimeLabel.text = (model?.mondayTime ?? "暂无")  + " - " + (model?.sundayTime ?? "暂无")
            self.companyName.text = UserInfo.shard.companyName
        }
    }
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var otherTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
