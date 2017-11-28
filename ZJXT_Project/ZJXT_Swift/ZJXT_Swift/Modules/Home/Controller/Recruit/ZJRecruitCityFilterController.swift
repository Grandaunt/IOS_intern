//
//  ZJRecruitCityFilterController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/29.
//  Copyright © 2017年 runer. All rights reserved.
//
//  城市筛选

import UIKit

class ZJRecruitCityFilterController: UIViewController
{
    var provinceName:String?
    
    var selectCityAction:((ZJCityModel)->Void)?  //选中以后执行的
    
    //首次进入用的，设置时重新加载数据
    fileprivate var selectLeft:ZJCityModel?{
        didSet{
            self.leftArray.removeAll()
            self.leftArray.append(selectLeft!)
            for m in self.cityModelArray
            {
                if m.parentCode == selectLeft?.CODE && m.cityLevel == "2"
                {
                    self.leftArray.append(m)
                }
            }
            self.leftTableView.reloadData()
//            let indexPath = IndexPath(row: 0, section: 0)
//            self.leftTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//            self.tableView(self.leftTableView, didSelectRowAt: indexPath)
        }
    }
    fileprivate var leftArray = [ZJCityModel]()
    fileprivate var rightArray = [ZJCityModel]()
    
    //请求完以后 找出定位的城市
    fileprivate var cityModelArray = [ZJCityModel](){
        didSet{
            for model in cityModelArray
            {
                if (self.provinceName?.contains(model.cityName!))! && model.cityLevel! == "1"
                {
                    self.selectLeft = model
                }
            }
        }
    }  //总共的city
    fileprivate lazy var leftTableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate lazy var rightTableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.addSubview(self.leftTableView)
        self.leftTableView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(kScreenViewWidth/3)
            make.bottom.equalToSuperview().offset(-49)
        }
        
        self.view.addSubview(self.rightTableView)
        self.rightTableView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.width.equalTo(kScreenViewWidth/3*2)
            make.bottom.equalToSuperview().offset(-49)
        }
        
        let btn = UIButton()
        btn.setTitle(" 切换城市", for: .normal)
        btn.setTitleColor(UIColor.color(hex: "#66666"), for: .normal)
        btn.setImage(UIImage(named:"changeCity"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(changeCityClicked), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        self.cityModelArray = ZJCitysData.shard.citys!
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

    }
    
    @objc fileprivate func changeCityClicked()
    {
        let toVC = ZJProvinceSelectController()
        toVC.navTitle = "选择省份"
        toVC.cityModelArray = self.cityModelArray
        toVC.selectCityAction = {[weak self] model in
                        
            self?.leftArray.removeAll()
            self?.rightArray.removeAll()
            self?.leftArray.append(model)
            for m in (self?.cityModelArray)!
            {
                if m.parentCode == model.CODE
                {
                    self?.leftArray.append(m)
                }
            }
            self?.leftTableView.reloadData()
            self?.rightTableView.reloadData()
        }
        self.navigationController?.pushViewController(toVC, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}

extension ZJRecruitCityFilterController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.leftTableView
        {
            return self.leftArray.count
        }
        else
        {
            return self.rightArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell1")
        }
        cell?.textLabel?.textColor = UIColor.color(hex: "#666666")
        cell?.textLabel?.highlightedTextColor = kTabbarBlueColor
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.isSelected = false
        
        if tableView == self.leftTableView
        {
            let model = self.leftArray[indexPath.row]
            cell?.textLabel?.text = model.cityName
            cell?.backgroundColor = kBackgroundColor
            
            let backView = UIView()
            backView.backgroundColor = kBackgroundColor
            cell?.selectedBackgroundView = backView
        }
        else
        {
            let model = self.rightArray[indexPath.row]
            cell?.textLabel?.text = model.cityName
            cell?.backgroundColor = UIColor.white
            
            let backView = UIView()
            backView.backgroundColor = UIColor.white
            cell?.selectedBackgroundView = backView

        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == self.leftTableView
        {
            self.rightArray.removeAll()
            
            if indexPath.row != 0
            {
                let model = self.leftArray[indexPath.row]
                self.rightArray.append(model)
                for m in self.cityModelArray
                {
                    if m.parentCode == model.CODE && m.cityLevel == "3"
                    {
                        self.rightArray.append(m)
                    }
                }
            }
            else
            {
                let m = self.leftArray[indexPath.row]
                
                if self.selectCityAction != nil
                {
                    self.selectCityAction!(m)
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(YZUpdateMenuTitleNote), object: self, userInfo: ["title":m.cityName ?? ""])

            }
            
            self.rightTableView.reloadData()
        }
        else
        {
            let m = self.rightArray[indexPath.row]
            
            if self.selectCityAction != nil
            {
                self.selectCityAction!(m)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(YZUpdateMenuTitleNote), object: self, userInfo: ["title":m.cityName ?? ""])
        }
        
    }
}
