//
//  GRPCDebuggerTableViewCell.swift
//  Tix
//
//  Created by Wais Al Korni on 2/18/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import UIKit

final class GRPCDebuggerTableViewCell: UITableViewCell {
  
  @IBOutlet weak private var statusLabel: UILabel!
  @IBOutlet weak private var executionTimeLabel: UILabel!
  @IBOutlet weak private var urlLabel: UILabel!
  
  func configure(model: GRPCDebuggerModel) {
    guard let statusCode = model.statusCode else {
      statusLabel.textColor = UIColor.black
      statusLabel.text = "-"
      executionTimeLabel.text = "-"
      urlLabel.text = model.method
      
      return
    }
    
    statusLabel.text = statusCode == .ok ? "Success" : "Failed"
    executionTimeLabel.text = model.executionTimeText
    urlLabel.text = model.method
    
    statusLabel.textColor = statusCode == .ok ? UIColor.green : UIColor.red
  }
}
