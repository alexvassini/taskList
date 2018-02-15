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
  
  @objc dynamic var name: String = ""
  @objc dynamic var isDone: Bool = false
  var tags = List<String>()
  @objc dynamic var details: String = ""
  @objc dynamic var id: Int = 0
  
  override open static func primaryKey() -> String? {
    return "id"
  }
}

