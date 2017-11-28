//
//  CSDualWaySlider.swift
//  ZJXTself.Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

// 注意：目前标签滑动时的动画方向效果有问题，待后期调整

import UIKit

class CSDualWaySlider: UIView
{
    
    var currentMinValue:CGFloat = 0{//当前小滑块所代表的值，可设置
        didSet{
            if currentMinValue > (self.currentMaxValue - self.blockSpaceValue)
            {
                self.currentMinValue = oldValue
                return
            }
            else if currentMinValue < self.minSetValue
            {
                self.currentMinValue = oldValue
                return
            }
            
            if self.currentMinValue > (self.frontValue + self.minSetValue)
            {
                self.minValue = self.frontScale + (self.currentMinValue - self.frontValue - self.minSetValue)/(self.totalSpaceValue - self.frontValue) * (1 - self.frontScale)
            }
            else
            {
                self.minValue = (self.currentMinValue - self.minSetValue)/self.frontValue * self.frontScale
            }
            
            let x = self.minValue * (self.progressWidth - self.blockSpace)
            if self.getMinTitle != nil
            {
                self.minIndicateView.title = self.getMinTitle!(self.currentMinValue)
            }
            
            self.minButton.snp.updateConstraints { (make) in
                make.centerX.equalTo(self.progressView.snp.left).offset(x)
            }
            
        }
    }
    var currentMaxValue:CGFloat = 0{//当前大滑块所代表的值，可设置
        didSet{
            if currentMaxValue < (self.currentMinValue + self.blockSpaceValue)
            {
                self.currentMaxValue = oldValue
                return
            }
            else if currentMaxValue > self.maxSetValue
            {
                self.currentMaxValue = oldValue
                return
            }
            
            if self.currentMaxValue > (self.frontValue + self.blockSpaceValue + self.minSetValue)
            {
                self.maxValue = (self.currentMaxValue - self.frontValue - self.blockSpaceValue - self.minSetValue)/(self.totalSpaceValue - self.frontValue)*(1 - self.frontScale) + self.frontScale;
            }
            else
            {
                self.maxValue = (self.currentMaxValue - self.blockSpaceValue - self.minSetValue)/self.frontValue * self.frontScale;
            }
            
            
            let y = (1 - self.maxValue)*(self.progressWidth-self.blockSpace);
            
            if self.getMaxTitle != nil
            {
                self.maxIndicateView.title = self.getMaxTitle!(self.currentMaxValue)
            }
            self.didcurrentMaxOrMinValueChanged()
            self.maxButton.snp.updateConstraints { (make) in
                make.centerX.equalTo(self.progressView.snp.right).offset(-y)
            }

        }
    }
    private(set) var minSetValue : CGFloat = 0 //当前设置的最小值
    private(set) var maxSetValue : CGFloat = 0 //当前设置的最大值
    
