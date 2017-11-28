//
//  ZJWorkExperienceListCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/14.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJWorkExperienceListCell: UITableViewCell {

    var editExperienceAction:(()->Void)?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editBtnClicked(_ sender: UIButton)
    {
        if self.editExperienceAction != nil
        {
            self.editExperienceAction!()
        }
    }
    
}
