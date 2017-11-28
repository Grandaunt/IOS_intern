//
//  ZJMyQuestionCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyQuestionCell: UITableViewCell {

    var model:ZJMyQuestionModel?{
        didSet{
            self.timeLabel.text = model?.questionTime
            self.companyLabel.text = UserInfo.shard.companyName
            self.questionLabel.text = model?.questionTitle
            if (model?.questionAnswerList?.count)! > 1
            {
                self.stateLabel.text = "已回复"
                self.stateLabel.textColor = kTabbarBlueColor
            }
            else
            {
                self.stateLabel.text = "未回复"
                self.stateLabel.textColor = UIColor.color(hex: "#929292")
            }
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
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