    var frontValue:CGFloat = 0 { //前段所代表的值 默认 最小到最大的一半
        didSet{
            if frontValue >= self.totalSpaceValue || frontScale <= 0
            {
                
                self.frontValue = oldValue
                return
            }
            let maxValue = self.currentMaxValue
            self.currentMaxValue = maxValue
            let minValue = self.currentMinValue
            self.currentMinValue = minValue
        }
    }
    var frontScale:CGFloat = 0.5{  //分段比例  （0～1） 默认0.5
        didSet{
            if frontScale >= 1 || frontScale <= 0
            {
                self.frontScale = oldValue
                return
            }
            
            let maxValue = self.currentMaxValue
            self.currentMaxValue = maxValue
            let minValue = self.currentMinValue
            self.currentMinValue = minValue
        }
    }
    var progressLeftSpace:CGFloat = 20{  //横条左间距 默认 20
        didSet{
            self.progressWidth = self.frame.size.width - progressLeftSpace*2
            self.progressView.snp.updateConstraints { (make) in
                make.left.equalTo(progressLeftSpace)
                make.right.equalTo(-progressLeftSpace)
            }
        }
    }
    var progressHeight:CGFloat = 10{ //横条高度
        didSet{
            self.progressView.snp.updateConstraints { (make) in
                make.height.equalTo(progressHeight)
            }
        }
    }
    var progressRadius:CGFloat = 0 { //横条圆角
        didSet{
            self.progressView.layer.cornerRadius = progressRadius
        }
    }
    var spaceInBlocks:CGFloat = 10{  //滑块之间的间距
        didSet{
            self.blockSpace = (self.blockImage?.size.width)! + spaceInBlocks
        }
    }
    var indicateViewOffset:CGFloat = 3{ //滑块和指示视图之间的间距 默认 3
        didSet{
            self.minIndicateView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.minButton.snp.centerY).offset(-indicateViewOffset)
            }
            self.maxIndicateView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.maxButton.snp.centerY).offset(-indicateViewOffset)

            }
        }
    }
    var indicateViewWidth:CGFloat = 35{ //指示视图宽度 默认 35
        didSet{
            self.minIndicateView.snp.updateConstraints { (make) in
                make.width.equalTo(indicateViewWidth)
            }
            self.maxIndicateView.snp.updateConstraints { (make) in
                make.width.equalTo(indicateViewWidth)
            }
        }
    }
    var blockImage:UIImage?{    //滑块图标
        didSet{
            self.minButton.setImage(blockImage, for: .normal)
            self.maxButton.setImage(blockImage, for: .normal)
            self.blockSpace = (blockImage?.size.width)! + self.spaceInBlocks
        }
    }
    var lightColor:UIColor = UIColor(red: 0.24, green: 0.61, blue: 0.91, alpha: 1){     //点亮颜色
        didSet{
            self.lightView.backgroundColor = lightColor
        }
    }
    var darkColor:UIColor = UIColor.color(hex: "#f2f2f2") {     //背景色
        didSet{
            self.progressView.backgroundColor = darkColor
        }
    }
    var showAnimate:Bool = true    //滑块动作
    
    private(set) lazy var minIndicateView:CSDualWayIndicateView = {  //滑块指示视图
        let view = CSDualWayIndicateView()
        
        let minIndicatePan = UIPanGestureRecognizer(target: self, action: #selector(panMinAction(pan:)))
        minIndicatePan.maximumNumberOfTouches = 1
        view.addGestureRecognizer(minIndicatePan)
        return view
    }()
    private(set) lazy var maxIndicateView:CSDualWayIndicateView = { //滑块指示视图
        let view = CSDualWayIndicateView()
        
        let maxIndicatePan = UIPanGestureRecognizer(target: self, action: #selector(panMaxAction(pan:)))
        maxIndicatePan.maximumNumberOfTouches = 1
        view.addGestureRecognizer(maxIndicatePan)
        return view
    }()
    
    var sliderValueChanged:((CGFloat,CGFloat)->Void)?  //滑块值变化调用的block 最大 最小变化都会调用
    var getMinTitle:((CGFloat)->String)?   // 获取小指标的标题
    var getMaxTitle:((CGFloat)->String)?   //获取大指标的标题
    
    
    fileprivate lazy var progressView:UIView = {[weak self] in
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = (self?.progressRadius)!
        view.backgroundColor = self?.darkColor
        return view
    }()
    fileprivate lazy var lightView:UIView = {[weak self] in
        let view = UIView()
        view.backgroundColor = self?.lightColor
        return view
    }()
    fileprivate lazy var minButton:UIButton = {[weak self] in
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.clear
        btn.adjustsImageWhenHighlighted = false
        btn.setImage(self?.blockImage, for: .normal)
        let minButtonPan = UIPanGestureRecognizer(target: self, action: #selector(panMinAction(pan:)))
        minButtonPan.maximumNumberOfTouches = 1
        btn.addGestureRecognizer(minButtonPan)
        return btn
    }()
    fileprivate lazy var maxButton:UIButton = {[weak self] in
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.clear
        btn.adjustsImageWhenHighlighted = false
        btn.setImage(self?.blockImage, for: .normal)
        let maxButtonPan = UIPanGestureRecognizer(target: self, action: #selector(panMaxAction(pan:)))
        maxButtonPan.maximumNumberOfTouches = 1
        btn.addGestureRecognizer(maxButtonPan)
        return btn
    }()
    fileprivate var minValue:CGFloat = 0   //当前最小进度
    fileprivate var maxValue:CGFloat = 1   //当前最大进度
    fileprivate var blockSpace:CGFloat = 0   //间隔宽度
    fileprivate var blockSpaceValue:CGFloat = 0  //间隔所代表的值,即最小间隔
    fileprivate var progressWidth:CGFloat = 0    //横条宽度
    fileprivate var totalSpaceValue:CGFloat = 0  //横条所代表的值的大小  最大值 减 最小值 减 间隔值

    /**
     初始化函数
     
     @param frame 位置 总体高度以滑块为底部开始布局 指示标的高度为28
     @param minValue 最小值
     @param maxValue 最大值
     @param blockSpaceValue 两个滑块间隔的所代表的值
     @return 实例
     */
    convenience init(frame:CGRect,minValue:CGFloat,maxValue:CGFloat,blockSpaceValue:CGFloat)
    {
        self.init(frame: frame, image: UIImage(named:"huakuai")!, minValue: minValue, maxValue: maxValue, blockSpaceValue: blockSpaceValue)
    }
    
    /**
     初始化函数
     
     @param frame 位置  总体高度以滑块为底部开始布局 指示标的高度为28
     @param image 图标
     @param minValue 最小值
     @param maxValue 最大值
     @param blockSpaceValue 两个滑块间隔的值
     @return 实例
     */
    
    convenience init(frame:CGRect,image:UIImage,minValue:CGFloat,maxValue:CGFloat,blockSpaceValue:CGFloat)
    {
        self.init(frame: frame)
        self.blockImage = image
        self.blockSpace = image.size.width + self.spaceInBlocks
        self.blockSpaceValue = blockSpaceValue
        self.minSetValue = minValue
        self.maxSetValue = maxValue
        self.currentMinValue = self.minSetValue
        self.currentMaxValue = self.maxSetValue
        self.totalSpaceValue = self.maxSetValue - self.minSetValue - self.blockSpaceValue
        self.frontValue = self.totalSpaceValue/2.0
        self.progressWidth = self.frame.size.width - self.progressLeftSpace*2
        self.initSliderUI()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    fileprivate func initSliderUI()
    {
        self.addSubview(self.progressView)
        self.addSubview(self.lightView)
        self.addSubview(self.minButton)
        self.addSubview(self.maxButton)
        self.addSubview(self.minIndicateView)
        self.addSubview(self.maxIndicateView)

        self.progressView.snp.makeConstraints { (make) in
            make.left.equalTo(self.progressLeftSpace)
            make.right.equalTo(-self.progressLeftSpace)
            make.height.equalTo(self.progressHeight)
            make.bottom.equalTo(self.minButton.snp.top)
        }
        
        self.lightView.snp.makeConstraints { (make) in
            make.height.centerY.equalTo(self.progressView)
            make.left.equalTo(self.minButton.snp.centerX)
            make.right.equalTo(self.maxButton.snp.centerX)
        }
        
        self.minButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.progressView.snp.left)
            make.bottom.equalToSuperview()
        }
        
        self.maxButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalTo(self.progressView.snp.right)
        }
        
        self.minIndicateView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.minButton)
            make.width.equalTo(self.indicateViewWidth)
            make.height.equalTo(28)
            //self.minIndicateView 修改了 anchorPoint 所以参照的是centerY
            make.bottom.equalTo(self.minButton.snp.centerY).offset(-self.indicateViewOffset)
        }
        
        self.maxIndicateView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.maxButton)
            make.width.equalTo(self.indicateViewWidth)
            make.height.equalTo(28)
            //self.minIndicateView 修改了 anchorPoint 所以参照的是centerY
            make.bottom.equalTo(self.maxButton.snp.centerY).offset(-self.indicateViewOffset)

        }
    }
    
    @objc fileprivate func panMinAction(pan:UIPanGestureRecognizer)
    {
        let point = pan.location(in: self)
        
        var lastX:CGFloat = 0
        
        switch pan.state
        {
            case .began:
                self.bringSubview(toFront: self.minIndicateView)
                self.bringSubview(toFront: self.minButton)
                lastX = point.x
            case .changed:
                var x = point.x - self.progressLeftSpace
                if point.x <= self.progressLeftSpace
                {
                    x = 0
                }
                else if point.x > (self.maxValue * (self.progressWidth - self.blockSpace) + self.progressLeftSpace)
                {
                    x = self.maxValue*(self.progressWidth - self.blockSpace)
                }
                else
                {
                    x = point.x - self.progressLeftSpace
                }
                self.minValue = x/(self.progressWidth - self.blockSpace)
                
                if self.minValue > self.frontValue
                {
                    self.currentMinValue = (self.minValue - self.frontScale)/(1-self.frontScale)*(self.totalSpaceValue-self.frontValue)+self.frontValue+self.minSetValue
                }
                else
                {
                    self.currentMinValue = self.minValue/self.frontScale * self.frontValue + self.minSetValue
                }
                
                self.didcurrentMaxOrMinValueChanged()
                
                if self.getMinTitle != nil
                {
                    self.minIndicateView.title = self.getMinTitle!(self.currentMinValue)
                }
                
                self.minButton.snp.updateConstraints({ (make) in
                    make.centerX.equalTo(self.progressView.snp.left).offset(x);
                })
                
                if self.showAnimate == false
                {
                    break
                }
                
                if lastX > point.x
                {
                    self.minIndicateView.direction = .right
                }
                else if lastX < point.x
                {
                    self.minIndicateView.direction = .left
                }
                lastX = point.x
            case .ended,.cancelled:
                self.minIndicateView.direction = .normal
            default:
                break
        }
    }
    
    @objc fileprivate func panMaxAction(pan:UIPanGestureRecognizer)
    {
        let  point = pan.location(in: self)
        var lastX:CGFloat = 0
        switch (pan.state)
        {
            case .began:
                self.bringSubview(toFront: self.maxIndicateView)
                self.bringSubview(toFront: self.maxButton)
                lastX = point.x;
            case .changed:
                var y = self.progressWidth - (point.x - self.progressLeftSpace);
                if point.x >=  (self.progressWidth + self.progressLeftSpace)
                {
                    y = 0;
                }
                else if point.x <= (self.minValue * (self.progressWidth-self.blockSpace) + self.progressLeftSpace + self.blockSpace)
                {
                    y = self.progressWidth - (self.minValue * (self.progressWidth-self.blockSpace) + self.blockSpace);
                }
                else
                {
                    y = (self.progressWidth + self.progressLeftSpace) - point.x;
                }
                self.maxValue = 1 - y/(self.progressWidth-self.blockSpace);
                if (self.maxValue > self.frontScale)
                {
                    self.currentMaxValue = (self.maxValue - self.frontScale)/(1 - self.frontScale)*(self.totalSpaceValue - self.frontValue)+self.frontValue + self.blockSpaceValue + self.minSetValue;
                }
                else
                {
                    self.currentMaxValue = self.maxValue/self.frontScale * self.frontValue+self.blockSpaceValue + self.minSetValue;
                }
                
                
                if self.getMaxTitle != nil
                {
                    self.maxIndicateView.title = self.getMaxTitle!(self.currentMaxValue)
                }
                
                self.didcurrentMaxOrMinValueChanged();
                self.maxButton.snp.updateConstraints({ (make) in
                    make.centerX.equalTo(self.progressView.snp.right).offset(-y)
                })
                if self.showAnimate == false
                {
                    break
                }
                if lastX > point.x
                {
                    self.maxIndicateView.direction = .right
                }else if lastX < point.x
                {
                    self.maxIndicateView.direction = .left
                }
                lastX = point.x;
            case .ended,.cancelled:
                self.maxIndicateView.direction = .normal
            default:
                break;
            }
    }
    
    fileprivate func didcurrentMaxOrMinValueChanged()
    {
        if self.sliderValueChanged != nil
        {
            self.sliderValueChanged!(self.currentMinValue,self.currentMaxValue)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
