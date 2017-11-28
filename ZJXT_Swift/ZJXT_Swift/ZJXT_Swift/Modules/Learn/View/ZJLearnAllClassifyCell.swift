//
//  ZJLearnAllClassifyCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnAllClassifyCell: UICollectionViewCell {
    var model:ZJLearnHomeCourseModel?{
        didSet{
            self.titleLabel.text = model?.courseName
        }
    }
    @IBOutlet weak var bottomLineView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
