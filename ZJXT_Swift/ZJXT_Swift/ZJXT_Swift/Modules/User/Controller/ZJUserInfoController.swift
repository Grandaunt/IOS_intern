//
//  ZJUserInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/7.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

//用户信息的编辑类型
enum UserInfoType:Int
{
    case text = 0
    case select
    case radio
}

class ZJUserInfoController: SecondViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    fileprivate let titleArray:[[[String:Any]]] = [
                                    [
                                        ["title":"姓名","type":UserInfoType.text,"placeHolder":"请输入姓名"],
                                        ["title":"性别","type":UserInfoType.radio],
                                        ["title":"昵称","type":UserInfoType.text,"placeHolder":"请输入昵称"],
                                        ["title":"出生年月","type":UserInfoType.text,"placeHolder":"请选择"],
                                        ["title":"身份证号","type":UserInfoType.text,"placeHolder":"请输入身份证号"]
                                    ],
                                    [
                                        ["title":"学校","type":UserInfoType.text,"placeHolder":"请选择"],
                                        ["title":"学号","type":UserInfoType.text,"placeHolder":"请输入姓学号"],
                                        ["title":"专业","type":UserInfoType.text,"placeHolder":"请输入专业"],
                                        ["title":"班级","type":UserInfoType.text,"placeHolder":"请输入班级"],
                                        ["title":"院系","type":UserInfoType.text,"placeHolder":"请输入院系"],
                                        ["title":"入学年份","type":UserInfoType.text,"placeHolder":"请选择"],
                                        ["title":"离校年份","type":UserInfoType.text,"placeHolder":"请选择"]
                                    ]
                                 ]
    
    fileprivate lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: kScreenViewHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.backgroundColor = kBackgroundColor
        tableView.tableHeaderView = self?.createHeaderView()
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJUserInfoProtocol = {[weak self] in
        let tableViewProtocol = ZJUserInfoProtocol()
        tableViewProtocol.titleArray = self?.titleArray
        tableViewProtocol.controller = self
        return tableViewProtocol
    }()
    
    fileprivate var logoBtn:UIButton?
    
    fileprivate var backViewBtn:UIButton?
    
    fileprivate var tapImgBtn:UIButton?  //点击的哪个图片按钮

    fileprivate var viewModel = ZJUserInfoViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func initNav()
    {
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func save()
    {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! ZJUserInfoCell
        let nickName = cell.textField.text
        self.viewModel.update(nickName: nickName, img: self.logoBtn?.backgroundImage(for: .normal), icon: self.backViewBtn?.backgroundImage(for: .normal)) {
            self.navigationController?.popViewController(animated: true)

        }
    }
    
    fileprivate func createHeaderView() -> UIView
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 175))
        
        let backViewBtn = UIButton()
        backViewBtn.addTarget(self, action: #selector(tapImageAction(btn:)), for: .touchUpInside)
        backViewBtn.imageView?.contentMode = .scaleAspectFit
        self.backViewBtn = backViewBtn
        headerView.addSubview(backViewBtn)
        backViewBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let logoBtn = UIButton()
        logoBtn.layer.masksToBounds = true
        logoBtn.layer.cornerRadius = 38
        self.logoBtn = logoBtn
        backViewBtn.addSubview(logoBtn)
        logoBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(75)
        }
        
        if UserInfo.shard.icon?.trimAfterCount() == 0 || UserInfo.shard.icon == nil
        {
            
        }
        else
        {
            backViewBtn.af_setBackgroundImage(for: .normal, url: URL(string: UserInfo.shard.icon!)!, placeholderImage: nil)
        }
        
        if UserInfo.shard.logo?.trimAfterCount() == 0 || UserInfo.shard.logo == nil
        {
            logoBtn.setBackgroundImage(kUserLogoPlaceHolder, for: .normal)
            
        }
        else
        {
            logoBtn.af_setBackgroundImage(for: .normal, url: URL(string: UserInfo.shard.logo!)!, placeholderImage: kUserLogoPlaceHolder)
        }
        
        logoBtn.addTarget(self, action: #selector(tapImageAction(btn:)), for: .touchUpInside)
        
        return headerView
    }
    
    //头像按钮点击
    @objc fileprivate func tapImageAction(btn:UIButton)
    {
        self.tapImgBtn = btn
        
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let cameraAction = UIAlertAction(title: "相机", style: UIAlertActionStyle.default, handler: { (action) in
                imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            })
            let photoAciton = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.default, handler: { (action) in
                imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
                
            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            
            controller.addAction(cameraAction)
            controller.addAction(photoAciton)
            controller.addAction(cancelAction)
        }
        else
        {
            let photoAciton = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.default, handler: { (action) in
                imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            
            controller.addAction(photoAciton)
            controller.addAction(cancelAction)
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            let tempImage = info[UIImagePickerControllerEditedImage] as! UIImage
            UIGraphicsBeginImageContext(tempImage.size)
            tempImage.draw(in: CGRect(x: 0, y: 0, width: tempImage.size.width, height: tempImage.size.height))
            let image = UIImage(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage)!)
            
            if self.tapImgBtn == self.logoBtn
            {
                self.logoBtn?.setBackgroundImage(image, for: .normal)
            }
            else
            {
                self.backViewBtn?.setBackgroundImage(image, for: .normal)

            }
            UIGraphicsEndImageContext()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
