//
//  CategoryListViewModel.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 12/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol CoordinatorViewModeling {
  
  var categories: Property<[Category]> { get }
  var selectedTaskList : Property<[Task]> { get }
  var title: Property<String> {get}
  func setCategory(_ index: Int)
  func editTask(_ task: Task)
  func setTitle(title: String)
}

class CoordinatorViewModel: CoordinatorViewModeling  {
  
  
  
  var title: Property<String>{
    return Property(_title)
  }
  
  fileprivate let dataModel = DataModel.shared
  
  var categories:Property<[Category]>{
    return Property(dataModel.categoriesList)
  }
  
  fileprivate var _title = MutableProperty<String>("Tarefas")
  
  var selectedTaskList: Property<[Task]> {
    return Property(_taskList)
  }
  
 fileprivate var _taskList = MutableProperty<[Task]>([])
 
  func setCategory(_ index: Int) {
    _taskList.value = dataModel.categoriesList.value[index].taskList
    
  }
  
  func editTask(_ task: Task)
  {
    dataModel.editTask(task)
  }
  
  func setTitle(title: String) {
    self._title.value = title
  }
}



