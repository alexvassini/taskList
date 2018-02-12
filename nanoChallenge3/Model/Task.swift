//
//  Task.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 05/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import RealmSwift

open class Task: Object {
  
  var name: String = ""
  var isDone: Bool = false
  var tags: [String] = []
  var details: String = ""
  
}

