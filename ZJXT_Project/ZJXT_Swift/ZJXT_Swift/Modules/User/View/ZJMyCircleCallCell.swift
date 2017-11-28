//
//  ZJMyCircleCallCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的圈子 召集令

import UIKit

class ZJMyCircleCallCell: UITableViewCell
{
    var deleteAction:(()->Void)?
    var model:ZJCircleModel?
    {
        didSet{
            self.userLogoImgView.af_setImage(withURL: URL(string: (model?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)
            self.nameLabel.text = model?.nickName
            self.timeLabel.text = model?.createTime
            
            self.redImgView.isHidden = true  //这里还没有这功能
            
            self.infoLabel.attributedText = Utils.getAttributeStringWithString(model?.contentText ?? "", lineSpace: 3)
            let address = "接头地点：" + (model?.activityAddress ?? "")
            self.addressLabel.attributedText = Utils.getAttributeStringWithString(address, lineSpace: 3)
            
            self.actiTimeLabel.text = "接头时间：" + (model?.activityTime ?? "")

            self.imgView.af_setImage(withURL: URL(string: (model?.imageUrl1)!)!, placeholderImage: kUserLogoPlaceHolder)
            
            
            // 方法一: 同步加载网络图片
            let url = URL(string: (model?.imageUrl1)!)
            // 从url上获取内容
            // 获取内容结束才进行下一步
            let data = try? Data(contentsOf: url!)
            
            if data != nil
            {
                let image = UIImage(data: data!)
                self.imgHeightConstraint.constant = (kScreenViewWidth - 30)/(image?.size.width)!*(image?.size.height)!

            }
            
            self.typeLabel.isHidden = true
            self.tagBtn.setTitle(" 约吧", for: .normal)
            
            self.shareBtn.setTitle( " " + (model?.applyNumber ?? "0"), for: .normal)
            self.commentBtn.setTitle(" " + (model?.commentNumber ?? "0"), for: .normal)
            self.thumBtn.setTitle(" " + (model?.praiseNumber ?? "0"), for: .normal)
        }
    }
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var thumBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var actiTimeLabel: UILabel!
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var redImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLogoImgView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
     @IBOutlet private weak var addressLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.infoLabel.attributedText = Utils.getAttributeStringWithString("这个是召集令的内容这个是召集令的内容这个是召集令的内容这个是召集令的内容", lineSpace: 10)
        self.addressLabel.attributedText = Utils.getAttributeStringWithString("接头地点：这个是接头地点这个是接头地点这个是接头地点", lineSpace: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteBtnClicked(_ sender: Any)
    {
        if self.deleteAction != nil
        {
            self.deleteAction!()
        }
    }
}
