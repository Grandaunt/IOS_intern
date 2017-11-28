//
//  ZJHomeApplyInternShipController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/25.
//  Copyright © 2017年 runer. All rights reserved.
//
//  申请实习界面

import UIKit
import MBProgressHUD

class ZJHomeApplyInternShipController: SecondViewController
{
    fileprivate var planModel:ZJInternshipPlanModel?
    //实习方式的选择按钮
    fileprivate var selectBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("请选择", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e6a3}", size: 15, color: UIColor.lightGray), for: .normal)
        btn.setImage(IconFontUtils.imageSquare(code: "\u{e661}", size: 15, color: kTabbarBlueColor), for: .selected)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, -50)
        btn.addTarget(self, action: #selector(internshipTypeBtnCilcked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
         
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ZJHomeApplyinfoCell", bundle: nil), forCellReuseIdentifier: "ZJHomeApplyinfoCell")
        tableView.register(UINib(nibName: "ZJHomeApplyFormCell", bundle: nil), forCellReuseIdentifier: "ZJHomeApplyFormCell")

        return tableView
    }()
    
    fileprivate var selectBaseModel:ZJBaseListModel?  //选择的基地
    fileprivate var selectBasePostModel:ZJBasePostModel?   //选择的岗位
    fileprivate var selectBaseTeacherModel:ZJTeacherModel?   //选择老师

    fileprivate var selectStartTime:String?
    fileprivate var selectEndTime:String?
    fileprivate var selectBaseCityModel:ZJCityModel?
    fileprivate var baseTeacherName = ""   //企业导师的姓名
    fileprivate var baseTeacherTel = ""   //企业导师的电话
    
    fileprivate var selectEnModel:ZJInternshipJobModel?  //选择的企业

    
    fileprivate var selectType:Int = 0  //0是未选择 1是基地实习 2是自主实习

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.requestPlan()
    }
    
    //请求实习计划的信息
    fileprivate func requestPlan()
    {
        BaseViewModel().post(url: kApplyPlanURL, param: ["StudentId":UserInfo.shard.userId ?? ""], MBProgressHUD: false, success: { (resp) in
            let dict = resp?["entity"].dictionaryObject
            self.planModel = ZJInternshipPlanModel.mj_object(withKeyValues: dict)
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }, noData: nil, failure: nil)
    }
    
    //实习类型按钮被点击
    @objc fileprivate func internshipTypeBtnCilcked(btn:UIButton)
    {
        btn.isSelected = !btn.isSelected
        self.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 1, length: 2)) as IndexSet, with: .automatic)
    }
    
    //提交
    @objc fileprivate func save()
    {
        if self.selectType == 0
        {
            MBProgressHUD.show(error: "请选择实习方式")
            return
        }
        if self.selectType == 1
        {
            if self.selectBaseModel == nil
            {
                MBProgressHUD.show(error: "请选择实习企业")
                return
            }
        }
        if self.selectBasePostModel == nil && self.selectType == 1
        {
            MBProgressHUD.show(error: "请选择实习岗位")
            return
        }
        
        if self.selectStartTime == nil
        {
            MBProgressHUD.show(error: "请选择开始时间")
            return
        }
        if self.selectEndTime == nil
        {
            MBProgressHUD.show(error: "请选择结束时间")
            return
        }
        if self.selectBaseCityModel == nil
        {
            MBProgressHUD.show(error: "请选择实习城市")
            return
        }
        
        if self.selectBaseTeacherModel == nil
        {
            MBProgressHUD.show(error: "请选择学校导师")
            return
        }
        
        if self.baseTeacherName.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写企业导师姓名")
            return
        }
        if self.baseTeacherTel.trimAfterCount() == 0
        {
            MBProgressHUD.show(error: "请填写企业导师电话")
            return
        }
        
        var param = [String:Any]()
        param["userId"] = UserInfo.shard.userId
        param["planId"] = self.planModel?.planId
        param["companyTeacher"] = self.baseTeacherName
        param["companyTeacherTel"] = self.baseTeacherTel
        param["status"] = 1
        param["practiceType"] = self.selectType
        param["schoolTeacherId"] = self.selectBaseTeacherModel?.teacherId
        param["basePlanProvinceId"] = self.selectBaseCityModel?.cityLevel == "1" ? self.selectBaseCityModel?.CODE : nil
        param["basePlanCityId"] = self.selectBaseCityModel?.cityLevel == "2" ? self.selectBaseCityModel?.CODE : nil
        param["basePlanContyId"] = self.selectBaseCityModel?.cityLevel == "3" ? self.selectBaseCityModel?.CODE : nil
        param["basePlanStartTime"] = self.selectStartTime
        param["basePlanEndTime"] = self.selectEndTime
        
        if self.selectType == 1
        {
            param["baseId"] = self.selectBaseModel?.baseId
            param["postId"] = self.selectBasePostModel?.postId
            param["companyName"] = self.selectBaseModel?.baseName
            param["companyId"] = self.selectBaseModel?.baseId
            param["practicePost"] = self.selectBasePostModel?.postName
            param["basePlanAddres"] = self.selectBaseModel?.address
            param["companyContact"] = self.selectBaseModel?.contact
            param["companyPhone"] = self.selectBaseModel?.contactPhone

        }
        else
        {
            param["baseId"] = self.selectEnModel?.companyId
            param["postId"] = self.selectEnModel?.postId
            param["basePlanAddres"] = self.selectEnModel?.companyInfo?.companyAddress
            param["companyName"] = self.selectEnModel?.companyInfo?.companyName
            param["companyId"] = self.selectEnModel?.companyId
            param["companyContact"] = self.selectEnModel?.companyInfo?.companyContacts
            param["companyPhone"] = self.selectEnModel?.companyInfo?.companyTel
            param["practicePost"] = self.selectEnModel?.postName
            
            if self.selectEnModel?.postId == nil //没有postId就是自己添加的企业
            {
                param["practiceType"] = 3
            }
        }
        
        BaseViewModel().post(url: kAddISApllyURL, param: param, MBProgressHUD: true, success: { (resp) in
            MBProgressHUD.show(info: "提交成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }, noData: nil, failure: nil)
    }
    
    //监听TextField的输入变化
    @objc fileprivate func textDidChanged(textField:UITextField)
    {
        if textField.tag == 50
        {
            self.baseTeacherName = textField.text ?? ""
        }
        if textField.tag == 51
        {
            self.baseTeacherTel = textField.text ?? ""
        }
        if textField.tag == 34
        {
            if self.selectBaseModel != nil
            {
                self.selectBaseModel?.address = textField.text
            }
            if self.selectEnModel != nil
            {
                self.selectEnModel?.companyInfo?.companyAddress = textField.text
            }

        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}

extension ZJHomeApplyInternShipController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            if self.selectBtn.isSelected
            {
                return 2
            }
            return 0
        case 2:
            return 3
        case 3:
            return 5
        case 4,5:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        guard section == 5 else {
            return 0.01
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 5 else{
            return nil
        }
        
        let footerView = UIView()
        
        let maskView = UIView()
        maskView.backgroundColor = UIColor.white
        footerView.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle("提 交", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = kTabbarBlueColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        maskView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        let maskView = UIView()
        maskView.backgroundColor = UIColor.white
        footerView.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        let imgView = UIImageView()
        imgView.image = UIImage(named:"temp5")
        maskView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        let label = UILabel()
        label.textColor = UIColor.color(hex: "#333333")
        label.font = UIFont.systemFont(ofSize: 16)
        maskView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
        
        switch section {
        case 0:
            label.text = "实习计划"
        case 1:
            label.text = "实习方式"
            
            
            maskView.addSubview(self.selectBtn)
            self.selectBtn.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-15)
                make.centerY.equalToSuperview()
            })
        case 2:
            if self.selectType == 1
            {
                label.text = "基地信息"

            }
            else
            {
                label.text = "企业信息"
            }
        case 3:
            label.text = "实习信息"
        case 4:
            label.text = "学校导师"
        case 5:
            label.text = "企业导师"

        default:
            break
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kCellLineColor
        maskView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(15)
        }
        
        return footerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 77
        }
        return 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ZJHomeApplyFormCell") as! ZJHomeApplyFormCell
        cell1.field.placeholder = "请填写"
        cell1.field.text = ""
        cell1.field.isEnabled = true
        cell1.infoLabel.text = "请选择"
        cell1.infoLabel.textColor = UIColor.lightGray
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeApplyinfoCell") as! ZJHomeApplyinfoCell
            cell.titleLabel.text = self.planModel?.practiceName
            cell.timeLabel.text = (self.planModel?.planStartTime ?? "") + " ~ " + (self.planModel?.planEndTime ?? "")
            return cell
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil
            {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            cell?.textLabel?.textColor = UIColor.color(hex: "#333333")
            cell?.selectionStyle = .none
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            if indexPath.row == 0
            {
                cell?.textLabel?.text = "基地实习"
            }
            else
            {
                cell?.textLabel?.text = "自主实习"
            }
            return cell!
        case 2:
            if indexPath.row == 0
            {
                if self.selectType == 1
                {
                    cell1.titleLabel.text = "实习基地"
                    if self.selectBaseModel != nil
                    {
                        cell1.infoLabel.text = self.selectBaseModel?.baseName
                        cell1.infoLabel.textColor = UIColor.black
                    }

                }
                else
                {
                    cell1.titleLabel.text = "实习企业"
                    if self.selectEnModel != nil
                    {
                        cell1.infoLabel.text = self.selectEnModel?.companyInfo?.companyName
                        cell1.infoLabel.textColor = UIColor.black

                    }

                }
                cell1.type = .info
            }
            else if indexPath.row == 1
            {
                if self.selectType == 1
                {
                    cell1.titleLabel.text = "基地联系人"
                    if self.selectBaseModel != nil
                    {
                        cell1.field.text = self.selectBaseModel?.contact
                        cell1.field.isEnabled = false
                    }
                }
                else
                {
                    cell1.titleLabel.text = "企业联系人"
                    if self.selectEnModel != nil
                    {
                        cell1.field.text = self.selectEnModel?.companyInfo?.companyContacts
                        cell1.field.isEnabled = false
                        
                    }

                    
                }
                cell1.type = .input
            }
            else
            {
                if self.selectType == 1
                {
                    cell1.titleLabel.text = "基地电话"
                    if self.selectBaseModel != nil
                    {
                        cell1.field.text = self.selectBaseModel?.contactPhone
                        cell1.field.isEnabled = false
                    }
                    
                }
                else
                {
                    cell1.titleLabel.text = "企业电话"
                    if self.selectEnModel != nil
                    {
                        cell1.field.text = self.selectEnModel?.companyInfo?.companyTel
                        cell1.field.isEnabled = false
                        
                    }

                }
                cell1.type = .input
            }
            return cell1
        case 3:
            switch indexPath.row
            {
            case 0:
                cell1.titleLabel.text = "实习岗位"
                cell1.type = .info
                if self.selectBasePostModel != nil
                {
                    cell1.infoLabel.text = self.selectBasePostModel?.postName
                    cell1.infoLabel.textColor = UIColor.black
                }
                if self.selectEnModel != nil
                {
                    cell1.infoLabel.text = self.selectEnModel?.postName
                    cell1.infoLabel.textColor = UIColor.black
                    
                }
            case 1:
                cell1.titleLabel.text = "开始时间"
                if self.selectStartTime != nil
                {
                    cell1.infoLabel.text = self.selectStartTime
                    cell1.infoLabel.textColor = UIColor.black

                }
                cell1.type = .info
            case 2:
                cell1.titleLabel.text = "结束时间"
                if self.selectEndTime != nil
                {
                    cell1.infoLabel.text = self.selectEndTime
                    cell1.infoLabel.textColor = UIColor.black

                }

                cell1.type = .info
            case 3:
                cell1.titleLabel.text = "实习城市"
                cell1.type = .info
                if self.selectBaseCityModel != nil
                {
                    cell1.infoLabel.text = self.selectBaseCityModel?.cityName
                    cell1.infoLabel.textColor = UIColor.black

                }
            case 4:
                cell1.titleLabel.text = "详细地址"
                cell1.type = .input
                cell1.field.text = ""
                cell1.field.placeholder = "请填写区、街道、门牌号"
                cell1.field.tag = 34
                cell1.field.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
                if self.selectBaseModel != nil
                {
                    cell1.field.text = self.selectBaseModel?.address
                }
                if self.selectEnModel != nil
                {
                    cell1.field.text = self.selectEnModel?.companyInfo?.companyAddress
                }
            default:
                break
            }
            return cell1
        case 4:
            if indexPath.row == 0
            {
                cell1.titleLabel.text = "导师姓名"
                cell1.type = .info
                
                if self.selectBaseTeacherModel != nil
                {
                    cell1.infoLabel.text = self.selectBaseTeacherModel?.teacherName
                    cell1.infoLabel.textColor = UIColor.black

                }
                
            }
            else
            {
                cell1.titleLabel.text = "联系方式"
                cell1.type = .input
                cell1.field.isEnabled = false
                if self.selectBaseTeacherModel != nil
                {
                    cell1.field.text = self.selectBaseTeacherModel?.teacherTel
                }

            }
            return cell1
        case 5:
            if indexPath.row == 0
            {
                cell1.titleLabel.text = "导师姓名"
                cell1.type = .input
                cell1.field.tag = 50
                cell1.field.text = self.baseTeacherName
                cell1.field.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
            }
            else
            {
                cell1.titleLabel.text = "联系方式"
                cell1.type = .input
                cell1.field.tag = 51
                cell1.field.text = self.baseTeacherTel
                cell1.field.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
            }
            return cell1

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJHomeApplyinfoCell") as! ZJHomeApplyinfoCell
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 3 && indexPath.row == 3
        {
            let toVC = ZJCitySelectController()
//            toVC.delegate = self
            toVC.title = "城市搜索"
            toVC.selectCityAction = {[weak self] model in
                self?.selectBaseCityModel = model
                self?.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 3, length: 1)) as IndexSet, with: .automatic)
            }
            let nav = ZJNavigationController(rootViewController: toVC)
            self.present(nav, animated: true, completion: nil)
        }
        
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                self.selectType = 1
                self.selectBaseModel = nil
            }
            else
            {
                self.selectType = 2
                self.selectEnModel = nil
            }
            
            let cell = tableView.cellForRow(at: indexPath)
            self.selectBtn.setTitle(cell?.textLabel?.text, for: .normal)
            self.selectBtn.isSelected = false
            self.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 1, length: 2)) as IndexSet, with: .automatic)
        }
        
        if indexPath.section == 2
        {
            let toVC = ZJHomeInternshipListController()
            toVC.selectBaseAction = {[weak self] model in
                self?.selectBaseModel = model
                self?.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 2, length: 1)) as IndexSet, with: .automatic)
            }
            toVC.selectEnAction = {
                [weak self] model in
                self?.selectEnModel = model
                self?.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 2, length: 2)) as IndexSet, with: .automatic)
                
            }
            if self.selectType == 1
            {
                toVC.navTitle = "基地实习"
                toVC.type = .base
            }
            else if self.selectType == 2
            {
                toVC.navTitle = "企业实习"
                toVC.type = .enterprise
            }
            else
            {
                MBProgressHUD.show(error: "请选择实习方式")
                return
            }
            self.navigationController?.pushViewController(toVC, animated: true)
        }
        
        if indexPath.section == 3
        {
            if indexPath.row == 0
            {
                if self.selectType == 0
                {
                    MBProgressHUD.show(error: "请选择实习方式")
                    return
                }
                
                if self.selectType == 1 && self.selectBaseModel == nil
                {
                    MBProgressHUD.show(error: "请选择基地")
                    return
                }
                
                //自主实习不能点击
                if self.selectType == 2
                {
                    return
                }
                
                let toVC = ZJApplyPostListController()
                toVC.navTitle = "岗位列表"
                toVC.dataArray = self.selectBaseModel?.basePostList
                toVC.selectPostAction = {[weak self] model in
                    self?.selectBasePostModel = model
                    self?.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 3, length: 1)) as IndexSet, with: .automatic)
                }
                self.navigationController?.pushViewController(toVC, animated: true)
            }
            if indexPath.row == 1 || indexPath.row == 2
            {
                let datePicker = HooDatePicker(superView:self.view)
                datePicker?.title = indexPath.row == 1 ? "开始时间" : "结束时间"
                datePicker?.minimumDate = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                datePicker?.maximumDate = dateFormatter.date(from: "2050-12-31")
                datePicker?.datePickerMode = HooDatePickerMode.date
                datePicker?.selectedDateBlock = {[weak self]date in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
//                    self?.timeField.text = dateFormatter.string(from: date!)
                    if indexPath.row == 1
                    {
                        self?.selectStartTime = dateFormatter.string(from: date!)
                    }
                    else
                    {
                        self?.selectEndTime = dateFormatter.string(from: date!)

                    }
                    
                    self?.tableView.reloadRows(at: [IndexPath(row: 1, section: 3),IndexPath(row: 2, section: 3)], with: .automatic)
//                    self?.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 3, length: 1)) as IndexSet, with: .automatic)

                }
                datePicker?.show()

            }
        }
        
        if indexPath.section == 4 && indexPath.row == 0
        {
            BaseViewModel().post(url: kGetTeacherURL, param: ["PlanId":self.planModel?.planId ?? ""], MBProgressHUD: false, success: { (resp) in
                let array = resp?["list"].arrayObject
                let dataArray = ZJTeacherModel.mj_objectArray(withKeyValuesArray: array) as! [ZJTeacherModel]
                
                ZJTeacherAlertView.show(title: "选择教师", teachers: dataArray, selectTeacherAction: {[weak self] (model) in
                    self?.selectBaseTeacherModel = model
                    self?.tableView.reloadSections(NSIndexSet(indexesIn: NSRange(location: 4, length: 1)) as IndexSet, with: .automatic)

                })

            }, noData: nil, failure: nil)
        }
    }
}
