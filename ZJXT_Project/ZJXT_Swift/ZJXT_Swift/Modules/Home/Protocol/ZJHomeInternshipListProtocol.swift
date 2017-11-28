//
//  ZJHomeInternshipListProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/27.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeInternshipListProtocol: NSObject
{
    weak var controller:ZJHomeInternshipListController!
    var type:InternShipPlaceType!
    var dataArray = [Any]()
}

extension ZJHomeInternshipListProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if self.type == .base
        {
            let model = self.dataArray[indexPath.row] as! ZJBaseListModel
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeInternShipListCell") as! ZJHomeInternShipListCell
            cell.model = model
            return cell
        }
        else
        {
            let model = self.dataArray[indexPath.row] as! ZJInternshipJobModel
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeInternshipJobCell") as! ZJHomeInternshipJobCell
            cell.model = model

            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.type == .base
        {
            if self.controller.selectBaseAction != nil
            {
                let model = self.dataArray[indexPath.row] as! ZJBaseListModel
                self.controller.selectBaseAction!(model)
                self.controller.navigationController?.popViewController(animated: true)
            }
        }
        else
        {
            if self.controller.selectEnAction != nil
            {
                let model = self.dataArray[indexPath.row] as! ZJInternshipJobModel
                self.controller.selectEnAction!(model)
                self.controller.navigationController?.popViewController(animated: true)
            }

        }
        
    }
}
