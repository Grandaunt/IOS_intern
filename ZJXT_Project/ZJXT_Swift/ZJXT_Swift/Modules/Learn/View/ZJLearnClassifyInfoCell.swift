//
//  ZJLearnSearchResultCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/21.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnClassifyInfoCell: UITableViewCell {
    var model:ZJLearnHomeCourseModel?{
        didSet{
            self.imgView.af_setImage(withURL: URL(string: (model?.listViewImageUrl)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.titleLabel.text = model?.courseName
            self.infoLabel.text = model?.comeFrom
            self.numBtn.setTitle(model?.visitePresonNum, for: .normal)
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var numBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
