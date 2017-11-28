//
//  ZJVCHomeController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/9.
//  Copyright © 2017年 runer. All rights reserved.
//
//  我的简历
import UIKit
import MBProgressHUD

class ZJVCHomeController: SecondViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate
{
    var isFromIndiv = true  //是否从个人中心跳转过来的
    var postId:String?
    var applyType:String?   //1 实习 2全职
    fileprivate lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kBackgroundColor
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
        tableView.estimatedRowHeight = 100
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 20))
        
        tableView.register(UINib(nibName: "ZJVCUserLogoCell", bundle: nil), forCellReuseIdentifier: "ZJVCUserLogoCell")
        tableView.register(UINib(nibName: "ZJVCUserInfoCell", bundle: nil), forCellReuseIdentifier: "ZJVCUserInfoCell")
        tableView.register(UINib(nibName: "ZJVCAddExperienceCell", bundle: nil), forCellReuseIdentifier: "ZJVCAddExperienceCell")
        tableView.register(UINib(nibName:"ZJVCHomeWorkExperienceCell",bundle:nil), forCellReuseIdentifier: "ZJVCHomeWorkExperienceCell")
        tableView.register(UINib(nibName:"ZJVCHomeWorkDesCell",bundle:nil), forCellReuseIdentifier: "ZJVCHomeWorkDesCell")
        
        return tableView
    }()
    
    fileprivate let showInfoArray = [
                                    ["title":"我的头像","isMust":false,],
                                    ["title":"基本信息","isMust":true],
                                    ["title":"实习经历","isMust":true,"btnTitle":"  添加实习经历","labelTitle":"请从最近一份工作说起"],
                                    ["title":"工作经历","isMust":true,"btnTitle":"  添加工作经历","labelTitle":"请从最近一份工作说起"],
                                    ["title":"教育经历","isMust":true,"btnTitle":"  添加教育经历","labelTitle":"请从最高学历说起"],
                                    ["title":"项目经历","isMust":true,"btnTitle":"  添加项目经历","labelTitle":"请着重介绍工作以外的项目经历"],
                                    ["title":"自我评价","isMust":false,"btnTitle":"  添加自我评价","labelTitle":"详细描述你自己，字数控制在10-800"]
                                ]
    
    fileprivate lazy var tableViewProtocol:ZJVCHomeProtocol = {[weak self] in
        let tableViewProtocol = ZJVCHomeProtocol()
        tableViewProtocol.titleArray = self?.showInfoArray
        tableViewProtocol.controller = self
        tableViewProtocol.imgTapAction = { cell in
            self?.tapImageAction()
        }
        tableViewProtocol.editUserInfoAction = {[weak self] model in
            self?.viewModel.editUserInfo(img:self?.tableViewProtocol.selectImg,model: model)
        }
        return tableViewProtocol
    }()

    fileprivate lazy var viewModel = ZJVCHomeViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        initNav()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.viewModel.getVCInfo { (model) in
            self.tableViewProtocol.infoModel = model
            self.tableView.reloadData()
        }
    }
    
    fileprivate func initNav()
    {
        //调整位置，以防往右偏移
        if !self.isFromIndiv
        {
            let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            rightBtn.addTarget(self, action: #selector(sendVC), for: .touchUpInside)
            rightBtn.setTitle("发送", for: .normal)
            rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            let rightItem = UIBarButtonItem(customView: rightBtn)
            self.navigationItem.rightBarButtonItem = rightItem
        }
    }
    
    @objc fileprivate func sendVC()
    {
        self.viewModel.getVCInfo { (model) in
            if model?.resumeinfo?.userName == nil || model?.resumeinfo?.resumeMale == nil || model?.resumeinfo?.resumepost == nil || model?.resumeinfo?.resumeAddress == nil || model?.resumeinfo?.resumeTel == nil || model?.resumeinfo?.resumeEmile == nil
            {
                MBProgressHUD.show(error: "请完善基本信息")
                return
            }
            
            var param = [String:Any]()
            param["postId"] = self.postId
            param["userId"] = UserInfo.shard.userId
            param["applyType"] = self.applyType  //1实习 2全职
            
            BaseViewModel().post(url: kJobApplyURL, param: param, MBProgressHUD: true, success: {(resp) in
                MBProgressHUD.show(info: "发送成功")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
            }, noData: nil, failure: nil)
        }
    }
    
    //头像按钮点击
    @objc fileprivate func tapImageAction()
    {
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
            
            //设置图片
            self.tableViewProtocol.logoCell?.logoImgView.image = image
            self.tableViewProtocol.selectImg = image
            self.changeUserImageAction(image:image)
            UIGraphicsEndImageContext()
        }
    }
    //请求服务器上传图片
    private func changeUserImageAction(image:UIImage)
    {
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
