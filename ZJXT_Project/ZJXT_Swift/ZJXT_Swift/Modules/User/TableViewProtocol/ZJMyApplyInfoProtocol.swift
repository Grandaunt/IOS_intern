//
//  ZJMyApplyInfoProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/13.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJMyApplyInfoProtocol: NSObject
{
    weak var controller:UIViewController!
    var model:ZJMyApplyHomeModel!
}

extension ZJMyApplyInfoProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 15
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
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJMyApplyInfoCell1") as! ZJMyApplyInfoCell1
            cell.model = self.model
            return cell
            
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJMyApplyInfoCell2") as! ZJMyApplyInfoCell2
            cell.model = self.model
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJMyApplyInfoCell3") as! ZJMyApplyInfoCell3
            cell.model = self.model
            cell.mobileAction = { mobile in
                Utils.makePhone(phoneNumber: mobile, superView: self.controller.view)
            }
            return cell
            
        }
    }
}
