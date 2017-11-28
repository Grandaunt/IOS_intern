//
//  ZJHomeApplyFormCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

enum ZJHomeApplyFormType:Int
{
    case info = 0
    case input
    case none
}

class ZJHomeApplyFormCell: UITableViewCell
{
    var type:ZJHomeApplyFormType?{
        didSet{
            if type == .info
            {
                self.field.isHidden = true
                self.rightImg.isHidden = false
                self.infoLabel.isHidden = false
            }
            else if type == .input
            {
                self.field.isHidden = false
                self.rightImg.isHidden = true
                self.infoLabel.isHidden = true
            }
            else
            {
                self.field.isHidden = true
                self.rightImg.isHidden = true
                self.infoLabel.isHidden = true

            }
            

        }
    }

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.rightImg.image = IconFontUtils.imageSquare(code: "\u{e6a3}", size: 15, color: UIColor.lightGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
