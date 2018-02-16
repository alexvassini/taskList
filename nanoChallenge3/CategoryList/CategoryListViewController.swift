//
//  CategoryListViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 07/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class CategoryListViewController: UIViewController, TaskViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  //let model = DataModel.shared
  var viewModel:CoordinatorViewModeling? {
    didSet {
      bindData()
    }
  }
  
  var categoriesList:[Category] = []
  
  override func viewDidLoad() {
        super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    }
  
  func bindData(){
    let deallocSignalProducer = self.reactive.lifetime.ended.createProducer()
    viewModel?.categories.producer.take(until: deallocSignalProducer)
    .startWithValues({ [weak self] list in
      guard let weakSelf = self else { return }
      weakSelf.categoriesList = list
      weakSelf.collectionView.reloadData()
    })
    
  }

}


extension CategoryListViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.setCategory(indexPath.row)
    viewModel?.setTitle(title: categoriesList[indexPath.row].name)
  }
  
}

extension CategoryListViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.categoriesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
    cell.titleLabel.text = self.categoriesList[indexPath.row].name
    
    return cell
    
  }
  
}
