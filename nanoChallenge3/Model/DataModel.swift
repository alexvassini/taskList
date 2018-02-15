//
//  DataModel.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 05/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift

open class DataModel {
  
  static let shared = DataModel()
  var categoriesList = MutableProperty<[Category]>([])
  private var taskList: [Task] = []
  
  public required init() {
    getTaskListFromRealm()
    for task in taskList {
      addTaskToCategoryList(task)
    }
  }
  
}

extension DataModel {
  
  func addNewTask(_ task: Task){
    if taskList.isEmpty{
      task.id = 1
    }
    else {
      let id = taskList.last?.id
      task.id = id! + 1
    }
    saveTask(task)
    addTaskToCategoryList(task)
  }
  
  fileprivate func addTaskToCategoryList(_ task: Task) {

    for taskTag in task.tags {
      
      var categoryExists = false
      
      for category in categoriesList.value {
        
        if category.name == taskTag{
          
          category.taskList.append(task)
          categoryExists = true
        }
      }
      
      if !categoryExists {
        createNewCategory(name: taskTag, task)
      }
    }
  }
  
  func createNewCategory(name: String, _ task: Task){
    let category = Category()
    category.name = name
    category.taskList.append(task)
    self.categoriesList.value.append(category)
  }
}

//Realm functions
extension DataModel {

  // MARK: Realm
 fileprivate func getTaskListFromRealm() {
    do {
      let realm = try Realm()
      let result = Array(realm.objects(Task.self))
      taskList = result.isEmpty ? [] : result
    } catch let err as NSError {
      print("Error get realm default path: \(err)")
    }
  }
  
  fileprivate func deleteTask(_ taskId: Int) {
    do {
      let realm = try Realm()
      try realm.write({ () -> Void in
        if let task = realm.object(ofType: Task.self, forPrimaryKey: taskId) {
          if let index = taskList.index(of: task) {
            taskList.remove(at: index)
          }
          realm.delete(task)
        }
      })
    } catch let err as NSError{
      print(err)
    }
  }
  
  fileprivate func saveTask(_ task: Task) {
    do {
      let realm = try Realm()
      try realm.write({ () -> Void in
        taskList.append(task)
        realm.add(task, update: true)
      })
    } catch let err as NSError{
      print(err)
    }
  }
  
}
