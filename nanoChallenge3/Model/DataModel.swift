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

open class DataModel: Object {
  
  static let shared = DataModel()

  var categoriesList = MutableProperty<[Category]>([])
  private var taskList: [Task] = []
  //
}


extension DataModel {
  
  func addNewTask(_ task: Task){
    taskList.append(task)
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

extension DataModel {
//  func initalize() {
//    self.categories = getCategoriesListFromRealm()
//  }
  
  // MARK: Realm
  func getCategoriesListFromRealm() -> [Category] {
    var categories = [Category]()
    do {
      let realm = try Realm()
      let result = realm.objects(Category.self)
      // if result is empty then returns an empty array
      for category in result {
        categories.append(category)
      }
    } catch let err as NSError {
      print("Error get realm default path: \(err)")
    }
    return categories
  }
  
  fileprivate func deleteAllRestaurant() {
    do {
      let realm = try Realm()
      try realm.write({ () -> Void in
        realm.delete(realm.objects(DataModel.self))
        realm.delete(realm.objects(Category.self))
        realm.delete(realm.objects(Task.self))
      })
    } catch let err as NSError {
      print("Error get realm default path: \(err)")
    }
  }
  
  fileprivate func saveListRestaurant(_ list: [Category]) {
    self.deleteAllRestaurant()
    do {
      let realm = try Realm()
      try realm.write({ () -> Void in
        realm.add(list)
      })
    } catch let err as NSError {
      print("Error get realm default path: \(err)")
    }
  }
  
  
}
