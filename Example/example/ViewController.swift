//
//  ViewController.swift
//  example
//
//  Created by Wais Al Korni on 4/6/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftGRPCDebugger

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    GRPCDebuggerManager.shared.enabled = true
    becomeFirstResponder()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    var inputModel = EventsQueryEventListReq()
    inputModel.pageNumber = 1
    GRPCService.shared.connect(service: EventService.eventList(request: inputModel))
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
        return
      }
      
      GRPCDebuggerManager.shared.showDebugger(viewController: rootViewController)
    }
  }
}

