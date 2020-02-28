//
//  GRPCDebuggerManager.swift
//  Tix
//
//  Created by Wais Al Korni on 2/17/20.
//  Copyright © 2020 Aliansi Teknologi Indonesia. All rights reserved.
//

import Foundation

public final class GRPCDebuggerManager {
  
  public static let shared = GRPCDebuggerManager()
  private var logs: [GRPCDebuggerModel] = [GRPCDebuggerModel]()
  
  public var enabled: Bool = false
  var logsDidUpdateHandler: (() -> Void)?
  
  let bundle = Bundle(identifier: "id.tix.SwiftGRPCDebugger")
  
  private init() {
  }
  
  func addModel(model: GRPCDebuggerModel) {
    logs.insert(model, at: 0)
    logsDidUpdateHandler?()
  }
  
  func updateModel(model: GRPCDebuggerModel) {
    for (index, listedModel) in logs.enumerated() {
      if model.identifier == listedModel.identifier {
        logs[index] = model
        logsDidUpdateHandler?()
        break
      }
    }
  }
  
  @objc func clearLogs() {
    logs.removeAll()
    logsDidUpdateHandler?()
  }
  
  func getLogs() -> [GRPCDebuggerModel] {
    return logs
  }
  
  public func showDebugger(viewController: UIViewController) {
    
    let navigationController = UINavigationController(rootViewController: GRPCDebuggerTableViewController(type: .list))
    navigationController.modalPresentationStyle = .fullScreen
    viewController.present(navigationController, animated: true, completion: nil)
  }
}
