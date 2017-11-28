//
//  BaseTableViewCell.swift
//  RCSD_Swift
//
//  Created by hxt on 2017/5/11.
//  Copyright © 2017年 runner. All rights reserved.
//

import UIKit

enum BaseCellLineStyle:Int {
    case none = 0
    case left
    case fill
}
class BaseTableViewCell: UITableViewCell {
    
    var lineColor:UIColor?{
        didSet{
            if lineColor != nil
            {
                self.setNeedsDisplay()
            }
        }
    }
    
    var leftSpace:CGFloat = 15{
        didSet{
            self.setNeedsDisplay()
        }
    }
    var rightSpace:CGFloat = 0{
        didSet{
            self.setNeedsDisplay()
        }
    }
    var topLineStyle:BaseCellLineStyle = BaseCellLineStyle.none{
        didSet{
            self.setNeedsDisplay()
        }
    }
    var bottomLineStyle:BaseCellLineStyle = BaseCellLineStyle.left{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1);
        if self.lineColor == nil
        {
            context?.setStrokeColor(kCellLineColor.cgColor)
        }
        else
        {
            context?.setStrokeColor((self.lineColor?.cgColor)!)
        }
        
        if self.topLineStyle != BaseCellLineStyle.none
        {
            context?.beginPath()
            let startX:CGFloat = (self.topLineStyle == BaseCellLineStyle.fill) ? 0 : self.leftSpace
            let endX = self.frame.width - self.rightSpace
            let y:CGFloat = 0
            context?.move(to: CGPoint(x: startX, y: y))
            context?.addLine(to: CGPoint(x: endX, y: y))
            context?.strokePath()
        }
        if self.bottomLineStyle != BaseCellLineStyle.none
        {
            context?.beginPath()
            let startX:CGFloat = (self.bottomLineStyle == BaseCellLineStyle.fill) ? 0 : self.leftSpace
            let endX = self.frame.width - self.rightSpace
            let y:CGFloat = self.frame.height - 1
            context?.move(to: CGPoint(x: startX, y: y))
            context?.addLine(to: CGPoint(x: endX, y: y))
            context?.strokePath()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
