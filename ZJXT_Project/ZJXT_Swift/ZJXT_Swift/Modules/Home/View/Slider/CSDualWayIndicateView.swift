//
//  CSDualWayIndicateView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

enum CSDualWayIndicateDirection:UInt
{
    case normal = 0
    case left
    case right
}

class CSDualWayIndicateView: UIView
{
    var backIndicateColor:UIColor = UIColor(red: 0.24, green: 0.61, blue: 0.91, alpha: 1){
        didSet{
            self.indicateLabel.backgroundColor = backIndicateColor
            self.setNeedsDisplay()
        }
    }
    lazy var indicateLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.24, green: 0.61, blue: 0.91, alpha: 1)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    var title:String?{
        didSet {
            self.indicateLabel.text = title
        }
    }
    
    
    
     var direction:CSDualWayIndicateDirection = .normal{
        didSet{
            
            if direction == oldValue
            {
                return
            }
            let s = direction == .left ? Double.pi * (-30) / 180 : (direction == .right ? Double.pi*30/180.0:Double.pi*0/180.0)
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(s))
            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(self.indicateLabel)
        self.indicateLabel.snp.makeConstraints { (make) in
            make.top.centerX.width.equalToSuperview()
            make.height.equalTo(21)
        }
        
        self.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
    }
    
    override func draw(_ rect: CGRect)
    {
        self.drawBackground(self.bounds, inContext: UIGraphicsGetCurrentContext()!)
    }
    
    fileprivate func drawBackground(_ frame:CGRect,inContext context:CGContext)
    {
        let left = frame.midX - 6
        let right = frame.midX + 6
        
        let y0:CGFloat = 21
        let y1:CGFloat = frame.size.height
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: left, y: y0))
        path.addLine(to: CGPoint(x: frame.midX, y: y1))
        path.addLine(to: CGPoint(x: right, y: y0))
        path.close()
        
        self.backIndicateColor.set()
        self.backIndicateColor.setStroke()
        path.stroke()
        path.fill()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
