//
//  ZJHomeApplyCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeApplyCell: UITableViewCell
{
    var model:ZJHomeListModel?{
        didSet{
            self.titleLabel.text = model?.noticeName
            self.infoLabel.text = model?.noticeDescription
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
