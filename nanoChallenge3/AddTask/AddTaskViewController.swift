//
//  AddTaskViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 08/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import TransitionButton
import ReactiveSwift
import ReactiveCocoa

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var taskNameTextField: UITextField!
  @IBOutlet weak var descriptionNameTextField: UITextField!
  @IBOutlet weak var addTagTextField: UITextField!
  
  var newTask = Task()
  var viewModel: AddTaskViewModeling = AddTaskViewModel()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  @IBAction func close(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func save(_ sender: Any) {
    //Save Data
    newTask.name = taskNameTextField.text ?? ""
    newTask.details = descriptionNameTextField.text ?? ""
    viewModel.saveNewTask(newTask)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addTag(_ sender: Any) {
    guard let tag = addTagTextField.text, tag != "" else {return}
    viewModel.addTag(tag)
    addTagTextField.text = ""
  }
  
}
