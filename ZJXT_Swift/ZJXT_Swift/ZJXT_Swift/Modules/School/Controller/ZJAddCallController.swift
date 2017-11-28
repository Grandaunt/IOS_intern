//
//  ZJAddCircleController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/23.
//  Copyright © 2017年 runer. All rights reserved.
//
//  添加召集令

import UIKit
import MBProgressHUD

class ZJAddCallController: SecondViewController
{
    fileprivate var containView = UIView()  //为了scrollview的自动布局
    
    fileprivate var selectMainImg:UIImage?   //选中的图片
    
    fileprivate lazy var swit:UISwitch = {
        let swit = UISwitch()
        swit.onTintColor = kTabbarBlueColor
        //不能设置其frame，只能缩放大小
        swit.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return swit
    }()
    
    fileprivate lazy var titleField:UITextField = {[weak self] in
        let field = self?.createTextField()
        field?.placeholder = "约吧主题"
        return field!
    }()
    
    fileprivate lazy var timeField:UITextField = {[weak self] in
        let field = self?.createTextField()
        field?.placeholder = "接头时间"
        field?.delegate = self
        return field!
    }()
    
    fileprivate lazy var addressField:UITextField = {[weak self] in
        let field = self?.createTextField()
        field?.placeholder = "接头地点"
        return field!
    }()
    
    fileprivate lazy var tagField:UITextField = {[weak self] in
        let field1 = self?.createTextField()
        field1?.placeholder = "添加一个约吧标签"
        field1?.delegate = self
        return field1!
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
    }
    
