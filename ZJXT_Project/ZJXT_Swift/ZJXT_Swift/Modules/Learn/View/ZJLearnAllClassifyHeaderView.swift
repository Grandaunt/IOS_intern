//
//  ZJLearnAllClassifyHeaderView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnAllClassifyHeaderView: UICollectionReusableView {

    var model:ZJLearnHomeClassModel?{
        didSet{
            self.titleLabel.text = model?.categoryName
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
