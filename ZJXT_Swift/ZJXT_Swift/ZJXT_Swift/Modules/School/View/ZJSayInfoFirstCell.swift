//
//  ZJSayInfoFirstCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/11.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJSayInfoFirstCell: UITableViewCell {
    
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
            
            if model?.imageUrl1 == nil
            {
                self.infoLabel.snp.remakeConstraints({ (make) in
                    make.left.equalToSuperview().offset(15)
                    make.right.bottom.equalToSuperview().offset(-15)
                })
            }
            else
            {
                self.infoLabel.snp.remakeConstraints({ (make) in
                    make.top.equalTo(self.imgView.snp.bottom).offset(15)
                    make.left.equalToSuperview().offset(15)
                    make.right.equalToSuperview().offset(-15)
                })
                
                let width = (kScreenViewWidth - 15*2 - 3.5*2)/3
                
                let imgsView = UIImageView()
                imgsView.af_setImage(withURL: URL(string: (model?.imageUrl1)!)!, placeholderImage: kUserLogoPlaceHolder)
                self.contentView.addSubview(imgsView)
                imgsView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(15)
                    make.width.height.equalTo(width)
                    make.top.equalTo(self.infoLabel.snp.bottom).offset(10)
                    make.bottom.equalToSuperview().offset(-15)
                }

                
//                var preImgView:UIImageView?
//                for (idx,img) in (imgArray?.enumerated())!
//                {
//                    let imgView = UIImageView()
//                    imgView.image = img
//                    self.contentView.addSubview(imgView)
//
//                    if idx < 3
//                    {
//                        let index = CGFloat(idx)
//                        imgView.snp.makeConstraints { (make) in
//                            make.left.equalToSuperview().offset(15 + index*width + index*3.5)
//                            make.width.height.equalTo(width)
//                            make.top.equalTo(self.infoLabel.snp.bottom).offset(10)
//                        }
//                    }
//                    else
//                    {
//                        let idex  = CGFloat(idx-3)
//                        let left = 15+idex*(width+3.5)
//                        imgView.snp.makeConstraints { (make) in
//                            make.left.equalToSuperview().offset(left)
//                            make.width.height.equalTo(width)
//                            make.top.equalTo(self.infoLabel.snp.bottom).offset(10 + width + 3.5)
//                            make.bottom.equalToSuperview().offset(-15)
//                        }
//                    }
//
//                    if idx == 5
//                    {
//                        imgView.snp.makeConstraints { (make) in
//                            make.left.equalTo((preImgView?.snp.right)!).offset(3.5)
//                            make.width.height.top.equalTo(preImgView!)
//                            make.bottom.equalToSuperview().offset(-15)
//                        }
//
//                    }
//
//                    preImgView = imgView
//                }
            }
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
//    var imgArray:[UIImage]?{
//        didSet{
//            if imgArray == nil || imgArray?.count == 0
//            {
//                self.infoLabel.snp.remakeConstraints({ (make) in
//                    make.left.equalToSuperview().offset(15)
//                    make.right.bottom.equalToSuperview().offset(-15)
//                })
//            }
//            else
//            {
//                self.infoLabel.snp.remakeConstraints({ (make) in
//                    make.top.equalTo(self.imgView.snp.bottom).offset(15)
//                    make.left.equalToSuperview().offset(15)
//                    make.right.equalToSuperview().offset(-15)
//                })
//
//                let width = (kScreenViewWidth - 15*2 - 3.5*2)/3
//
//                var preImgView:UIImageView?
//                for (idx,img) in (imgArray?.enumerated())!
//                {
//                    let imgView = UIImageView()
//                    imgView.image = img
//                    self.contentView.addSubview(imgView)
//
//                    if idx < 3
//                    {
//                        let index = CGFloat(idx)
//                        imgView.snp.makeConstraints { (make) in
//                            make.left.equalToSuperview().offset(15 + index*width + index*3.5)
//                            make.width.height.equalTo(width)
//                            make.top.equalTo(self.infoLabel.snp.bottom).offset(10)
//                        }
//                    }
//                    else
//                    {
//                        let idex  = CGFloat(idx-3)
//                        let left = 15+idex*(width+3.5)
//                        imgView.snp.makeConstraints { (make) in
//                            make.left.equalToSuperview().offset(left)
//                            make.width.height.equalTo(width)
//                            make.top.equalTo(self.infoLabel.snp.bottom).offset(10 + width + 3.5)
//                            make.bottom.equalToSuperview().offset(-15)
//                        }
//                    }
//
//                    if idx == 5
//                    {
//                        imgView.snp.makeConstraints { (make) in
//                            make.left.equalTo((preImgView?.snp.right)!).offset(3.5)
//                            make.width.height.top.equalTo(preImgView!)
//                            make.bottom.equalToSuperview().offset(-15)
//                        }
//
//                    }
//
//                    preImgView = imgView
//                }
//            }
//        }
//    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.infoLabel.attributedText = Utils.getAttributeStringWithString("兄弟们，我现在的心情十分的沉重兄弟们，我现在的心情十分的沉重兄弟们，我现在的心情十分的沉重兄弟们，我现在的心情十分的沉重兄弟们，我现在的心情十分的沉重", lineSpace: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
