//
//  ZJVCUserLogoCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJVCUserLogoCell: UITableViewCell {

    var imgTapAction:(()->Void)?
    
    @IBOutlet weak var logoImgView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.logoImgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap))
        self.logoImgView.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func imgTap()
    {
        if self.imgTapAction != nil
        {
            self.imgTapAction!()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
