//
//  CoordinatorViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 07/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import TransitionButton

protocol TaskViewController {
  
  var viewModel: CoordinatorViewModeling? { get set }
  
}

class CoordinatorViewController: UIViewController {

  let viewModel:CoordinatorViewModeling = CoordinatorViewModel()

  override func viewDidLoad() {
        super.viewDidLoad()
    
    childViewControllers.forEach { (viewController) in
      if var vc = viewController as? TaskViewController {
        vc.viewModel = viewModel
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.addTransitionButton()
  }
  
  
  func addTransitionButton() {
    
    let taskButton = TransitionButton(frame: CGRect(x: self.view.center.x - 31, y: self.view.frame.size.height - 77.0, width: 62.0, height: 62.0))
    //audioButton.setImage(#imageLiteral(resourceName: "icMic"), for: .normal)
    taskButton.backgroundColor = UIColor(r: 252, g: 254, b: 255, a: 1)
    taskButton.spinnerColor = .clear
    taskButton.cornerRadius = 31.0
    taskButton.setImage(#imageLiteral(resourceName: "icEdit"), for: .normal)
    taskButton.tintColor = UIColor(r: 204, g: 71, b: 96, a: 1.0)
    taskButton.isEnabled = true
    taskButton.addShadow(offSetX: 0, offSetY: 1, radius: 2, opacity: 0.3)
    self.view.addSubview(taskButton)
    taskButton.addTarget(self, action: #selector(startTransition(_:)), for: .touchUpInside)
    taskButton.isUserInteractionEnabled = true
  }
  
  @objc func startTransition(_ button: TransitionButton){
    let fakeView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
    button.isUserInteractionEnabled = false
    button.backgroundColor = UIColor(r: 204, g: 71, b: 96, a: 0.5)
    button.startAnimation()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "addTask")
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    
    button.stopAnimation(animationStyle: .expand, completion: {
      UIView.animate(withDuration: 0.2, animations: {
        button.alpha = 0.0
      })
      self.present(vc, animated: true, completion: {
        button.removeFromSuperview()
        //fakeButton.removeFromSuperview()
        fakeView.removeFromSuperview()
        self.addTransitionButton()
      })
    })
  }
  
  
}
