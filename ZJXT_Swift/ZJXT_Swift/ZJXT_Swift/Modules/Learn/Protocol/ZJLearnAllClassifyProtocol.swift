//
//  ZJLearnAllClassifyProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/22.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnAllClassifyProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJLearnHomeClassModel]()
}

extension ZJLearnAllClassifyProtocol:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArray[section].courseList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZJLearnAllClassifyCell", for: indexPath) as! ZJLearnAllClassifyCell
        
        cell.model = self.dataArray[indexPath.section].courseList?[indexPath.row]
        
        let arrayCount = self.dataArray[indexPath.section].courseList!.count
        let value = Double(arrayCount)
        
        let last = value.truncatingRemainder(dividingBy: 3.0)
        if last > 0
        {
            if last == 1.0
            {
                if indexPath.row == arrayCount - 2 || indexPath.row == arrayCount - 3
                {
                    cell.bottomLineView.isHidden = false
                }
                else
                {
                    cell.bottomLineView.isHidden = true
                }
            }
            else if last == 2.0
            {
                if indexPath.row == arrayCount - 3
                {
                    cell.bottomLineView.isHidden = false
                }
                else
                {
                    cell.bottomLineView.isHidden = true
                }
            }
            else
            {
                cell.bottomLineView.isHidden = true
            }
        }
        else
        {
            cell.bottomLineView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: kScreenViewWidth/3, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: kScreenViewWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if kind == UICollectionElementKindSectionHeader
        {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ZJLearnAllClassifyHeaderView", for: indexPath) as! ZJLearnAllClassifyHeaderView
            view.backgroundColor = kBackgroundColor
            
            let model = self.dataArray[indexPath.section]
            view.model = model
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
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = self.dataArray[indexPath.section].courseList?[indexPath.row]
        
        let toVC = ZJLearnCourseInfoController()
        toVC.navTitle = "内容详情"
        toVC.model = model
        self.controller.navigationController?.pushViewController(toVC, animated: true)

        //以前写的，忘记具体用在哪里了，所以注释下
//        if indexPath.section == 0
//        {
//            if indexPath.row == 7
//            {
//                let toVC = ZJLearnAllClassifyController()
//                toVC.navTitle = "全部分类"
//                self.controller.navigationController?.pushViewController(toVC, animated: true)
//            }
//        }
//        else
//        {
//            let toVC = ZJLearnCourseInfoController()
//            toVC.navTitle = "内容详情"
//            self.controller.navigationController?.pushViewController(toVC, animated: true)
//        }
    }
}

