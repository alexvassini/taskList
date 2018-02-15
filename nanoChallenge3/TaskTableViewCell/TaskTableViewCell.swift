//
//  TaskTableViewCell.swift
//  nanoChallenge3
//
//  Created by Alexandre  Vassinievski on 13/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

  @IBOutlet weak var taskName: UILabel!
  @IBOutlet weak var taskDetails: UILabel!
  @IBOutlet weak var isDoneImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func renderCell(_ task:Task ){
    taskName.text = task.name
    taskDetails.text = task.details
    isDoneImage.image = task.isDone ? #imageLiteral(resourceName: "icDoneGreen"):#imageLiteral(resourceName: "icCancelRed")
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
