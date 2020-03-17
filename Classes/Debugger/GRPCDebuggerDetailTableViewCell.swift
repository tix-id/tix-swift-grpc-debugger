//
//  GRPCDebuggerDetailTableViewCell.swift
//  Tix
//
//  Created by Wais Al Korni on 2/19/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import UIKit

final class GRPCDebuggerDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak private var contentTextView: UITextViewZeroPadding!
  
  func configure(title: String?, message: String?) {
    guard let title = title, let message = message else {
      return
    }
    
    let content = title + " " + message
    let attributedText = NSMutableAttributedString(string: content)
    attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)],
                                 range: NSRange(location: 0, length: title.count))
    
    contentTextView.attributedText = attributedText
  }
}
