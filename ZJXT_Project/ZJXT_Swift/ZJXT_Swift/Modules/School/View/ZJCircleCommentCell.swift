//
//  ZJCircleCommentCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCircleCommentCell: UITableViewCell {

    var model:ZJCircleCommentModel?{
        didSet{
            self.imgView.af_setImage(withURL: URL(string: (model?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.nameLabel.text = model?.nickName
            self.infoLabel.attributedText = Utils.getAttributeStringWithString(model?.comment ?? "", lineSpace: 3)
            self.timeLabel.text = model?.commentDate
            self.thumBtn.isSelected = model?.isPraise == "YES" ? true : false
            self.thumBtn.setTitle(model?.praiseNumber, for: .normal)
            
            if model?.commentNumber == "0"
            {
                self.backView.isHidden = true
                self.backView.snp.remakeConstraints({ (make) in
                    make.top.equalTo(self.infoLabel.snp.bottom)
                    make.left.right.equalTo(self.infoLabel)
                    make.height.equalTo(0)
                })
            }
            else
            {
                self.backView.isHidden = false
                self.backView.snp.remakeConstraints({ (make) in
                    make.top.equalTo(self.infoLabel.snp.bottom).offset(kHomeEdgeSpace)
                    make.left.right.equalTo(self.infoLabel)
                    make.height.equalTo(30)
                })
                
                let str = (model?.firstSubCommentName ?? " ") + "等人"
                let range = (str as NSString).range(of: (model?.firstSubCommentName ?? " "))
                let attrStr = NSMutableAttributedString(string: str)
                attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: kTabbarBlueColor, range: range)
                self.firstNameLabel.attributedText = attrStr
                
                self.numBtn.setTitle("共\(model?.commentNumber ?? "0")条回复>", for: .normal)
            }
        }
    }
    
    var jumpCommentListAction:(()->Void)?
    var commentAction:(()->Void)?
    var thumAction:(()->Void)?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var numBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thumBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func numBtnClicked(_ sender: Any)
    {
        if self.jumpCommentListAction != nil
        {
            self.jumpCommentListAction!()
        }
    }
    @IBAction func commentBtnClicked(_ sender: Any)
    {
        if self.commentAction != nil
        {
            self.commentAction!()
        }
    }
    @IBAction func thumBtnClicked(_ sender: Any)
    {
        if self.thumAction != nil
        {
            self.thumAction!()
        }
    }
    
}
