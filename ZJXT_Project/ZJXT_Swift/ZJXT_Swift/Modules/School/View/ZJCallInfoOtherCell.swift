//
//  ZJCallInfoOtherCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/11.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCallInfoOtherCell: UITableViewCell {

    var model:ZJCirclePraiseModel?{
        didSet{
            if model?.logo == nil
            {
                self.imgView.image = kUserLogoPlaceHolder
            }
            else
            {
                self.imgView.af_setImage(withURL: URL(string: (model?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)

            }
            self.titleLabel.text = model?.nickName
        }
    }
    
    var applyModel:ZJCircleApplyModel?{
        didSet{
            if applyModel?.logo == nil
            {
                self.imgView.image = kUserLogoPlaceHolder
            }
            else
            {
                self.imgView.af_setImage(withURL: URL(string: (applyModel?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)

            }
            self.titleLabel.text = applyModel?.nickName
            self.telLabel.text = applyModel?.mobile
        }
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
