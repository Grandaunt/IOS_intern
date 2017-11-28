//
//  ZJLearnSearchResultProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/21.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJLearnSearchResultProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJLearnHomeCourseModel]()
}

extension ZJLearnSearchResultProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJLearnClassifyInfoCell") as! ZJLearnClassifyInfoCell
        cell.model = self.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let toVC = ZJLearnCourseInfoController()
        toVC.navTitle = "课程详情"
        toVC.model = self.dataArray[indexPath.row]
        self.controller.navigationController?.pushViewController(toVC, animated: true)
    }
}
