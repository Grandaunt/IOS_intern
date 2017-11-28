//
//  ZJApplyPostCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/23.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJApplyPostCell: UITableViewCell {

    var model:ZJBasePostModel?{
        didSet{
            self.postNameLabel.text = "职位名称：" + (model?.postName ?? "")
            self.numberLabel.text = "招聘人数：" + (model?.postNum ?? "0") + "人"
            self.moneyLabel.text = "公司待遇：" + (model?.postPay ?? "")
            
            let firstStr = "职位要求：" + (model?.postOrder ?? "")
            self.firstLabel.attributedText = Utils.getAttributeStringWithString(firstStr, lineSpace: 3)
            
            let secStr = "岗位职责：" + (model?.postDes ?? "")
            self.secondLabel.attributedText = Utils.getAttributeStringWithString(secStr, lineSpace: 3)
            
            let thirdStr = "公司福利：" + (model?.postDes ?? "")
            self.thirdLabel.attributedText = Utils.getAttributeStringWithString(thirdStr, lineSpace: 3)
        }
    }
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
