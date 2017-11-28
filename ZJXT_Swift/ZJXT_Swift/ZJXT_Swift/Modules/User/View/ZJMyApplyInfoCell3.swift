//
//  ZJMyApplyInfoCell3.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyInfoCell3: UITableViewCell {
    
    var model:ZJMyApplyHomeModel?{
        didSet{
            self.nameLabel.text = model?.companyInfo?.companyContacts
            self.mobileLabel.text = model?.companyInfo?.companyTel ?? "暂无"
        }
    }
    
    var mobileAction:((String)->Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func mobileBtnClicked(_ sender: UIButton)
    {
        if self.model?.companyInfo?.companyTel != nil
        {
            if self.mobileAction != nil
            {
                self.mobileAction!((self.model?.companyInfo?.companyTel)!)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
