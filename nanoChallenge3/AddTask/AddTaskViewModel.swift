//
//  AddTaskViewModel.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 12/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol AddTaskViewModeling {
  
  var categories: Property<[Category]> { get }
  func addTag(_ tag: String)
  func saveNewTask(_ task: Task)
}

class AddTaskViewModel: AddTaskViewModeling  {
  
  let dataModel = DataModel.shared
  var newTask = Task()
  var categories:Property<[Category]>{
    return Property(dataModel.categoriesList)
  }

  func saveNewTask(_ task: Task){
    //Save Data
    newTask.name = task.name
    newTask.details = task.details
    if newTask.tags.isEmpty {
      newTask.tags.append("Uncategorized")
    }
    dataModel.addNewTask(newTask)
  }
  
  func addTag(_ tag: String){
    var _tag = tag.trimmingCharacters(in: .whitespacesAndNewlines)
    _tag = _tag.trimmingCharacters(in: .punctuationCharacters)
    if !newTask.tags.contains(_tag){
      newTask.tags.append(_tag)
    }
  }
  //string.trimmingCharacters(in: .whitespaces)
}
