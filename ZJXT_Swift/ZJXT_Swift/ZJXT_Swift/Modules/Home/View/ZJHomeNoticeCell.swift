//
//  ZJHomeNoticeCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeNoticeCell: UITableViewCell
{
    @IBOutlet weak var mesImgView: UIImageView!
    
    lazy var cycleView: SDCycleScrollView = {
        let view = SDCycleScrollView(frame: CGRect.zero, delegate: nil, placeholderImage: nil)
        view?.scrollDirection = .vertical
        view?.onlyDisplayText = true
        view?.disableScrollGesture()
        view?.autoScrollTimeInterval = 5.0
        view?.titleLabelBackgroundColor = UIColor.white
        view?.titleLabelTextColor = UIColor.color(hex: "#333333")
        return view!
    }()
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.addSubview(self.cycleView)
        self.cycleView.snp.makeConstraints { (make) in
            make.left.equalTo(self.mesImgView.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
