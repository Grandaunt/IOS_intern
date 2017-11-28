//
//  ZJProvinceSelectController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/26.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJProvinceSelectController: SecondViewController
{
    
    var selectCityAction:((ZJCityModel)->Void)?
    var cityModelArray:[ZJCityModel]?  //总共的city
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: kTableViewFrame, style: .plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = kTabbarBlueColor
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cityNameCell")
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "hotCityCell")
        
        return tableView
    }()
    
    fileprivate var dataDict = [String:Any]()  //服务器获得的城市列表
    fileprivate var hotArray = [ZJCityModel]()  //热门城市
    fileprivate var keysArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.dealData(array: self.cityModelArray)
    }
    
    fileprivate func dealData(array:[ZJCityModel]?)
    {
        var dict = [String:Any]()
        var hotArr = [ZJCityModel]()
        
        for model in array!
        {
            //只选择省
            if model.cityLevel == "1"
            {
                if !dict.keys.contains(model.firstChar!)
                {
                    dict[model.firstChar!] = [model]
                }
                else
                {
                    var array = dict[model.firstChar!] as! [ZJCityModel]
                    array.append(model)
                    dict[model.firstChar!] = array
                }
                
                if ((model.cityName?.contains("北京"))! || (model.cityName?.contains("上海"))! || (model.cityName?.contains("河北"))! || (model.cityName?.contains("广东"))! || (model.cityName?.contains("天津"))! || (model.cityName?.contains("吉林"))! || (model.cityName?.contains("山西"))! || (model.cityName?.contains("黑龙江"))! || (model.cityName?.contains("四川"))!) && model.cityLevel == "1"
                {
                    hotArr.append(model)
                }
                
            }
        }
        self.hotArray = hotArr
        self.dataDict = dict
        
        let keys = dict.keys.sorted { (s1, s2) -> Bool in
            return s1 < s2
        }
        self.keysArray = keys
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
        
    @objc fileprivate func hotBtnClicekd(btn:UIButton)
    {
        if self.selectCityAction != nil
        {
            let index = btn.tag
            let model = self.hotArray[index]
            self.selectCityAction!(model)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJProvinceSelectController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.keysArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        else
        {
            let key = self.keysArray[section - 1]
            let array = self.dataDict[key] as! [ZJCityModel]
            return array.count
            
        }
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            return "热门城市"
        }
        else
        {
            return self.keysArray[section - 1]
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]?
    {
        return ["热"] + self.keysArray
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard indexPath.section == 0 else {
            return 44
        }
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hotCityCell")
            cell?.selectionStyle = .none
            
            let btnWidth:CGFloat = 80
            let space:CGFloat = (kScreenViewWidth - btnWidth*3)/4
            let btnHeight:CGFloat = 40
            for (index,model) in self.hotArray.enumerated()
            {
                let btn = UIButton()
                btn.backgroundColor = kBackgroundColor
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 2
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.setTitle(model.cityName, for: .normal)
                btn.tag = index
                btn.addTarget(self, action: #selector(hotBtnClicekd(btn:)), for: .touchUpInside)
                cell?.contentView.addSubview(btn)
                if index < 3
                {
                    let offset = space + CGFloat(index)*btnWidth
                    btn.snp.makeConstraints({ (make) in
                        make.top.equalToSuperview().offset(10)
                        make.left.equalToSuperview().offset(offset + CGFloat(index) * space)
                        make.width.equalTo(btnWidth)
                        make.height.equalTo(btnHeight)
                    })
                }
                else if index < 6
                {
                    let offset = space + CGFloat(index-3)*btnWidth
                    btn.snp.makeConstraints({ (make) in
                        make.top.equalToSuperview().offset(10 + btnHeight + 20)
                        make.left.equalToSuperview().offset(offset + CGFloat(index-3) * space)
                        make.width.equalTo(btnWidth)
                        make.height.equalTo(btnHeight)
                    })
                    
                }
                else
                {
                    let offset = space + CGFloat(index-6)*btnWidth
                    btn.snp.makeConstraints({ (make) in
                        make.top.equalToSuperview().offset(10 + btnHeight*2 + 20*2)
                        make.left.equalToSuperview().offset(offset + CGFloat(index-6) * space)
                        make.width.equalTo(btnWidth)
                        make.height.equalTo(btnHeight)
                    })
                }
            }
            return cell!
        }
        else
        {
            let key = self.keysArray[indexPath.section-1]
            let array = self.dataDict[key] as! [ZJCityModel]
            let model = array[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameCell")
            cell?.selectionStyle = .none
            cell?.textLabel?.text = model.cityName
            cell?.textLabel?.textColor = UIColor.gray
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section != 0
        {
            if self.selectCityAction != nil
            {
                let key = self.keysArray[indexPath.section-1]
                let array = self.dataDict[key] as! [ZJCityModel]
                let model = array[indexPath.row]
                self.selectCityAction!(model)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
}
