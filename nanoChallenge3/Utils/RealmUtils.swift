//
//  RealmUtils.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 06/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUtils {
  
  static var defaultRealmConfig: Realm.Configuration {
    // Get realm configuration.
    var config = Realm.Configuration()
    
    // Use the default directory and default realm file.
    config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent(REALMDEFAULTCONFIGFILE)
    
    return config
  }
  
  static func realmConfigWithIntName(_ intName: Int) -> Realm.Configuration {
    // Get realm configuration.
    var config = Realm.Configuration()
    
    // Use the default directory, but replace the filename with the id
    
    config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(intName).realm")
    
    return config
  }
  
}

