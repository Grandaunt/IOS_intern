//
//  ZJHomeRecruitCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeRecruitCell: UITableViewCell {
    var model:ZJHomeListModel?{
        didSet{
            self.titleLabel.text = model?.noticeName
            self.timeLabel.text = model?.noticeDescription
            self.imgView.af_setImage(withURL: URL(string: (model?.imageUrl)!)!, placeholderImage: kUserLogoPlaceHolder)
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
