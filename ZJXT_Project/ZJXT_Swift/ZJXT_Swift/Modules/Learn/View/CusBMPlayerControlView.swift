//
//  CusBMPlayerControlView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

class CusBMPlayerControlView: BMPlayerControlView
{
    open lazy var collectBtn:UIButton = {
        let btn = UIButton(type : UIButtonType.custom)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e668}", size: 25, color: UIColor.white), for: .normal)
        btn.isHidden = true
        return btn
    }()
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backButton.setImage(IconFontUtils.imageSquare(code: "\u{e61c}", size: 25, color: UIColor.white), for: .normal)
        self.backButton.snp.remakeConstraints { (make) in
            make.left.top.equalToSuperview().offset(kHomeEdgeSpace)
        }
        self.chooseDefitionView.isHidden = true
        
        self.topMaskView.addSubview(self.collectBtn)
        self.collectBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backButton)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
