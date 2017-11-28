//
//  ZJLearnSearchResultCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/21.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnSearchResultCell: UITableViewCell {

    var model:ZJLearnCourseVideoModel?{
        didSet{
            self.imgView.af_setImage(withURL: URL(string: (model?.videoImage)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.nameLabel.text = model?.videoName
            let leftStr = "课时" + (model?.orderNum ?? "")
            self.subtitleLabel.text = leftStr
            self.infoLabel.text = model?.summary
        }
    }
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
