//
//  ZJMyLogProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyLogProtocol: NSObject
{
    var dataArray = [ZJMyLogModel]()
    var controller:UIViewController!
}

extension ZJMyLogProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 67
    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJMyLogCell") as! ZJMyLogCell
        cell.model = self.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let toVC = ZJISAlreadyJournalController()
//        toVC.navTitle = "日志详情"
//        toVC.editModel = self.dataArray[indexPath.row]
//        self.controller.navigationController?.pushViewController(toVC, animated: true)

    }
}


