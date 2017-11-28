//
//  ZJVCAddExperienceCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJVCAddExperienceCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.backView.layer.borderWidth = 0.5
        self.backView.layer.borderColor = kTabbarBlueColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
