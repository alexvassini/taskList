//
//  TaskListViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 07/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, TaskViewController {

  var viewModel:CoordinatorViewModeling? {
    didSet {
      bindData()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  func bindData() {
    
  }
}
