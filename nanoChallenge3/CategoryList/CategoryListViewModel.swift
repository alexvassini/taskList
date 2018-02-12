//
//  CategoryListViewModel.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 12/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol CategoryListViewModeling {
  
  var categories: Property<[Category]> { get }

}

class CategoryListViewModel: CategoryListViewModeling  {
  
  let dataModel = DataModel.shared
  
  var categories:Property<[Category]>{
    return Property(dataModel.categoriesList)
  }
  
  
  
 
}
