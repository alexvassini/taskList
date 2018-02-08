//
//  CategoryListViewController.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 07/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

extension CategoryListViewController: UICollectionViewDelegate {
  
}

extension CategoryListViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
    
    return cell
    
  }
  
}
