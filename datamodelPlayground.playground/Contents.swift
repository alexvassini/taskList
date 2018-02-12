//: Playground - noun: a place where people can play

import UIKit



open class Task {
  
  var name: String?
  var isDone: Bool = false
  var tags: [String] = []
  var details: String?
  var category: String?
  
}

open class Category {
  
  var name: String = ""
  var count: Int = 0
 var taskList: [Task] = []
 
}

open class DataModel {
  
  static let shared = DataModel()
  
  var categories: [Category] = []
  
  func addTask(_ task: Task) {
    
    for taskTag in task.tags {
      
      var categoryExists = false
      
      for category in categories {
        
        if category.name == taskTag{
          
          category.taskList.append(task)
          categoryExists = true
        }
      }
      
      if !categoryExists {
        setCategory(name: taskTag, task)
      }
    }
    
  }
  
  func setCategory(name: String, _ task: Task){
    let category = Category()
    category.name = name
    category.taskList.append(task)
    self.categories.append(category)
  }
}



var task1 = Task()
task1.name = "tarefa1"
task1.category = "TESTE1"
task1.tags = ["t1tag1", "t1tag2", "t1tag3"]

var task2 = Task()
task2.name = "tarefa2"
task2.category = "TESTE1"
task2.tags = ["t2tag1", "t2tag2", "t2tag3"]


var task3 = Task()
task3.name = "tarefa3"
task3.category = "TESTE2"
task3.tags = ["t1tag1", "t1tag2", "t1tag3"]

var task4 = Task()
task4.name = "tarefa4"
task4.category = "TESTE2"
task4.tags = ["t1tag1", "t2tag2", "t2tag3"]


DataModel.shared.addTask(task1)
DataModel.shared.addTask(task3)
DataModel.shared.addTask(task2)
DataModel.shared.addTask(task4)

var cat = DataModel.shared.categories.filter{(task1.tags.contains($0.name))}

print (DataModel.shared.categories[0].taskList.count)

cat.count

if cat.isEmpty {
  let category = Category()
  category.name = task1.category!
  category.taskList.append(task1)
  DataModel.shared.categories.append(category)
}


cat = DataModel.shared.categories.filter{(task3.tags.contains($0.name))}

cat.count





