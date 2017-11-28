//
//  ZJMyCircleTextCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyCircleTextCell: UITableViewCell
{
    var deleteAction:(()->Void)?
    var model:ZJCircleModel?{
        didSet{
            
//            let width = (kScreenViewWidth - 15*2 - 3.5*2)/3
//
//            for img in self.imgViewArray
            //            {
//                img.removeFromSuperview()
//            }
//            self.imgViewArray.removeAll()
            
            if model?.imageUrl1 != nil
            {
                self.typeLabel.snp.remakeConstraints({ (make) in
                    make.bottom.equalToSuperview().offset(-10)
                    make.left.equalToSuperview().offset(15)
                })

                self.imgView.af_setImage(withURL: URL(string: (model?.imageUrl1)!)!, placeholderImage: kUserLogoPlaceHolder)
                
                // 方法一: 同步加载网络图片
                let url = URL(string: (model?.imageUrl1)!)
                // 从url上获取内容
                // 获取内容结束才进行下一步
                let data = try? Data(contentsOf: url!)
                
                if data != nil
                {
                    let image = UIImage(data: data!)
                    self.imgViewConstraintHeight.constant = (kScreenViewWidth - 30)/(image?.size.width)!*(image?.size.height)!
                }
            }
            else
            {
                self.imgViewConstraintHeight.constant = -10
            }
            
            if model?.logo == nil
            {
                self.userLogoImg.image = kUserLogoPlaceHolder
            }
            else
            {
                self.userLogoImg.af_setImage(withURL: URL(string: (model?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)

            }
            
            self.nameLabel.text = model?.nickName
            self.timeLabel.text = model?.createTime
            self.infoLabel.attributedText = Utils.getAttributeStringWithString(model?.contentText ?? " ", lineSpace: 3)
            
            self.redImgView.isHidden = true  //这里还没有这功能
            
            self.typeLabel.isHidden = true
            self.tagBtn.setTitle(" 心情", for: .normal)
            
            self.shareBtn.setTitle( " " + (model?.applyNumber ?? "0"), for: .normal)
            self.commentBtn.setTitle(" " + (model?.commentNumber ?? "0"), for: .normal)
            self.thumBtn.setTitle(" " + (model?.praiseNumber ?? "0"), for: .normal)
        }
    }
    
    fileprivate var imgViewArray = [UIImageView]()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLogoImg: UIImageView!
    @IBOutlet weak var redImgView: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var thumBtn: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
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
