//
//  ZJLearnCourseInfoCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//
//  为你推荐的

import UIKit

class ZJLearnCourseInfoCell: UITableViewCell {

    var model:ZJLearnCourseDescription?{
        didSet{
            self.imgView.af_setImage(withURL: URL(string: (model?.descriptionImage)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.titleLabel.text = model?.descriptionName
            self.infoLabel.text = model?.categoryName
            self.numLabel.text = "浏览" + (model?.visitNum ?? "0")
            self.timeLabel.text = model?.createTime
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var numLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
