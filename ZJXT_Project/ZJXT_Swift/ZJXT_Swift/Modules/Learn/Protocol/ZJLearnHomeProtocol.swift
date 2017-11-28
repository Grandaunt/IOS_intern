//
//  ZJLearnHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnHomeProtocol: NSObject
{
    weak var controller:UIViewController!
    var categoryDataArray = [ZJLearnHomeClassModel]()  //分类
    var hotArray = [ZJLearnHomeCourseModel]()   //热门
    var recommendArray = [ZJLearnHomeCourseModel]()   //推荐

}

extension ZJLearnHomeProtocol:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0
        {
            if self.categoryDataArray.count > 7
            {
                return 8
            }
            else
            {
                if self.categoryDataArray.count == 0
                {
                    return 0
                }
                return self.categoryDataArray.count + 1
            }
        }
        else if section == 1
        {
            return self.hotArray.count
        }
        else
        {
            return self.recommendArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.section == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZJLearnHomeClassCell", for: indexPath) as! ZJLearnHomeClassCell
            //如果是最后一个或者是第八个
            if (indexPath.row == 0 && self.categoryDataArray.count == 0) || indexPath.row == 7
            {
                let model = ZJLearnHomeClassModel()
                model.categoryName = "全部分类"
                model.img = UIImage(named: "learn_all_category")
                cell.model = model
            }
            else
            {
                cell.model = self.categoryDataArray[indexPath.row]
            }
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZJLearnHomeVideoCell", for: indexPath) as! ZJLearnHomeVideoCell
            cell.model = self.hotArray[indexPath.row]
            return cell

        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZJLearnHomeVideoCell", for: indexPath) as! ZJLearnHomeVideoCell
            cell.model = self.recommendArray[indexPath.row]
            return cell

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        guard indexPath.section == 0 else {
            let width = (kScreenViewWidth - 15*4)/2
            let height = width/1.68 + 70  //70是除去图片以后的高度
            return CGSize(width: width, height: height)
        }
        return CGSize(width: kScreenViewWidth*0.25, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        guard section == 0 else {
            return 15
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        guard section == 0 else {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
//        guard section == 0 else {
//            return CGSize.zero
//        }
        return CGSize(width: kScreenViewWidth, height: kHomeEdgeSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        guard section == 0 else {
            if self.hotArray.count == 0 || self.recommendArray.count == 0
            {
                return CGSize.zero
            }
            return CGSize(width: kScreenViewWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if kind == UICollectionElementKindSectionHeader
        {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ZJLearnHomeHeaderView", for: indexPath) as! ZJLearnHomeHeaderView
            if indexPath.section == 1
            {
                view.titleLabel.text = "热门课程"
            }
            else
            {
                view.titleLabel.text = "推荐课程"
            }
            return view
        }
        else
        {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            view.backgroundColor = kBackgroundColor
//            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ZJLearnHomeHeaderView", for: indexPath)
            return view
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            if indexPath.row == 7
            {
                let toVC = ZJLearnAllClassifyController()
                toVC.navTitle = "全部分类"
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
            else
            {
                let model = self.categoryDataArray[indexPath.row]
                
                let toVC = ZJLearnClassifyInfoController()
                toVC.model = model
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
        }
        else
        {
            let toVC = ZJLearnCourseInfoController()
            toVC.navTitle = "课程详情"
            if indexPath.section == 1
            {
                toVC.model = self.hotArray[indexPath.row]
            }
            else
            {
                toVC.model = self.recommendArray[indexPath.row]
            }
            self.controller.navigationController?.pushViewController(toVC, animated: true)
        }
    }
}
