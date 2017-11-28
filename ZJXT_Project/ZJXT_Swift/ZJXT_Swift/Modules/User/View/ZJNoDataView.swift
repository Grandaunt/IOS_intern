//
//  ZJNoDataView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/10.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJNoDataView: UIView {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    class func noDataView(img:UIImage,title:String,info:String) -> ZJNoDataView
    {
        let view = Bundle.main.loadNibNamed("ZJNoDataView", owner: nil, options: nil)?.last as! ZJNoDataView
        view.imgView.image = img
        view.titleLabel.text = title
        view.infoLabel.text = info
        return view
    }
    
}
