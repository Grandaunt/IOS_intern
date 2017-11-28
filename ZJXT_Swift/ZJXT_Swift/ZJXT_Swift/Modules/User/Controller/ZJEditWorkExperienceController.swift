//
//  ZJEditWorkExperienceController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/14.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

enum ExpericenType:Int
{
    case work = 0 //工作经历
    case edu      //教育经历
    case project  //项目
    case train    //培训
    case practice  //实习
}


class ZJEditWorkExperienceController: SecondViewController
{

    var experienceType = ExpericenType.work
    var isEdit = false  //是否编辑 否就是添加
    var model:Any?      //传入的模型数据自己转换
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJEditWorkExperienceProtocol = {[weak self] in
        let tableViewProtocol = ZJEditWorkExperienceProtocol()
        tableViewProtocol.experienceType = (self?.experienceType)!
        tableViewProtocol.isEdit = (self?.isEdit)!
        tableViewProtocol.model = self?.model
        tableViewProtocol.delAction = {
            
            switch (self?.experienceType)!
            {
            case .practice:
                let m = self?.model as! ZJVCExperiencePracticeModel
                self?.viewModel.delPracticeExperience(model: m, finish: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .work:
                let m = self?.model as! ZJVCExperienceWorkModel
                self?.viewModel.delWorkExperience(model: m, finish: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .edu:
                let m = self?.model as! ZJVCExperienceEducationModel
                self?.viewModel.delEduExperience(model: m, finish: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .project:
                let m = self?.model as! ZJVCExperienceProjectModel
                self?.viewModel.delProjectExperience(model: m, finish: {
                    self?.navigationController?.popViewController(animated: true)
                })

            default:
                break
            }
        }
        return tableViewProtocol
    }()
    
    fileprivate lazy var viewModel = ZJEditWorkExperienceViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initNav()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func initNav()
    {
        //调整位置，以防往右偏移
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(kTabbarBlueColor, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.addTarget(self, action: #selector(addExperience), for: .touchUpInside)
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func addExperience()
    {
        self.view.endEditing(true)
        
        switch self.experienceType
        {
        case .practice:
            let model = ZJVCExperiencePracticeModel()
            model.companyName = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.practicePost = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.practiceStartTime = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.practiceEndTime = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.practiceDes = self.tableViewProtocol.phTextView.text
            if self.model != nil
            {
                let m = self.model as! ZJVCExperiencePracticeModel
                model.practiceId = m.practiceId
            }
            self.viewModel.addPracticeExperience(model: model, finish: {
                self.navigationController?.popViewController(animated: true)
            })
        case .work:
            let model = ZJVCExperienceWorkModel()
            model.companyName = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.workPost = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.workStartTime = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.workEndTime = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.workDes = self.tableViewProtocol.phTextView.text
            if self.model != nil
            {
                let m = self.model as! ZJVCExperienceWorkModel
                model.workId = m.workId
            }
            self.viewModel.addWorkExperience(model: model, finish: {
                self.navigationController?.popViewController(animated: true)
            })
        case .edu:
            let model = ZJVCExperienceEducationModel()
            model.schoolName = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.educationMajor = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.educationStartTime = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.educationEndTime = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.educationDes = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! ZJEditWorkExperienceCell).textField.text
            if self.model != nil
            {
                let m = self.model as! ZJVCExperienceEducationModel
                model.educationId = m.educationId
            }
            self.viewModel.addEduExperience(model: model, finish: {
                self.navigationController?.popViewController(animated: true)
            })
        case .project:
            let model = ZJVCExperienceProjectModel()
            model.projectName = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.projectPost = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ZJEditWorkExperienceCell).textField.text
            model.projectStartTime = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.projectEndTime = (self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! ZJEditWorkExperienceCell).textField.text
            model.projectDes = self.tableViewProtocol.phTextView.text
            if self.model != nil
            {
                let m = self.model as! ZJVCExperienceProjectModel
                model.projectId = m.projectId
            }
            self.viewModel.addProjectExperience(model: model, finish: {
                self.navigationController?.popViewController(animated: true)
            })

            

        default:
            break
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
