//
//  GRPCDebuggerBodyViewController.swift
//  Tix
//
//  Created by Wais Al Korni on 2/20/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import UIKit

final class GRPCDebuggerBodyViewController: UIViewController {
  
  @IBOutlet weak private var bodyTextView: UITextView!
  
  private let content: String
  private let sectionType: DebuggerSectionType
  
  init(content: String, sectionType: DebuggerSectionType) {
    self.content = content
    self.sectionType = sectionType
    
    super.init(nibName: "GRPCDebuggerBodyViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = sectionType.sectionTitle()
    bodyTextView.text = content
    
    edgesForExtendedLayout = []
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    bodyTextView.setContentOffset(.zero, animated: false)
  }
}
