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
  func setCategory(_ index: Int)
}

class CoordinatorViewModel: CoordinatorViewModeling  {
  
  fileprivate let dataModel = DataModel.shared
  
  var categories:Property<[Category]>{
    return Property(dataModel.categoriesList)
  }
  
  var selectedTaskList: Property<[Task]> {
    return Property(_taskList)
  }
  
 fileprivate var _taskList = MutableProperty<[Task]>([])
 
  func setCategory(_ index: Int) {
    _taskList.value = dataModel.categoriesList.value[index].taskList
    
  }
}



