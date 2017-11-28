//
//  ZJHomeInternShipListCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//
//  基地实习、企业实习的列表cell

import UIKit

class ZJHomeInternShipListCell: UITableViewCell {

    var model:ZJBaseListModel?{
        didSet{
//            self.imgView.af_setImage(withURL: URL(string: (model?.imageUrl)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.titleLabel.text = model?.baseName
            self.companyLabel.text = model?.companyName
            self.timeLabel.text = (model?.practicePlan?.planStartTime ?? "") + "~" + (model?.practicePlan?.planEndTime ?? "")


        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
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
