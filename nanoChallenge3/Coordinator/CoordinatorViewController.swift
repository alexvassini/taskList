//
//  CoordinatorViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 07/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import TransitionButton
import ReactiveSwift
import ReactiveCocoa

protocol TaskViewController {
  
  var viewModel: CoordinatorViewModeling? { get set }
  
}

class CoordinatorViewController: UIViewController {
  
  @IBOutlet weak var forwardButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  
  let viewModel:CoordinatorViewModeling = CoordinatorViewModel()

  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    scrollView.delegate = self
    backButton.alpha = 0.0
    
    childViewControllers.forEach { (viewController) in
      if var vc = viewController as? TaskViewController {
        vc.viewModel = viewModel
        
      }
    }
    
    bindData()
  }
  
  func bindData() {
    
    let deallocSignalProducer = self.reactive.lifetime.ended.createProducer()
    viewModel.selectedTaskList.producer.take(until: deallocSignalProducer)
      .startWithValues({ [weak self] _ in
        guard let weakSelf = self else { return }
        weakSelf.moveToNextPage()
      })
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
  
  @IBAction func nextPage(_ sender: UIButton) {
    moveToNextPage()
  }
  @IBAction func back(_ sender: UIButton) {
    moveToNextPage()
  }
  
}

extension CoordinatorViewController: UIScrollViewDelegate{
  
  func moveToNextPage (){
    let pageWidth:CGFloat = self.scrollView.frame.width
    let maxWidth:CGFloat = pageWidth * 2
    let contentOffset:CGFloat = self.scrollView.contentOffset.x
    
    var slideToX = contentOffset + pageWidth
    
    if  contentOffset + pageWidth == maxWidth
    {
      slideToX = 0
    }
    self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth:CGFloat = self.scrollView.frame.width
    var contentOffset:CGFloat = self.scrollView.contentOffset.x > 0 ? self.scrollView.contentOffset.x : 0
    contentOffset = contentOffset <= pageWidth ? self.scrollView.contentOffset.x : pageWidth
 
    backButton.alpha = contentOffset/pageWidth
    forwardButton.alpha = 1 - contentOffset/pageWidth
    let titleAlphaOffset = (1 - 2 * (contentOffset/pageWidth))
    titleLabel.alpha = abs(titleAlphaOffset)
    titleLabel.text = contentOffset/pageWidth < 0.51 ? "Categorias" : "Tarefas"
    
  }
}
