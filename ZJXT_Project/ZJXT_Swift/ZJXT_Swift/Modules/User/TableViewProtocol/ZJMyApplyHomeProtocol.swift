//
//  ZJMyApplyHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/13.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyHomeProtocol: NSObject
{
    var dataArray = [ZJMyApplyHomeModel]()
    weak var controller:UIViewController!
}

extension ZJMyApplyHomeProtocol:UITableViewDelegate,UITableViewDataSource
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
        return 95
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJMyApplyHomeCell") as! ZJMyApplyHomeCell
        cell.model = self.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toVC = ZJMyApplyInfoController()
        toVC.navTitle = "申请详情"
        toVC.model = self.dataArray[indexPath.row]
        self.controller.navigationController?.pushViewController(toVC, animated: true)
    }
}
