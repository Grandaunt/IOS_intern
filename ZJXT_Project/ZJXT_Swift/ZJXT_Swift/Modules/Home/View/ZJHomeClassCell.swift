//
//  ZJHomeClassCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeClassCell: UITableViewCell {

    var tapAction:((Int)->Void)?

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnClicked(_ sender: UIButton)
    {
        if self.tapAction != nil
        {
            self.tapAction!(sender.tag)
        }
    }

}
