//
//  ZJTeacherAlertView.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/24.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

fileprivate let tableCellHeight:CGFloat = 44

class ZJTeacherAlertView: UIView
{
    fileprivate var selectTeacherAction:((ZJTeacherModel)->Void)?
    fileprivate var teachers = [ZJTeacherModel]()
    
    fileprivate lazy var alertView:UIView = {[weak self] in
        let alertView = UIView()
        alertView.center = (self?.center)!
        alertView.backgroundColor = UIColor.white
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 4
        return alertView
    }()
    
    fileprivate lazy var toolView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: kTableViewFrame, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    convenience init(title:String?,teachers:[ZJTeacherModel],selectTeacherAction:((ZJTeacherModel)->Void)?)
    {
        let window = UIApplication.shared.keyWindow
        self.init(frame: (window?.bounds)!)
        self.teachers = teachers
        self.selectTeacherAction = selectTeacherAction
        if title != nil
        {
            self.titleLabel.text = title!
        }
        
        self.alertView.layoutIfNeeded()
        
        let tableHeight = CGFloat(teachers.count) * tableCellHeight
        
        var height = self.toolView.frame.height + tableHeight
        if self.alertView.frame.minY + height > kScreenViewHeight
        {
            height = kScreenViewHeight - 64*2
        }
        
        self.alertView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview()
            make.height.equalTo(height)
        }
        
        self.alertView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.toolView.snp.bottom)
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.addSubview(self.alertView)
        self.alertView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview().offset(-kHomeEdgeSpace*3)
            make.height.equalTo(self.alertView.snp.width)
        }
        
        self.alertView.addSubview(self.toolView)
        self.toolView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.toolView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let point = touches.first?.location(in: self)
        
        if self.alertView.frame.contains(point!) == false
        {
            cancelBtnAction()
        }
    }
    
    @objc private func cancelBtnAction()
    {
        hide()
    }
    
    private func hide()
    {
        //        let window = UIApplication.shared.keyWindow
        //        for view in (window?.subviews)!
        //        {
        //            if view is TMAlertView
        //            {
        //                UIView.animate(withDuration: 0.3, animations: {
        //                    view.alpha = 0
        //                }, completion: { (finished) in
        //                    view.removeFromSuperview()
        //                })
        //            }
        //        }
        
        let controller = Utils.getCurrentVC()
        for view in (controller?.navigationController?.view.subviews)!.reversed()
        {
            if view is ZJTeacherAlertView
            {
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }, completion: { (finished) in
                    view.removeFromSuperview()
                })
                break
            }
        }
    }
    
    class func hidden()
    {
        //        let window = UIApplication.shared.keyWindow
        //        for view in (window?.subviews)!
        //        {
        //            if view is TMAlertView
        //            {
        //                UIView.animate(withDuration: 0.3, animations: {
        //                    view.alpha = 0
        //                }, completion: { (finished) in
        //                    view.removeFromSuperview()
        //                })
        //            }
        //        }
        
        let controller = Utils.getCurrentVC()
        for view in (controller?.navigationController?.view.subviews)!.reversed()
        {
            if view is ZJTeacherAlertView
            {
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }, completion: { (finished) in
                    view.removeFromSuperview()
                })
                break
            }
        }
    }
    
    class func show(title:String?,teachers:[ZJTeacherModel],selectTeacherAction:((ZJTeacherModel)->Void)?)
    {
        //如果添加到window上，能保证在最上层，但是如果present时该视图没消失，那么该视图还是在最上层
        //        let window = UIApplication.shared.keyWindow
        //        let alertView = TMAlertView(title: title, contentView: contentView)
        //        alertView.alpha = 0
        //        window?.addSubview(alertView)
        //        alertView.snp.makeConstraints { (make) in
        //            make.edges.equalToSuperview()
        //        }
        //        UIView.animate(withDuration: 0.3) {
        //            alertView.alpha = 1
        //        }
        
        let controller = Utils.getCurrentVC()
        
        let alertView = ZJTeacherAlertView(title: title, teachers: teachers, selectTeacherAction: selectTeacherAction)
        alertView.alpha = 0
        controller?.navigationController?.view?.addSubview(alertView)
        alertView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        UIView.animate(withDuration: 0.3) {
            alertView.alpha = 1
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZJTeacherAlertView:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.teachers.count
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableCellHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        let model = self.teachers[indexPath.row]
        cell?.textLabel?.text = model.teacherName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.selectTeacherAction != nil
        {
            self.hide()
            let model = self.teachers[indexPath.row]
            self.selectTeacherAction!(model)
        }
    }
}
