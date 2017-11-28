//
//  ZJCallInfoFirstCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/10.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCallInfoFirstCell: UITableViewCell
{
    var applyAction:(()->Void)?
    var model:ZJCircleModel?{
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
            self.timeLabel.text = model?.createTime
            self.infoLabel.attributedText = Utils.getAttributeStringWithString(model?.contentText ?? "", lineSpace: 3)
            self.backImgView.af_setImage(withURL: URL(string: (model?.imageUrl1)!)!, placeholderImage: kUserLogoPlaceHolder)
            
            let addressStr = "接头地点：" + (model?.activityAddress ?? "暂无")
            self.addressLabel.attributedText = Utils.getAttributeStringWithString(addressStr, lineSpace: 3)
            self.actiTimeLabel.text = "接头时间： " + (model?.activityTime ?? "暂无")
            self.themeLabel.text = model?.tag ?? "      "
            self.pepeoleNum.text = "已参加" + (model?.applyNumber ?? "0") + "人"
            self.peopleLabel.text = "发起人：" + (model?.nickName ?? (model?.trueName ?? "暂无信息"))
            
            if model?.isApply == "YES"
            {
                self.applyBtn.setTitle("已申请", for: .normal)
                self.applyBtn.isEnabled = false
            }
            else
            {
                self.applyBtn.setTitle("我要参加", for: .normal)
                self.applyBtn.isEnabled = true

            }
            
        }
    }
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var pepeoleNum: UILabel!
    @IBOutlet weak var actiTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet fileprivate weak var addressLabel: UILabel!
    @IBOutlet fileprivate weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addressLabel.attributedText = Utils.getAttributeStringWithString("接头地点：北京市南四环西路北京市南四环西路北京市南四环西路", lineSpace: 10)
        self.infoLabel.attributedText = Utils.getAttributeStringWithString("兄弟们好久不见了，大爷今天下午一起聚聚，聊聊天，吃吃饭，有家属的顺便带着家属", lineSpace: 10)
    }
    @IBAction func applyClcked(_ sender: UIButton)
    {
        if self.applyAction != nil
        {
            self.applyAction!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
