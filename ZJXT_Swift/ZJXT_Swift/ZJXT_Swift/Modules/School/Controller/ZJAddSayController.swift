//
//  ZJAddSayController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/23.
//  Copyright © 2017年 runer. All rights reserved.
//
//  添加我想说

import UIKit
import MBProgressHUD

class ZJAddSayController: SecondViewController
{

    fileprivate lazy var textView:UITextView = {
        let textView = UITextView()
        textView.wzb_placeholder = "分享心情..."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    fileprivate var selectImg:UIImage?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.initView()
    }
    
    fileprivate func initNav()
    {
        let rightItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(saveSay))
        rightItem.isEnabled = false
        rightItem.tintColor = UIColor.color(hex: "#cccccc")
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    fileprivate func initView()
    {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(kScreenViewHeight/3)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.color(hex: "#f9f9f9")
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let leftBtn = UIButton()
        leftBtn.setBackgroundImage(UIImage(named:"school_say_img"), for: .normal)
        leftBtn.addTarget(self, action: #selector(imgBtnClicked), for: .touchUpInside)
        bottomView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenViewWidth/6)
            make.centerY.equalToSuperview()
        }
        
        let centerBtn = UIButton()
        centerBtn.setBackgroundImage(UIImage(named:"school_say_at"), for: .normal)
        bottomView.addSubview(centerBtn)
        centerBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let rightBtn = UIButton()
        rightBtn.setBackgroundImage(UIImage(named:"school_say_emoj"), for: .normal)
        bottomView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenViewWidth/6*5)
            make.centerY.equalToSuperview()
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
        self.view.addSubview(locationBtn)
        locationBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.bottom.equalTo(bottomView.snp.top).offset(-kHomeEdgeSpace)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }

    }

    @objc fileprivate func saveSay()
    {
//        if self.textView.text?.trimAfterCount() == 0
//        {
//            MBProgressHUD.show(error: "请填写内容")
//            return
//        }
        
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["contentText"] = self.textView.text
        param["categoryId"] = "1"  //1心情 2约吧
        
        if self.selectImg == nil
        {
            BaseViewModel().post(url: kAddCircleURL, param: param, MBProgressHUD: true, success: { (res) in
                MBProgressHUD.show(info: "添加成功")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }, noData: nil, failure: nil)
        }
        else
        {
            BaseViewModel().postImages(url: kUploadImageURL, param: ["path":"Vep","type":"0"], picArray: [self.selectImg!], isProgressHud: false, commonFileName: "image", progress: nil, success: { (resp) in
                param["imageUrl1"] = resp?["url"].stringValue
                BaseViewModel().post(url: kAddCircleURL, param: param, MBProgressHUD: true, success: { (res) in
                    MBProgressHUD.show(info: "添加成功")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }, noData: nil, failure: nil)
            }, failure: nil)
        }
    }
    
    @objc fileprivate func imgBtnClicked()
    {
        let imagePickerVC = TZImagePickerController(maxImagesCount: 1, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)
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
        
        //裁剪正方形图片
        imagePickerVC?.showSelectBtn = false
        imagePickerVC?.allowCrop = true
        imagePickerVC?.cropRect = CGRect(x: 0, y: kScreenViewHeight*0.5 - kScreenViewWidth*0.5, width: kScreenViewWidth, height: kScreenViewWidth)
  
        imagePickerVC?.isSelectOriginalPhoto = false   //默认是不选择原图按钮的
        imagePickerVC?.didFinishPickingPhotosHandle = {[weak self] (photos,assets,isSelectOriginalPhoto) in
            self?.selectImg = photos?.first
            let imgView = UIImageView()
            imgView.image = photos?.first
            self?.view.addSubview(imgView)
            
            let imgViewWidth = (kScreenViewWidth - 60)/3
            imgView.snp.makeConstraints({ (make) in
                make.top.equalTo((self?.textView.snp.bottom)!).offset(kHomeEdgeSpace*2)
                make.left.equalToSuperview().offset(kHomeEdgeSpace)
                make.width.height.equalTo(imgViewWidth)
            })
            
        }
        self.present(imagePickerVC!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJAddSayController:UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        if textView.text.count > 0
        {
            self.navigationItem.rightBarButtonItem?.tintColor = kTabbarBlueColor
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else
        {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.color(hex: "#cccccc")
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
