//
//  ZJMyCircleCallCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的圈子 召集令

import UIKit

class ZJHomeCircleCell: UITableViewCell
{
    var model:ZJHomeListModel?{
        didSet{
            self.nameLabel.text = model?.nickName
            self.infoLabel.text = model?.contentText
            self.actiTimeLabel.text = "接头时间：" + (model?.activityTime ?? "")
            self.addressLabel.text = "接头地点：" + (model?.activityAddress ?? "")
            self.imgView.af_setImage(withURL: URL(string: (model?.imageUrl)!)!, placeholderImage: kUserLogoPlaceHolder)
            
            // 方法一: 同步加载网络图片
            let url = URL(string: (model?.imageUrl)!)
            // 从url上获取内容
            // 获取内容结束才进行下一步
            let data = try? Data(contentsOf: url!)
            
            if data != nil
            {
                let image = UIImage(data: data!)
                self.imgViewHeightConstrait.constant = (kScreenViewWidth - 30)/(image?.size.width)!*(image?.size.height)!
                
            }
        }
    }
    
    @IBOutlet weak var imgViewHeightConstrait: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var actiTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
     @IBOutlet private weak var addressLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
