//
//  ZJLearnHomeClassCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/20.
//  Copyright © 2017年 runer. All rights reserved.
//
//  在线学习主页的分类

import UIKit

class ZJLearnHomeClassCell: UICollectionViewCell {
    
    var model:ZJLearnHomeClassModel?{
        didSet{
            if model?.img != nil
            {
                self.imgVIew.image = model?.img
            }
            else
            {
                self.imgVIew.af_setImage(withURL: URL(string: (model?.listIcon)!)!, placeholderImage: UIImage(named:"learn_all_category"))
            }
            self.titleLabel.text = model?.categoryName
        }
    }
    @IBOutlet weak var imgVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
