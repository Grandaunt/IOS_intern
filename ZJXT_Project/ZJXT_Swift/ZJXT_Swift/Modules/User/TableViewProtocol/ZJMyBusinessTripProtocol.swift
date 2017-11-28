//
//  ZJMyBusinessTripProtocol.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//

class ZJMyBusinessTripProtocol: NSObject
{
    var dataArray = [ZJMyBusinessTripModel]()
    var controller:UIViewController!
}

extension ZJMyBusinessTripProtocol:UITableViewDelegate,UITableViewDataSource
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
        return 98
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJMyWeeklyJournalCell") as! ZJMyWeeklyJournalCell
        let model = self.dataArray[indexPath.row]
        cell.timeLabel.text = model.applyTime
        cell.companyName.text = UserInfo.shard.companyName
        cell.otherTimeLabel.text = (model.leaveStartTime ?? "暂无")  + " - " + (model.leaveEndTime ?? "暂无")
        
        switch model.checkStatus
        {
        case "1"?:
            cell.stateBtn.setTitle("待审核",for: .normal)
        case "2"?:
            cell.stateBtn.setTitle("请假批准",for: .normal)
        case "3"?:
            cell.stateBtn.setTitle("请假驳回",for: .normal)
        case "4"?:
            cell.stateBtn.setTitle("取消请假",for: .normal)
            
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let model = self.dataArray[indexPath.row]
//        let toVC = ZJISAlreadyLeaveController()
//        toVC.navTitle = model.leaveType == "1" ? "请假详情" : "出差详情"
//        toVC.type = model.leaveType == "1" ? .leave : .trip
//        toVC.editModel = model
//        self.controller.navigationController?.pushViewController(toVC, animated: true)

    }
}
