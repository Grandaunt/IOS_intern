//
//  ZJMySettingProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/13.
//  Copyright © 2017年 runer. All rights reserved.
//

import MBProgressHUD

class ZJMySettingProtocol: NSObject
{
    weak var controller:UIViewController!

}

extension ZJMySettingProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard section == 0 else {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 15
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
        return 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ZJMySettingCell
        if cell == nil
        {
            cell = ZJMySettingCell(style: .value1, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0
        {
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            
            if indexPath.row == 0
            {
                cell?.textLabel?.text = "清除缓存"
                cell?.detailTextLabel?.text = CacheUtils.returnCacheSize() + "M"
                cell?.bottomLineStyle = .fill
            }
            else
            {
                cell?.textLabel?.text = "关于我们"
                cell?.detailTextLabel?.text = ""
                cell?.bottomLineStyle = .none
            }
            cell?.accessoryType = .disclosureIndicator
            
            cell?.textLabel?.textColor = UIColor.color(hex: "#333333")
        }
        else
        {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.color(hex: "#333333")
            label.text = "退出账号"
            cell?.contentView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
            })
            cell?.bottomLineStyle = .none
            cell?.accessoryType = .none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let cell = tableView.cellForRow(at: indexPath)
                CacheUtils.cleanCache(competion: {
                    MBProgressHUD.show(info: "清除成功")
                    cell?.detailTextLabel?.text = CacheUtils.returnCacheSize() + "M"
                })
            }
            else
            {
                let toVC = ZJAhoutUSController()
                toVC.navTitle = "关于我们"
                self.controller.navigationController?.pushViewController(toVC, animated: true)
            }
        }
        else
        {
            if UserInfo.delete() == true
            {
//                self.controller.navigationController?.popViewController(animated: true)
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.initTabBarController()
            }
        }
    }
}
