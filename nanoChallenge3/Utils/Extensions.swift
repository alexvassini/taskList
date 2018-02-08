//
//  extensions.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 08/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import UIKit
import TransitionButton


extension UIView {
  
  func addShadow(offSetX x:CGFloat, offSetY y:CGFloat, radius rad: CGFloat, opacity opct: Float){
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: x, height: y)
    self.layer.shadowRadius = rad
    self.layer.shadowOpacity = opct
    self.clipsToBounds = false
  }
  
  func addShadow(color: UIColor, offSetX x:CGFloat, offSetY y:CGFloat, radius rad: CGFloat, opacity opct: Float){
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = CGSize(width: x, height: y)
    self.layer.shadowRadius = rad
    self.layer.shadowOpacity = opct
    self.clipsToBounds = false
  }
  
}