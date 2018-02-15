//
//  TaskListViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 07/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class TaskListViewController: UIViewController, TaskViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var viewModel:CoordinatorViewModeling? {
    didSet {
      bindData()
    }
  }
  
  var taskList: [Task] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "TaskTableViewCell")
      
    }
  
  func bindData() {
    let deallocSignalProducer = self.reactive.lifetime.ended.createProducer()
    viewModel?.selectedTaskList.producer.take(until: deallocSignalProducer)
      .startWithValues({ [weak self] list in
        guard let weakSelf = self else { return }
        weakSelf.taskList = list
        weakSelf.tableView.reloadData()
      })
  }
}

extension TaskListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.taskList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
    
      return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85
  }
  
}

extension TaskListViewController: UITableViewDelegate {
  
}


