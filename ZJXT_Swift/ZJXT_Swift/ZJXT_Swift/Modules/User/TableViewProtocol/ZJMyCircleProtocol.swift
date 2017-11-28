//
//  ZJMyCircleProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyCircleProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJCircleModel]()
    var delCircleAction:((String,IndexPath)->Void)?
}

extension ZJMyCircleProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = UIView()
//        headerView.backgroundColor = kBackgroundColor
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = self.dataArray[indexPath.row]
        //约吧
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ZJMyCircleCallCell") as! ZJMyCircleCallCell
        cell1.deleteBtn.isHidden = false
        cell1.deleteAction = {
            if self.delCircleAction != nil
            {
                self.delCircleAction!(model.circleId!,indexPath)
            }
        }
        //心情
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "ZJMyCircleTextCell") as! ZJMyCircleTextCell
        cell2.deleteBtn.isHidden = false
        cell2.deleteAction = {
            if self.delCircleAction != nil
            {
                self.delCircleAction!(model.circleId!,indexPath)
            }
        }

        //心情
        if model.categoryId == "1"
        {
            cell2.model = model
            return cell2
        }
        else  //约吧
        {
            cell1.model = model
            return cell1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArray[indexPath.row]
        
        let toVC = ZJSayInfoController()
        toVC.navTitle = "详情"
        toVC.model = model
        self.controller.navigationController?.pushViewController(toVC, animated: true)

    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
//    {
//        return .delete
//    }
//    
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
//    {
//        return "删除"
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    {
//        let model = self.dataArray[indexPath.row]
//        if editingStyle == .delete
//        {
//            
//            if self.delCircleAction != nil
//            {
//                self.delCircleAction!(model.circleId!,indexPath)
//            }
//        }
//    }
}
