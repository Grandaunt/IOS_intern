//
//  ZJAddCertController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/15.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import MBProgressHUD

class ZJAddCertController: SecondViewController
{
    
    fileprivate var itemWH:CGFloat = 0.0
    fileprivate var margin:CGFloat = 0.0
    
    fileprivate var location:CLLocation?
    
    fileprivate var layout = LxGridViewFlowLayout()
    
    fileprivate var selectedPhotos = [UIImage]()
    fileprivate var selectedAssets = [Any]()
    
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: (self?.layout)!)
        
        collection.alwaysBounceVertical = false
        collection.backgroundColor = kBackgroundColor
//        collection.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
        collection.dataSource = self;
        collection.delegate = self;
        collection.keyboardDismissMode = .onDrag;
        collection.register(TZTestCell.classForCoder(), forCellWithReuseIdentifier: "TZTestCell")
        return collection
    }()
    
    fileprivate lazy var imagePickerVc:UIImagePickerController = {[weak self] in
        let imagePickerVc = UIImagePickerController()
        imagePickerVc.delegate = self
        // set appearance / 改变相册选择页的导航栏外观
        imagePickerVc.navigationBar.barTintColor = self?.navigationController?.navigationBar.barTintColor;
        imagePickerVc.navigationBar.tintColor = self?.navigationController?.navigationBar.tintColor;

//        var tzBarItem:UIBarButtonItem
//        var BarItem:UIBarButtonItem
//    
//        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
//        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
//        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        return imagePickerVc
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.addSubview(self.collectionView)
        
        
    }
    
    fileprivate func initNav()
    {
        //调整位置，以防往右偏移        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        self.margin = 4
        self.itemWH = (self.view.tz_width - 2 * self.margin - 4)/3 - self.margin
        
        self.layout.itemSize = CGSize(width: self.itemWH, height: self.itemWH)
        self.layout.minimumInteritemSpacing = self.margin
        self.layout.minimumLineSpacing = self.margin
        self.collectionView.collectionViewLayout = self.layout
        self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.tz_width, height: self.itemWH*2 + self.margin)
        
    }
    
    @objc fileprivate func deleteBtnClicked(btn:UIButton)
    {
        self.selectedPhotos.remove(at: btn.tag)
        self.selectedAssets.remove(at: btn.tag)
        
        self.collectionView.performBatchUpdates({ 
            let indexPath = IndexPath(item: btn.tag, section: 0)
            self.collectionView.deleteItems(at: [indexPath])
        }) { (finished) in
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func refreshCollectionViewWithAddedAsset(asset:Any,image:UIImage)
    {
        self.selectedAssets.append(asset)
        self.selectedPhotos.append(image)
        self.collectionView.reloadData()
    }
    
    //拍照
    fileprivate func takePhoto()
    {
        let autoStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if autoStatus == AVAuthorizationStatus.restricted || autoStatus == AVAuthorizationStatus.denied {
            let alertCancel = UIAlertAction(title: "取消", style: .cancel, handler: { (alert) in
                
            })
            
            let alertSet = UIAlertAction(title: "设置", style: .default, handler: { (alert) in
                
                if #available(iOS 10.0, *)
                {
                    UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                }
                else
                {
                    UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
                }
            })
            
            let alertController = UIAlertController(title: "无法使用相机", message: "请在iPhone的\"设置-隐私-相机\"中允许访问相机", preferredStyle: .alert)
            alertController.addAction(alertCancel)
            alertController.addAction(alertSet)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if autoStatus == AVAuthorizationStatus.notDetermined
        {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted
                {
                    self.takePhoto()
                }
            })
        }
        else if TZImageManager.authorizationStatus() == 2          // 拍照之前还需要检查相册权限
        {
            let alertCancel = UIAlertAction(title: "取消", style: .cancel, handler: { (alert) in
                
            })
            
            let alertSet = UIAlertAction(title: "设置", style: .default, handler: { (alert) in
                
                if #available(iOS 10.0, *)
                {
                    UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                }
                else
                {
                    UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
                }
            })
            
            let alertController = UIAlertController(title: "无法访问相册", message: "请在iPhone的\"设置-隐私-相册\"中允许访问相册", preferredStyle: .alert)
            alertController.addAction(alertCancel)
            alertController.addAction(alertSet)
            
        }
        else if TZImageManager.authorizationStatus() == 0  //// 未请求过相册权限
        {
            TZImageManager.default().requestAuthorization(completion: {
                self.takePhoto()
            })
        }
        else
        {
            
        }
    }
    
    fileprivate func pushImagePickerController()
    {
        weak var weakSelf = self
        
        TZLocationManager().startLocation(successBlock: { (location, oldLocation) in
            weakSelf?.location = location
        }) { (error) in
            weakSelf?.location = nil
        }
        
        let sourceType = UIImagePickerControllerSourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
        {
            self.imagePickerVc.sourceType = sourceType
            
            self.imagePickerVc.modalPresentationStyle = .overCurrentContext
            self.present(imagePickerVc, animated: true, completion: nil)
        }
        else
        {
            
        }
    }
    
    fileprivate func pushTZImagePickerController()
    {
        let imagePickerVC = TZImagePickerController(maxImagesCount: 6, columnNumber: 4, delegate: self, pushPhotoPickerVc: true)
        
        imagePickerVC?.isSelectOriginalPhoto = false
        
        imagePickerVC?.selectedAssets = NSMutableArray(array: self.selectedAssets)
        
        imagePickerVC?.allowTakePicture = true
        
        imagePickerVC?.allowPickingVideo = false
        imagePickerVC?.allowPickingImage = true
        imagePickerVC?.allowPickingOriginalPhoto = true
        imagePickerVC?.allowPickingMultipleVideo = false
        
        self.present(imagePickerVC!, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJAddCertController:UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,LxGridViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.selectedPhotos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TZTestCell", for: indexPath) as! TZTestCell
        cell.videoImageView.isHidden = true
        cell.gifLable.isHidden = true

        if indexPath.row == self.selectedPhotos.count
        {
            cell.imageView.image = UIImage(named: "AlbumAddBtn")
            cell.deleteBtn.isHidden = true
        }
        else
        {
            cell.imageView.image = self.selectedPhotos[indexPath.row]
            cell.deleteBtn.isHidden = false
        }
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked(btn:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == self.selectedPhotos.count
        {
//            let alertAction = UIAlertAction(title: "拍照", style: .default, handler: { (alert) in
//                self.takePhoto()
//            })
//            
//            let photoAction = UIAlertAction(title: "去相册选择", style: .default, handler: { (alert) in
//                self.pushTZImagePickerController()
//            })
//            
//            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            
//            let acitonController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//            
//            acitonController.addAction(alertAction)
//            acitonController.addAction(photoAction)
//            acitonController.addAction(cancelAction)
//            self.present(acitonController, animated: true, completion: nil)
            self.pushTZImagePickerController()
        }
        else
        {
            let tzImgPicker = TZImagePickerController(selectedAssets: NSMutableArray(array: self.selectedAssets), selectedPhotos: NSMutableArray(array: self.selectedPhotos), index: indexPath.row)
            tzImgPicker?.maxImagesCount = 6
            
            tzImgPicker?.didFinishPickingPhotosHandle = {(photos,assets,isSelectOriginalPhoto) in
                self.selectedPhotos = photos!
                self.selectedAssets = assets!
                
                self.collectionView.reloadData()
                self.collectionView.contentSize = CGSize(width: 0, height: (CGFloat(self.selectedPhotos.count + 2) / 3 ) * (self.margin + self.itemWH))
            }
            
            self.present(tzImgPicker!, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
    {
        return indexPath.item < self.selectedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView!, itemAt sourceIndexPath: IndexPath!, canMoveTo destinationIndexPath: IndexPath!) -> Bool
    {
        return (sourceIndexPath.item < self.selectedPhotos.count && destinationIndexPath.item < self.selectedPhotos.count)
    }
    
    func collectionView(_ collectionView: UICollectionView!, itemAt sourceIndexPath: IndexPath!, didMoveTo destinationIndexPath: IndexPath!)
    {
        let image = self.selectedPhotos[sourceIndexPath.item]
        
        self.selectedPhotos.remove(at: sourceIndexPath.item)
        self.selectedPhotos.insert(image, at: destinationIndexPath.item)
        
        let asset = self.selectedAssets[sourceIndexPath.item]
        self.selectedAssets.remove(at: sourceIndexPath.item)
        self.selectedAssets.insert(asset, at: destinationIndexPath.item)
        
        self.collectionView.reloadData()
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!)
    {
        self.selectedPhotos = photos
        self.selectedAssets = assets
        self.collectionView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        
        let type = info["UIImagePickerControllerMediaType"] as! String
        
        if type == "public.image"
        {
            let tzImagePickerVC = TZImagePickerController(maxImagesCount: 1, delegate: self)
            
            tzImagePickerVC?.showProgressHUD()
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            TZImageManager.default().savePhoto(with: image, location: self.location, completion: { (error) in
                if error != nil
                {
                    tzImagePickerVC?.hideProgressHUD()
                    MBProgressHUD.show(error: "图片保存失败")
                }
                else
                {
                    TZImageManager.default().getCameraRollAlbum(false, allowPickingImage: true, completion: { (model) in
                        
                        TZImageManager.default().getAssetsFromFetchResult(model?.result, allowPickingVideo: false, allowPickingImage: true, completion: { (models) in
                            tzImagePickerVC?.hideProgressHUD()
                            
                            let assetModel = models?.first
                            
                            self.refreshCollectionViewWithAddedAsset(asset: (assetModel?.asset)!, image: image)
                        })
                        
                        
                    })
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
