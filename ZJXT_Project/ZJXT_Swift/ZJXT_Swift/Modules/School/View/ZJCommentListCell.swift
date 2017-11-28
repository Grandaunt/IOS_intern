//
//  ZJCommentListCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCommentListCell: UITableViewCell {

    var model:ZJCircleCommentSubModel?{
        didSet{
            if model?.logo == nil
            {
                self.imgView.image = kUserLogoPlaceHolder
            }
            else
            {
                self.imgView.af_setImage(withURL: URL(string: (model?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)
            }
            self.nameLabel.text = model?.nickName
            self.timeLabel.text = model?.commentTime
            
            if model?.toNickName != nil
            {
                var nameStr = "回复" + (model?.toNickName ?? "") + ":"
                nameStr.append(model?.comment ?? "")
                let attrStr = NSMutableAttributedString(string: nameStr)
                let range = (nameStr as NSString).range(of: (model?.toNickName ?? ""))
                
                attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: kTabbarBlueColor, range: range)
                
                let paragraphStye = NSMutableParagraphStyle()
                //调整行间距
                paragraphStye.lineSpacing = 3
                let rang = NSMakeRange(0, CFStringGetLength(nameStr as CFString!))
                attrStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStye, range: rang)
                
                self.infoLabel.attributedText = attrStr
                
            }
            else
            {
                self.infoLabel.attributedText = Utils.getAttributeStringWithString((model?.comment ?? ""), lineSpace: 3)
            }
        }
    }
    
    var thumAction:(()->Void)?

    @IBOutlet weak var thumBtn: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBAction func thumBtnClicked(_ sender: Any)
    {
        if self.thumAction != nil
        {
            self.thumAction!()
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