    fileprivate func initNav()
    {
        let rightItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(saveCall))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    //保存操作
    @objc fileprivate func saveCall()
    {
        if self.selectMainImg == nil
        {
            MBProgressHUD.show(error: "请选择一张图片")
            return
        }
        if self.titleField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写主题")
            return
        }
        if self.timeField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请选择接头时间")
            return
        }
        if self.addressField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写接头地点")
            return
        }
        if self.tagField.text?.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请选择标签")
            return
        }
        
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["contentText"] = self.titleField.text
        param["categoryId"] = "2"  //1心情 2约吧
        param["tag"] = self.tagField.text
        param["activityTime"] = self.timeField.text
        param["activityAddress"] = self.addressField.text
        param["isRealName"] = self.swit.isOn ? "1" : "0"
        
        BaseViewModel().postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [self.selectMainImg!], isProgressHud: false, commonFileName: "image", progress: nil, success: { (resp) in
            param["imageUrl1"] = resp?["url"].stringValue
            BaseViewModel().post(url: kAddCircleURL, param: param, MBProgressHUD: true, success: { (res) in
                MBProgressHUD.show(info: "添加成功")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }

            }, noData: nil, failure: nil)
        }, failure: nil)
    }
    
    fileprivate func initView()
    {
        self.view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        scrollView.addSubview(self.containView)
        self.containView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()  //纵向滑动就width等于UIScrollView，横向就height
        }
        
        let imgBtn = ImageButton(type: .custom)
        imgBtn.backgroundColor = kBackgroundColor
        imgBtn.addTarget(self, action: #selector(mainImgBtnAction(btn:)), for: .touchUpInside)
        self.containView.addSubview(imgBtn)
        imgBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.width.equalTo(300)
            make.height.equalTo(225)
            make.centerX.equalToSuperview()
        }
        
        let line1 = self.createLine()
        self.containView.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(imgBtn.snp.bottom).offset(kHomeEdgeSpace*2)
        }
        
        let field = self.createTextField()
        field.placeholder = "实名约吧"
        field.isUserInteractionEnabled = false
        self.containView.addSubview(field)
        field.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.top.equalTo(line1.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        let lineTemp = self.createLine()
        self.containView.addSubview(lineTemp)
        lineTemp.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(field.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        self.containView.addSubview(self.swit)
        self.swit.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
            make.centerY.equalTo(field)
        }
        
        self.containView.addSubview(self.titleField)
        self.titleField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
            make.top.equalTo(lineTemp.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        let line2 = self.createLine()
        self.containView.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(self.titleField.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        self.containView.addSubview(self.timeField)
        self.timeField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
            make.top.equalTo(line2.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        let line3 = self.createLine()
        self.containView.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(self.timeField.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        self.containView.addSubview(self.addressField)
        self.addressField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
            make.top.equalTo(line3.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }

        let line4 = self.createLine()
        self.containView.addSubview(line4)
        line4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(self.addressField.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        self.containView.addSubview(self.tagField)
        self.tagField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.top.equalTo(line4.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        let lineTemp1 = self.createLine()
        self.containView.addSubview(lineTemp1)
        lineTemp1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(self.tagField.snp.bottom).offset(kHomeEdgeSpace*1.5)
        }
        
        let locationBtn = UIButton()
        locationBtn.isHidden = true
        locationBtn.setTitle(" 你在哪里?", for: .normal)
        locationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        locationBtn.setTitleColor(UIColor.color(hex: "#929292"), for: .normal)
        locationBtn.backgroundColor = UIColor.color(hex: "#F9F9F9")
        locationBtn.setImage(IconFontUtils.imageSquare(code: "\u{e650}", size: 15, color: UIColor.color(hex: "#333333")), for: .normal)
        locationBtn.layer.masksToBounds = true
        locationBtn.layer.cornerRadius = 15
        self.containView.addSubview(locationBtn)
        locationBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.top.equalTo(lineTemp1.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-kHomeEdgeSpace*2)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
    }
    
    fileprivate func createLine() -> UIView
    {
        let line = UIView()
        line.backgroundColor = kCellLineColor
        return line
    }
    
    fileprivate func createTextField() -> UITextField
    {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        return textField
    }
    
    fileprivate func timeSelect()
    {
        self.view.endEditing(true)
        
        let datePicker = HooDatePicker(superView:self.view)
        datePicker?.title = "接头时间"
        datePicker?.minimumDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePicker?.maximumDate = dateFormatter.date(from: "2050-12-31")
        datePicker?.datePickerMode = HooDatePickerMode.date
        datePicker?.selectedDateBlock = {[weak self]date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self?.timeField.text = dateFormatter.string(from: date!)
        }
        datePicker?.show()
    }
    
    @objc fileprivate func mainImgBtnAction(btn:ImageButton)
    {
        let imagePickerVC = TZImagePickerController(maxImagesCount: 1, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)
        imagePickerVC?.isSelectOriginalPhoto = true
        imagePickerVC?.allowTakePicture = true
        
        imagePickerVC?.allowPickingVideo = false
        imagePickerVC?.allowPickingImage = true
        imagePickerVC?.allowPickingOriginalPhoto = true
        imagePickerVC?.sortAscendingByModificationDate = true
        
        imagePickerVC?.isStatusBarDefault = true
        imagePickerVC?.oKButtonTitleColorDisabled = UIColor.lightGray
        imagePickerVC?.oKButtonTitleColorNormal = UIColor.green
        imagePickerVC?.barItemTextColor = UIColor.lightGray
        imagePickerVC?.naviTitleColor = UIColor.lightGray
        imagePickerVC?.navigationBar.tintColor = UIColor.lightGray
        
        imagePickerVC?.showSelectBtn = false
        imagePickerVC?.isSelectOriginalPhoto = false   //默认是不选择原图按钮的
        imagePickerVC?.didFinishPickingPhotosHandle = {[weak self] (photos,assets,isSelectOriginalPhoto) in
            self?.selectMainImg = photos?.first
            btn.setBackgroundImage(photos?.first, for: .normal)
            btn.centerImgView?.isHidden = true
            btn.centerTitleLabel?.isHidden = true
        }
        self.present(imagePickerVC!, animated: true, completion: nil)
    }

    @objc fileprivate func tagViewAction()
    {
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJAddCallController:UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
        
        if textField == self.timeField
        {
            self.timeSelect()
        }
        else
        {
            let toVC = ZJAddCallTagController()
            toVC.navTitle = "约吧标签"
            toVC.selectTagAction = {[weak self] model in
                self?.tagField.text = model.tagName
            }
            self.navigationController?.pushViewController(toVC, animated: true)

        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == self.timeField
        {
            self.timeSelect()
        }
        else
        {
            let toVC = ZJAddCallTagController()
            toVC.navTitle = "约吧标签"
            toVC.selectTagAction = {[weak self] model in
                self?.tagField.text = model.tagName
            }
            self.navigationController?.pushViewController(toVC, animated: true)
        }

        return false
    }
}

//选择图片按钮
fileprivate class ImageButton:UIButton
{
    weak var centerImgView:UIImageView?
    weak var centerTitleLabel:UILabel?
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        let img = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e69b}", size: 50, color: kGrayTextColor))
        self.centerImgView = img
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-3)
        }
        
        let label = UILabel()
        label.text = "点击添加图片"
        label.font = UIFont.systemFont(ofSize: 15)
        self.centerTitleLabel = label
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}

