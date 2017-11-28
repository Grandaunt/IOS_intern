//
//  ZJSayInfoProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/11.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ZJSayInfoProtocol: NSObject
{
    weak var controller:ZJSayInfoController!
    weak var commentBtn:UIButton!
    weak var thumupBtn:UIButton!
    weak var joinBtn:UIButton!
    
//    var model = ZJCircleInfoModel()
    
    var infoModel = ZJCircleModel()   //圈子详情信息
    var commentArray = [ZJCircleCommentModel]()  //评论列表
    var applyArray = [ZJCircleApplyModel]()           //圈子申请列表
    var thumArray = [ZJCirclePraiseModel]()           //圈子点赞


    var editUserInfoAction:((ZJVCResumeInfoModel)->Void)?
}

extension ZJSayInfoProtocol:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard section == 0 else {
            if self.commentBtn.isSelected
            {
                return self.commentArray.count
            }
            else if self.thumupBtn.isSelected
            {
                return self.thumArray.count
            }
            else
            {
                return self.applyArray.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        guard section == 0 else {
            return 49
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        guard section == 0 else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenViewWidth, height: 49))
            headerView.backgroundColor = UIColor.white
            
            headerView.addSubview(self.commentBtn)
            self.commentBtn.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(15)
                make.centerY.equalToSuperview()
            })
            
            headerView.addSubview(self.thumupBtn)
            self.thumupBtn.snp.makeConstraints({ (make) in
                make.left.equalTo(self.commentBtn.snp.right).offset(25)
                make.centerY.equalTo(self.commentBtn)
            })
            
            //召集令
            if self.infoModel.categoryId == "2"
            {
                headerView.addSubview(self.joinBtn)
                self.joinBtn.snp.makeConstraints({ (make) in
                    make.right.equalToSuperview().offset(-15)
                    make.centerY.equalTo(self.commentBtn)
                })
            }
            
            let lineView = UIView()
            lineView.backgroundColor = kCellLineColor
            headerView.addSubview(lineView)
            lineView.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(1)
            })
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        guard section == 0 else {
            return 0.01
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            if self.infoModel.categoryId == "1"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJSayInfoFirstCell") as! ZJSayInfoFirstCell
                cell.model = self.infoModel
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJCallInfoFirstCell") as! ZJCallInfoFirstCell
                cell.model = self.infoModel
                cell.applyAction = {
                    var param = [String:Any]()
                    param["circleId"] = self.infoModel.circleId
                    param["userId"] = UserInfo.shard.userId
                    
                    BaseViewModel().post(url: kCircleApplyURL, param: param, MBProgressHUD: false, success: { (resp) in
                        MBProgressHUD.show(error: "申请成功")
                        
                        let title = self.joinBtn.title(for: .normal)
                        let titleArray = title?.components(separatedBy: " ")
                        
                        let num = Int(titleArray?.last ?? "0")! + 1
                        
                        self.joinBtn.setTitle("已参加 \(num)", for: .normal)
                        
                        let model = ZJCircleApplyModel()
                        model.circleId = self.infoModel.circleId
                        model.logo = UserInfo.shard.logo
                        model.userId = UserInfo.shard.userId
                        model.trueName = UserInfo.shard.trueName
                        model.nickName = UserInfo.shard.nickName

                        self.applyArray.insert(model, at: 0)
                        
                        tableView.reloadData()

                        
                    }, noData: nil, failure: nil)
                    
                }
                return cell
            }
        }
        else
        {
            if self.commentBtn.isSelected
            {
                let model = self.commentArray[indexPath.row]
                
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "ZJCircleCommentCell") as! ZJCircleCommentCell
                cell1.model = model
                cell1.jumpCommentListAction = {
                    let toVC = ZJCommentListController()
                    toVC.navTitle = (model.commentNumber ?? "0") + "条回复"
                    toVC.model = model
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }
                cell1.commentAction = {
                    let toVC = ZJAddCommentController()
                    toVC.circleCommentId = model.circleCommentId
                    toVC.toUser = "@" + (model.nickName ?? "")
                    toVC.toUserId = model.userId
                    toVC.subCommentSuccess = { comment in
                        model.firstSubCommentName = UserInfo.shard.nickName
                        model.commentNumber = "1"
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                    self.controller.navigationController?.pushViewController(toVC, animated: true)
                }
                
                weak var weakCell = cell1
                cell1.thumAction = {
                    var param = [String:Any]()
                    param["circleId"] = model.circleId
                    param["userId"] = UserInfo.shard.userId
                    param["commentId"] = model.circleCommentId
                    BaseViewModel().post(url: kAddCircleCommentThumURL, param: param, MBProgressHUD: false, success: { (resp) in
                        weakCell?.thumBtn.isSelected = !(weakCell?.thumBtn.isSelected)!
                        if (weakCell?.thumBtn.isSelected)!
                        {
                            let str = String(format: "%d", ((model.praiseNumber! as NSString).integerValue + 1))
                            model.praiseNumber = str
                            weakCell?.thumBtn.setTitle(str, for: .normal)
                            
                        }
                        else
                        {
                            let str = String(format: "%d", ((model.praiseNumber! as NSString).integerValue - 1))
                            model.praiseNumber = str
                            weakCell?.thumBtn.setTitle(str, for: .normal)

                        }
                    }, noData: nil, failure: nil)
                }
                
                return cell1

            }
            else if self.thumupBtn.isSelected
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJCallInfoOtherCell") as! ZJCallInfoOtherCell
                cell.model = self.thumArray[indexPath.row]
                cell.telLabel.isHidden = true
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZJCallInfoOtherCell") as! ZJCallInfoOtherCell
                cell.applyModel = self.applyArray[indexPath.row]
                
                if self.infoModel.userId == UserInfo.shard.userId
                {
                    cell.telLabel.isHidden = false
                }
                else
                {
                    cell.telLabel.isHidden = true
                }
                
                return cell

            }
        }
        
    }
}
