//
//  ZJHomeInternshipHomeProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJHomeInternshipHomeProtocol: NSObject
{
    weak var controller:UIViewController!
    var dataArray = [ZJInternshipJobModel]()
}

extension ZJHomeInternshipHomeProtocol:UITableViewDelegate,UITableViewDataSource
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = "- 为你推荐相关的职位 -"
        label.textColor = UIColor.color(hex: "#666666")
        label.font = UIFont.systemFont(ofSize: 16)
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kCellLineColor
        headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = self.dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeInternshipJobCell") as! ZJHomeInternshipJobCell
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArray[indexPath.row]

        let toVC = ZJHomeInternShipJobInfoController()
        toVC.navTitle = "职位详情"
        toVC.model = model
        self.controller.navigationController?.pushViewController(toVC, animated: true)
    }

}
