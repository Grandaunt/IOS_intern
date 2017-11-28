//
//  ZJUserWorkExpListController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/14.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJWorkExperienceListController: SecondViewController
{
    var experienceType = ExpericenType.work
    
    fileprivate lazy var tableView:UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .grouped)
        tableView.backgroundColor = kBackgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self?.tableViewProtocol
        tableView.dataSource = self?.tableViewProtocol
         
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 95
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "ZJWorkExperienceListCell", bundle: nil), forCellReuseIdentifier: "ZJWorkExperienceListCell")
        tableView.register(UINib(nibName: "ZJProjectExperienceCell", bundle: nil), forCellReuseIdentifier: "ZJProjectExperienceCell")
        return tableView
    }()
    
    fileprivate lazy var tableViewProtocol:ZJWorkExperienceListProtocol = {[weak self] in
        let tableViewProtocol = ZJWorkExperienceListProtocol()
        tableViewProtocol.controller = self
        tableViewProtocol.experienceType = (self?.experienceType)!
        return tableViewProtocol
    }()
    
    fileprivate var viewModel = ZJWorkExperienceListViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        switch self.experienceType {
        case .practice:
            self.viewModel.getPracticeList(finish: {[weak self] (models) in
                self?.reloadData(models: models)
                }, noData: {[weak self] in
                    self?.reloadData(models: [Any]())
            })
        case .work:
            self.viewModel.getWorkList(finish: {[weak self] (models) in
                self?.reloadData(models: models)
                }, noData: {[weak self] in
                    self?.reloadData(models: [Any]())
            })
        case .edu:
            self.viewModel.getEduList(finish: {[weak self] (models) in
                self?.reloadData(models: models)
                }, noData: {[weak self] in
                    self?.reloadData(models: [Any]())
            })
        case .project:
            self.viewModel.getProjectList(finish: {[weak self] (models) in
                self?.reloadData(models: models)
                }, noData: {[weak self] in
                    self?.reloadData(models: [Any]())
            })

        default:
            break
            
        }
    }
    
    fileprivate func reloadData(models:[Any])
    {
        self.tableViewProtocol.dataArray = models
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
