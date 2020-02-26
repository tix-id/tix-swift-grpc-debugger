//
//  UITextViewZeroPadding.swift
//  Tix
//
//  Created by Wais Al Korni on 2/20/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import UIKit

final class UITextViewZeroPadding: UITextView {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
  
  func setup() {
    textContainerInset = UIEdgeInsets.zero
    textContainer.lineFragmentPadding = 0
  }
}
