//
//  ZJLearnHomeVideoCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnHomeVideoCell: UICollectionViewCell {

    var model:ZJLearnHomeCourseModel?{
        didSet{
            self.imgView.af_setImage(withURL: URL(string: (model?.listViewImageUrl)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.nameLabel.text = model?.courseName
            self.schoolLabel.text = model?.comeFrom
            self.numBtn.setTitle(model?.visitePresonNum, for: .normal)
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var numBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
