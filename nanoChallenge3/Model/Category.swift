//
//  Category.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 05/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import RealmSwift

open class Category: Object {
  
var name: String = ""
var taskList: [Task] = []
  
}
