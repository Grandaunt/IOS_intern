//
//  ZJCommentListProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/20.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJCommentListProtocol: NSObject
{
    var model:ZJCircleCommentModel?
    
    weak var controller:ZJCommentListController!
}

extension ZJCommentListProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.model == nil
        {
            return 0
        }
        guard section == 0 else {
            return (self.model?.circleCommentSubList?.count)!
        }
        return 1
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJCommentListCell") as! ZJCommentListCell
        
        if indexPath.section == 0
        {
            cell.backgroundColor = UIColor.white
            cell.thumBtn.isHidden = false
            
            cell.imgView.af_setImage(withURL: URL(string: (self.model?.logo)!)!, placeholderImage: kUserLogoPlaceHolder)
            cell.nameLabel.text = self.model?.nickName
            cell.timeLabel.text = self.model?.commentDate
            cell.infoLabel.attributedText = Utils.getAttributeStringWithString((self.model?.comment ?? ""), lineSpace: 3)
            cell.thumBtn.setTitle(self.model?.praiseNumber, for: .normal)
            cell.thumBtn.isSelected = self.model?.isPraise == "YES" ? true : false
            weak var weakCell = cell
            cell.thumAction = {
                var param = [String:Any]()
                param["circleId"] = self.model?.circleId
                param["userId"] = UserInfo.shard.userId
                param["commentId"] = self.model?.circleCommentId
                BaseViewModel().post(url: kAddCircleCommentThumURL, param: param, MBProgressHUD: false, success: { (resp) in
                    weakCell?.thumBtn.isSelected = !(weakCell?.thumBtn.isSelected)!
                    if (weakCell?.thumBtn.isSelected)!
                    {
                        let str = String(format: "%d", (((self.model?.praiseNumber)! as NSString).integerValue + 1))
                        self.model?.praiseNumber = str
                        weakCell?.thumBtn.setTitle(str, for: .normal)
                        
                    }
                    else
                    {
                        let str = String(format: "%d", (((self.model?.praiseNumber)! as NSString).integerValue - 1))
                        self.model?.praiseNumber = str
                        weakCell?.thumBtn.setTitle(str, for: .normal)
                        
                    }
                }, noData: nil, failure: nil)
            }
        }
        else
        {
            cell.backgroundColor = UIColor.color(hex: "#F9F9F9")
            cell.model = self.model?.circleCommentSubList?[indexPath.row]
            cell.thumBtn.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.model?.circleCommentSubList![indexPath.row]
        if indexPath.section != 0
        {
            let inputView = ZJInputPanelView.inputPanelView()
            inputView.show()
            inputView.inputDoneAction = { text in
                var param = [String:Any]()
                param["circleId"] = model?.circleId
                param["userId"] = UserInfo.shard.userId
                param["comment"] = text
                param["commentId"] = model?.commentId
                param["toUserId"] = model?.userId
                
                BaseViewModel().post(url: kAddCircelCommentSubURL, param: param, MBProgressHUD: false, success: { (resp) in
                    self.controller.requestData()
                }, noData: nil, failure: nil)
            }
        }
    }
    
}
