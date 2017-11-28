//
//  ZJRecruitSearchProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJRecruitSearchProtocol: NSObject
{
    weak var controller:UIViewController!
    var searchStr:String!
}

extension ZJRecruitSearchProtocol:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        let toVC = ZJRecruitSearchResultController()
        toVC.searchStr = self.searchStr
        self.controller.navigationController?.pushViewController(toVC, animated: true)
        
        return true
    }
    
    //MARK:- UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
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
        return 49
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 49))
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.color(hex: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        
        let str = String(format: "搜索\"%@\"的公司", self.searchStr)
        let attr = NSMutableAttributedString(string: str)
        let range = (str as NSString).range(of: self.searchStr)
        
        attr.addAttributes([NSAttributedStringKey.foregroundColor:kTabbarBlueColor], range: range)
        
        titleLabel.attributedText = attr
        
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        let infoLabel = UILabel()
        infoLabel.textColor = UIColor.color(hex: "#929292")
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "共10条结果"
        
        headerView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BaseTableViewCell
        if  cell == nil
        {
            cell = BaseTableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.bottomLineStyle = .fill
        cell?.imageView?.image = IconFontUtils.imageSquare(code: "\u{e633}", size: 15, color: UIColor.color(hex: "#929292"))
        
        let titleArray = ["UI设计师","UI设计师1","UI设计师11","UI设计师111","UI设计师1111","UI设计师1111","UI设计师11","UI设计师1","UI设计师1","UI设计师22"]
        cell?.textLabel?.textColor = UIColor.color(hex: "#929292")
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        let str = titleArray[indexPath.row]
        let attr = NSMutableAttributedString(string: str)
        let range = (str as NSString).range(of: self.searchStr, options: NSString.CompareOptions.caseInsensitive)
        
        attr.addAttributes([NSAttributedStringKey.foregroundColor:kTabbarBlueColor], range: range)
        
        cell?.textLabel?.attributedText = attr
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        let toVC = ZJRecruitSearchResultController()
        toVC.searchStr = cell?.textLabel?.text
        self.controller.navigationController?.pushViewController(toVC, animated: true)

    }
}
